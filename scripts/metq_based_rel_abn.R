#!/usr/bin/env Rscript

metq_based_rel_abn=function()
{
 install_packages=function()
  {
    packages=c("doParallel","foreach","reshape2","dplyr","base","RcppArmadillo","Rcpp","RCurl","plyr","zoo","grid","gridExtra","data.table","reshape2","stringr","checkmate","base64enc","colorspace","scales","doSNOW","digest","stringi","tictoc")
    
     if(length(setdiff(packages,rownames(installed.packages())))>0)
     { 
	 
      install.packages(pkgs=setdiff(packages, rownames(installed.packages())),repos = "http://cran.us.r-project.org")  
       library(setdiff(packages, rownames(installed.packages())))  
     }
    
    lapply(packages,require,character.only=T)
  }   
  install_packages()
  args <- commandArgs(trailingOnly = TRUE)
  list_count_folders=args[1]
  cnt_folders=args[2]
  path_to_home=args[3]
  
  library("dplyr")
  library("stringr")
  # geneLenPath="/naslx/projects/pr74xe/di52yal/Amira_results/count_new_90_megaHIT/"
  # list_genLen=list.files(path = geneLenPath,pattern = "geneLen")
  
  list_count_files=list.files(path = list_count_folders,pattern = "_bbmap_fin")
  ghost_path=str_c(path_to_home,"/Metwaly-et-al.-2020/Data/Functional Profile/GhostKOALA_results/")
  # ghost_path="/path/to/Data/Functional Profile/GhostKOALA_results/"
  
  list_contig2ko_file=list.files(path = ghost_path,pattern = "user_ko_definition.txt",recursive = T)
  mod_location=str_c(path_to_home,"/Metwaly-et-al.-2020/Data/Functional Profile/module")
  modules_ko=read.csv(file = mod_location,header = F,sep = "\t")
  modules_ko[,1]=str_replace_all(string = modules_ko[,1],pattern = "md:",replacement = "")
  modules_ko[,2]=str_replace_all(string = modules_ko[,2],pattern = "ko:",replacement = "")
  module2ko=modules_ko
  
  ###### condition ID to map samples IDs to conditions:
  contig2ko_short=str_replace_all(string = list_contig2ko_file,pattern = "_file/.*",replacement = "")
  countFile_short=str_replace_all(string = list_count_files,pattern = "_.*",replacement = "")
  
  unq_ko=unique(modules_ko[,2])
  
  k=1
  
  for(jj in 1:length(contig2ko_short))
  {
    ll=list_count_files[grep(pattern = str_c("^",contig2ko_short[jj]),x = countFile_short)]
    genLen_fl=fread(str_c(geneLenPath,contig2ko_short[jj],"_geneLen"),header = F,sep="\t")
    colnames(genLen_fl)=c("Contig","Length")
    mm=fread(file = str_c(ghost_path,list_contig2ko_file[jj]),sep = "\t",header = F)
    ctg2ko_req=fread(file = str_c(ghost_path,list_contig2ko_file[jj]),sep = "\t",header = F)
    
  
    
    for(i in 1: length(ll))
    {
      cnt_file=fread(file = str_c(cnt_folders,ll[i]),header = F,sep = "\t")
      colnames(cnt_file)=c("Count","Contig","None")
  
      colnames(ctg2ko_req)=c("Contig","KO","Gene","Score","SecondKO","SecondScore")
      ctg2ko_req=ctg2ko_req[which(ctg2ko_req$Score>=100),]
      
      mergedData=merge(x = cnt_file,y = ctg2ko_req,by="Contig",all.x=TRUE)
      mergedData1=merge(x = mergedData,y=genLen_fl,by="Contig")    
      mergedData$Count[is.na(mergedData$Count)]=0
      
      
      res1 <- mergedData[-which(mergedData$KO==""),] %>%
        group_by(KO) %>% 
        summarise(KO_Count=sum(Count))
      res2 <- mergedData1[-which(mergedData1$KO==""),] %>%
        group_by(KO) %>% 
        summarise(KO_Count_Len_norm=sum(Count)/sum(Length))
      
      
      
      
      if(k==1)
      {
        ko_raw_mat=res1[,c("KO","KO_Count")]
        colnames(ko_raw_mat)=c("KO",ll[i])
        ko_norm_mat=res2[,c("KO","KO_Count_Len_norm")]
        colnames(ko_norm_mat)=c("KO",str_c(ll[i],"_Norm"))
       # ko_norm_mat[,str_c(ll[i],"_Norm")]=ko_norm_mat[,str_c(ll[i],"_Norm")]/sum(ko_norm_mat[,str_c(ll[i],"_Norm")])
        
        
        } else {
          ko_raw_mat=merge(x = ko_raw_mat,y = res1,by="KO",all.x=TRUE,all.y=TRUE)
          colnames(ko_raw_mat)[ncol(ko_raw_mat)]=ll[i]
          # ko_raw_mat=ko_raw_mat[-which(ko_raw_mat==""),]
           
          ko_norm_mat=merge(x = ko_norm_mat,y = res2,by="KO",all.x=TRUE,all.y=TRUE)
          colnames(ko_norm_mat)[ncol(ko_norm_mat)]=ll[i]
          # ko_norm_mat=ko_norm_mat[-which(ko_norm_mat==""),]
          
      }
      
    k=k+1  
    }
    
  }
  
  ###################
  ###################
  ### Data Preparation for Active vs Remission-responder vs Remission-nonresponder:
  ###################
  
  ko_raw_mat[is.na(ko_raw_mat)]=0
  colnames(modules_ko)=c("Module","KO")
  ko_raw_mat_mod=merge(modules_ko,ko_raw_mat,by="KO")
  module_mat=ko_raw_mat_mod[,c(which(colnames(ko_raw_mat_mod)=="Module"),grep(pattern = "_bbmap_fin",x=colnames(ko_raw_mat_mod)))] %>% group_by(Module) %>% summarise_all(.funs = sum)
  
  module_mat_id=module_mat
  qq=query_output$METADATA
  colnames(qq)[1]="Module"
  
  ### Remove Modules that are completely eukaryotic: 
  module_mat=merge(qq,module_mat_id,by="Module")
  euk_modules=c("M00403","M00400","M00389","M00366","M00367","M00359","M00296","M00141","M00135","M00085","M00079","M00078","M00077","M00076","M00047")
  prok_modules=setdiff(module_mat$Module,euk_modules)
  module_mat=module_mat[match(prok_modules,module_mat$Module),]
  
  module_mat$Classes=apply(module_mat[,c("CLASS_I","CLASS_II","CLASS_III","Module")],1,function(x){str_c(x,collapse="|")})
  module_mat$Classes=str_c(module_mat$Classes,"_",module_mat$NAME_SHORT)
  module_matrix=as.matrix(module_mat[,grep(pattern = "_bbmap_fin",x=colnames(module_mat))])
  
  
  rownames(module_matrix)=as.character(module_mat$Classes)
  module_matrix=module_matrix[-c(grep(pattern = "ukary",x=rownames(module_matrix)),grep(pattern = "eratan|eparan|ermatan|hondroitin|reatine",x=rownames(module_matrix))),]
  module_rel_abn=apply(module_matrix,2,function(x){x/sum(x)})
  # module_rel_abn=module_rel_abn[-c(grep(pattern = "ukary",x=rownames(module_rel_abn)),grep(pattern = "Keratan|Heparan|Dermatan|Chondroitin",x=rownames(module_rel_abn))),]
  
  grp_samples=c("Remission-Responder","Remission-Responder","Relapse-non-responder","Relapse-non-responder","Baseline-Active","Relapse-non-responder","Baseline-Active","Baseline-Active","Remission-Responder","Remission-Responder",rep("Remission-Responder",3),rep("Relapse-non-responder",3),rep("Baseline-Active",3),rep("Baseline-Active",3),rep("Relapse-non-responder",3),rep("Remission-Responder",3))
  
  # module_matrix=module_matrix[-c(grep(pattern = "ukary",x=rownames(module_matrix)),grep(pattern = "eratan|eparan|ermatan|hondroitin",x=rownames(module_matrix))),]
  # |Cell signaling|Genetic information processing
  module_16T106=apply(module_matrix[,1:2],1,sum)
  module_16TM29=apply(module_matrix[,3:4],1,sum)
  
  module_28T0=apply(module_matrix[,7:8],1,sum)
  module_28T52=apply(module_matrix[,9:10],1,sum)
  
  module_human=cbind(module_16T106,module_16TM29,module_matrix[,5:6],module_28T0,module_28T52)
  colnames(module_human)=c("16T106","16TM29","27T0","27T39","28T0","28T52")
  
  module_human_rel=apply(as.matrix(module_human),2,function(x){x/sum(x)})
  mod_hm_rel_df=as.data.frame(module_human_rel)
  mod_hm_rel_df$Module=rownames(mod_hm_rel_df)
  mod_hm_rel_df$Module=str_replace_all(string = mod_hm_rel_df$Module,pattern = ",",replacement = "_")
  mod_hm_rel_df$Module=str_replace_all(string = mod_hm_rel_df$Module,pattern = " ",replacement = "_")
  
  mod_lefse=module_rel_abn
  colnames(mod_lefse)=str_replace_all(string = colnames(mod_lefse),pattern = "_map.*",replacement = "")
  mod_lefse1=cbind(rownames(mod_lefse),mod_lefse)
  colnames(mod_lefse1)[1]="ID"
  mod_lefse1=rbind(trim_melt$Donor_Disease_status[match(colnames(mod_lefse1),as.character(trim_melt$Samples))],mod_lefse1)
 
  mod_lefse1_mouse=mod_lefse1[,-grep(pattern = "^16|^27|^28",x=colnames(mod_lefse1))]
  mod_lefse1_mouse[is.na(mod_lefse1_mouse)]="Class"
  dat_location=str_c(path_to_home,"/Metwaly-et-al.-2020/Data/humanised_KEGG_modules_profile.csv")
  write.table(mod_lefse1_mouse,dat_location,quote=F,sep = "\t",row.names = F,col.names = T)
      
}

metq_based_rel_abn()


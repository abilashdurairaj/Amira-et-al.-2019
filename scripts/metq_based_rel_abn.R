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
  ghost_path=str_c(path_to_home,"/Data/Functional Profile/GhostKOALA_results/")
  # ghost_path="/path/to/Data/Functional Profile/GhostKOALA_results/"
  
  list_contig2ko_file=list.files(path = ghost_path,pattern = "user_ko_definition.txt",recursive = T)
  mod_location=str_c(path_to_home,"/Data/Functional Profile/module")
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
  dat_location=str_c(path_to_home,"/Data/humanised_KEGG_modules_profile.csv")
  write.table(mod_lefse1_mouse,dat_location,quote=F,sep = "\t",row.names = F,col.names = T)
      
}

metq_based_rel_abn()


##### Supplementary figure 5:
## KEGG ortholog- level comparison of expression profile for KEGG Module signatures obtained from LefSe analysis  
#####
  sulfonateTS_M00436=c("K15553","K15554","K15555")
  cysteineBS_M00021=c("K00640","K01738","K12339","K13034","K17069")
  glutathionBS_M00118=c("K11204","K11205","K01919")
  assm_sulfate_M00176=c("K13811","K00958","K00860","K00955","K00957","K00956","K00957","K00860" ,"K00390" ,"K00380","K00381","K00392")
  dissm_sulfate_M00596=c("K00956","K00957","K00958", "K00394","K00395" ,"K11180","K11181")
  methionineTS_M00238=c("K02073","K02072","K02071")
  taurineTS_M00435=c("K15551","K15552","K10831")
  
  sulf_ko=c(taurineTS_M00435,sulfonateTS_M00436,cysteineBS_M00021,assm_sulfate_M00176,dissm_sulfate_M00596)
  names(sulf_ko)=c(rep("taurineTS_M00435",length(taurineTS_M00435)),rep("sulfonateTS_M00436",length(sulfonateTS_M00436)),rep("cysteineBS_M00021",length(cysteineBS_M00021)),rep("assm_sulfate_M00176",length(assm_sulfate_M00176)),rep("dissm_sulfate_M00596",length(dissm_sulfate_M00596)))
  ko_raw_mat1=as.matrix(ko_raw_mat[,-1])
  rownames(ko_raw_mat1)=as.character(ko_raw_mat$KO)
  ko_rel_abn=apply((ko_raw_mat1+0.1),2,function(x){x/sum(x)})
  
  sulf_req_ko=ko_rel_abn[intersect(c(methionineTS_M00238,taurineTS_M00435,sulfonateTS_M00436,cysteineBS_M00021,assm_sulfate_M00176,dissm_sulfate_M00596),rownames(ko_rel_abn)),]
  sul_req_df=as.data.frame(sulf_req_ko)
  sul_req_df$KO=rownames(sulf_req_ko)
  sul_req_melt=melt(sul_req_df,id="KO")
  sul_req_melt=sul_req_melt[-grep(pattern = "^16|^27|^28",x=sul_req_melt$variable),]
  sul_req_melt$variable=str_replace_all(string = sul_req_melt$variable,pattern = "_mapped.*",replacement = "")
  sul_req_melt$Donor=trim_melt$Donor_Disease_status[match(sul_req_melt$variable,as.character(trim_melt$Samples))]
  sul_req_melt$logVal=log2(sul_req_melt$value)
  sul_req_melt$Mod=names(sulf_ko)[match(sul_req_melt$KO,sulf_ko)]
  sul_req_melt=sul_req_melt[order(sul_req_melt$Mod,sul_req_melt$KO),]
  sul_req_melt$KO <- factor(sul_req_melt$KO, levels = sul_req_melt$KO)
  
  
  my_comparisons <- list( c("Inflamed", "Intermediate-inflamed"), c("Inflamed", "Non-inflamed") ,c("Non-inflamed", "Intermediate-inflamed"),c("NO_human","YES_human"))
  my_comparisons <- list( c("Baseline-Active", "Relapse-non-responder"), c("Baseline-Active", "Remission-Responder") ,c("Remission-Responder", "Relapse-non-responder"))
  
  library("ggplot2")
  ggplot(sul_req_melt[(sulfonateTS_M00436 %in% sul_req_melt$KO),])+geom_boxplot(aes(y=(value),x=KO,fill=Donor))
  
  library("ggpubr")
  ##### sulfonate
  p <- ggboxplot(sul_req_melt[(sul_req_melt$KO %in% sulfonateTS_M00436),], x = "KO", y = "logVal",
                 fill = "Donor",
                 add = "jitter",size = 0.05)
  
  p+ stat_compare_means(label.y = 0) +
 #   stat_compare_means(comparisons = my_comparisons, label.y = c(0.1, 0.3, 0.5)) + #  +
    ggsave("Amira_func_sulfonate.svg",width = 10,height = 6,limitsize = F)
  
  ##### assimilatory sulfate:
  p <- ggboxplot(sul_req_melt[(sul_req_melt$KO %in% assm_sulfate_M00176),], x = "KO", y = "logVal",
                 fill = "Donor",
                 add = "jitter",size = 0.05)
  
  p+ stat_compare_means(label.y = 0) +
    #    stat_compare_means(comparisons = my_comparisons, label.y = c(0.1, 0.3, 0.5)) + #  +
    ggsave("Amira_func_ass_sulf.svg",width = 10,height = 6,limitsize = F)
  
  ##### dissimilatory sulfate:
  p <- ggboxplot(sul_req_melt[(sul_req_melt$KO %in% dissm_sulfate_M00596),], x = "KO", y = "logVal",
                 fill = "Donor",
                 add = "jitter",size = 0.05)
  
  p+ stat_compare_means(label.y = 0) +
    #    stat_compare_means(comparisons = my_comparisons, label.y = c(0.1, 0.3, 0.5)) + #  +
    ggsave("Amira_func_diss_sulf.svg",width = 10,height = 6,limitsize = F)
  
  ##### taurine:
  p <- ggboxplot(sul_req_melt[(sul_req_melt$KO %in% taurineTS_M00435),], x = "KO", y = "logVal",
                 fill = "Donor",
                 add = "jitter",size = 0.05)
  
  p+ stat_compare_means(label.y = 0) +
    #    stat_compare_means(comparisons = my_comparisons, label.y = c(0.1, 0.3, 0.5)) + #  +
    ggsave("Amira_func_taurine.svg",width = 10,height = 6,limitsize = F)
  
  
  ##### methionine:
  p <- ggboxplot(sul_req_melt[(sul_req_melt$KO %in% methionineTS_M00238),], x = "KO", y = "logVal",
                 fill = "Donor",
                 add = "jitter",size = 0.05)
  
  p+ stat_compare_means(label.y = 0) +
    #    stat_compare_means(comparisons = my_comparisons, label.y = c(0.1, 0.3, 0.5)) + #  +
    ggsave("Amira_func_methionine.svg",width = 10,height = 6,limitsize = F)
  
  
  compare_means(value ~ Donor,group.by = "KO",data = sul_req_melt[which(sul_req_melt$KO=="K15554"),],ref.group = "Baseline-Active")
  all_cmp_val=compare_means(value ~ Donor,group.by = "KO",data = sul_req_melt)
  
 
  ##### cysteine:
  p <- ggboxplot(sul_req_melt[(sul_req_melt$KO %in% cysteineBS_M00021),], x = "KO", y = "logVal",
                 fill = "Donor",
                 add = "jitter",size = 0.05)
  
  p+ stat_compare_means(label.y = 0) +
    #    stat_compare_means(comparisons = my_comparisons, label.y = c(0.1, 0.3, 0.5)) + #  +
    ggsave("Amira_func_cysteine.svg",width = 10,height = 6,limitsize = F)
  
  
  compare_means(value ~ Donor,group.by = "KO",data = sul_req_melt[which(sul_req_melt$KO=="K15554"),],ref.group = "Baseline-Active")
  all_cmp_val=compare_means(value ~ Donor,group.by = "KO",data = sul_req_melt[c(which(sul_req_melt$KO=="K15553"),which(sul_req_melt$KO=="K15554"),which(sul_req_melt$KO=="K15555")),])
  
   
   
   
   ### Methionine TS:
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K02073"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
    
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K02072"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K02071"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   
   ### Sulfonate TS:
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K15553"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K15554"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K15555"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   
   ### Taurine TS:
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K10831"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K15551"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K15552"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   
   ### Cysteine from serine:
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00640"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K01738"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K12339"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   
   ### Assimilatory sulfur:
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00380"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00381"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00390"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00860"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00955"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00956"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00957"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00958"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   #### Dissimilatory sulf:
     
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00956"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00957"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00958"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00394"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K00395"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K11180"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   plant.lm <- lm(value ~ Donor, data = sul_req_melt[which(sul_req_melt$KO=="K11181"),])
   plant.av <- aov(plant.lm)
   summary(plant.av)
   
   tukey.test <- TukeyHSD(plant.av)
   tukey.test
   
   
   
   ##### Supplementary figure 
   ### Ternary plot:
   
   sigf_infl_vs_noninfl=read.csv(file = "/path/to/Data/Functional Profile/LDA_Effect_Size_(LEfSe)_on_humanised_KEGG_Module_profile",header = F,sep = "\t")
   sigf_infl_vs_noninfl$V5=as.numeric(as.character(sigf_infl_vs_noninfl$V5))
   sigf_infl_vs_noninfl$V5[is.na(sigf_infl_vs_noninfl$V5)]=1
   
   module_human1=module_human
   module_human1=module_human1[-c(grep(pattern = "Photo|DNA poly|Rep|Proteas|Splice|Aminoacyl|Ubiq|RNA proc|Protein proc|Plant|Cell sig|Biosynthesis of secon|Ribosome",x=rownames(module_human1))),]
   
   
   rownames(module_human1)=str_replace_all(string = rownames(module_human1),pattern = ".*\\|",replacement = "")
   rownames(module_human1)=str_replace_all(string = rownames(module_human1),pattern = "_.*",replacement = "")
   
   mm1_sigf=as.character(sigf_infl_vs_noninfl$V1)[which(sigf_infl_vs_noninfl$V5<=0.05)]
   mm1_sigf=str_replace_all(string = mm1_sigf,pattern = "\\.",replacement = "|")
   mm1_sigf_hf=str_replace_all(string = mm1_sigf,pattern = ".*\\|",replacement = "")
   mm1_sigf_hf=str_replace_all(string = mm1_sigf_hf,pattern = "_.*",replacement = "")
   mm1_sigf_hf=mm1_sigf_hf[grep(pattern = "M00",x=mm1_sigf_hf)]
   module_hm_rel=apply(module_human1,2,function(x){x/sum(x)})
   
   module_baseline=apply(module_hm_rel[intersect(mm1_sigf_hf,rownames(module_hm_rel)),which(trim_melt$Donor_Disease_status[match(colnames(module_hm_rel),str_replace_all(trim_melt$Samples,pattern = "_.*",replacement = ""))]=="Baseline-Active")],1,median)
   module_remission=apply(module_hm_rel[intersect(mm1_sigf_hf,rownames(module_hm_rel)),which(trim_melt$Donor_Disease_status[match(colnames(module_hm_rel),str_replace_all(trim_melt$Samples,pattern = "_.*",replacement = ""))]=="Remission-Responder")],1,median)
   module_relapse=apply(module_hm_rel[intersect(mm1_sigf_hf,rownames(module_hm_rel)),which(trim_melt$Donor_Disease_status[match(colnames(module_hm_rel),str_replace_all(trim_melt$Samples,pattern = "_.*",replacement = ""))]=="Relapse-non-responder")],1,median)
   
   
   sig_df=data.frame(Baseline=module_baseline,Remission=module_remission,Relapse=module_relapse)
   sig_df$Modules=intersect(mm1_sigf_hf,rownames(module_hm_rel))
   
   sig_df$Module_short=query_output$METADATA$NAME_SHORT[match(as.character(sig_df$Modules),as.character(query_output$METADATA$MODULE_ID))]
   
   sig_df$Mod_hrchy=qop$mod_all[match(as.character(sig_df$Modules),as.character(qop$MODULE_ID))]
   
   sig_df$Func_category=query_output$METADATA$CLASS_III[match(sig_df$Modules,query_output$METADATA$MODULE_ID)]
   # sig_df=sig_df[-c(grep(pattern = "Photo|DNA poly|Rep|Proteas|Splice|Aminoacyl|Ubiq|RNA proc|Protein proc|Plant|Cell sig|Biosynthesis of secon",x=sig_df$Func_category)),]
   # sig_df$Abundance=apply(sig_df[,1:3],1,median)
   
   sig_df$Abundance=apply(module_hm_rel[intersect(mm1_sigf_hf,rownames(module_hm_rel)),c(which(trim_melt$Donor_Disease_status[match(colnames(module_hm_rel),str_replace_all(trim_melt$Samples,pattern = "_.*",replacement = ""))]=="Baseline-Active"),
                                         which(trim_melt$Donor_Disease_status[match(colnames(module_hm_rel),str_replace_all(trim_melt$Samples,pattern = "_.*",replacement = ""))]=="Remission-Responder"),
                                         which(trim_melt$Donor_Disease_status[match(colnames(module_hm_rel),str_replace_all(trim_melt$Samples,pattern = "_.*",replacement = ""))]=="Relapse-non-responder"))],1,median)
    
   library(ggtern)
   library(dplyr)
   library("RColorBrewer")
   #Load the data
   
   #Pick colors for phyla
   COG_hm<-c("#4D0742","#65E000","#0000FF","#FFFC99","#FF0000",

              "#C18CEB","#FFD6DD","#008000","#D2FE3B","#B137A5",

              "#00FFFF","#EE895A","#5C3317","#64ed71","#A1CAF1",

              "#FF4B1F","#FFD700","#92bd84","#FF00FF","#E0E0E0",

              "#38ABA3","#C2B280","#2B3D26","#E84E71","#306CAB",

              "#604841","#e25822","#848482","#FFA500","#006b60",

         "#222222" ,"#209ABA") #"#06E2A8"
   # COG=str_to_lower(terrain.colors(n = length(unique(sig_df$Func_category))))
   names(COG_hm)=unique(sig_df$Func_category)
   
   # names(COG)=unique(sig_df$Func_category)
   # names(COG)<-c("H", "V", "E", "T", "G", "L", "O", "C", "K", "Q", "M", "S", "I", "P",
   #               "N", "D", "J", "U")
   
   #Create a color scale
   myScale_points <- scale_fill_manual(name="COG", 
                                       values=COG_hm)
   myScale_labels <- scale_color_manual(name="COG", values=names(COG_hm))
   
   #Plot the data with dots
   p <-ggtern(data=sig_df,
              aes(Baseline, Remission,Relapse,fill = Func_category)) +
     theme_bw()+
     theme_nogrid_minor() +
     #theme_nogrid()+
     theme(legend.text=element_text(size=10)) +
     theme(text = element_text(size=8)) + theme_showarrows()+
     geom_point(aes(size=Abundance), shape = 21, alpha = 0.90, color = "black") +
     scale_size(range=range(sig_df$Abundance*1200), breaks =seq(0,max(sig_df$Abundance),length.out =10)) +
     myScale_points 
   
   
   p
   
   p+ ggsave( 
          file = "ternary_mouse.svg", 
#           useDingbats=FALSE, 
          width=25, 
          height=14, 
          dpi=1200, 
          limitsize = F)
   
   
   
   
   
   

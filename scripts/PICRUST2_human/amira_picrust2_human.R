#!/usr/bin/env Rscript

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
  path_to_home=args[1]


library("stringr")
ko_abn=read.csv(file = str_c(path_to_home,"/Metwaly-et-al.-2020/Data/PICRUST2_human/pred_metagenome_unstrat.tsv"),header = T,sep = "\t")
amira_metadata=read.csv(file = str_c(path_to_home,"/Metwaly-et-al.-2020/Data/PICRUST2_human/Mappingfile-human.csv"),header = T,sep = ",")
colnames(ko_abn)=str_replace_all(str_replace_all(string = colnames(ko_abn),pattern = "^X",replacement = ""),pattern = "\\.",replacement = "-")

install.packages(str_c(path_to_home,"/Metwaly-et-al.-2020/Data/Functional Profile/MetQy_1.0.1.tar.gz",repos = NULL, type="source")

library("MetQy")
modules_ko=read.csv(file = str_c(path_to_home,"/Metwaly-et-al.-2020/Data/Functional Profile/module"),header = F,sep = "\t")
modules_ko[,1]=str_replace_all(string = modules_ko[,1],pattern = "md:",replacement = "")
modules_ko[,2]=str_replace_all(string = modules_ko[,2],pattern = "ko:",replacement = "")
all_modules=unique(modules_ko[,1])
AD_modules   <- all_modules

query_output <- query_genomes_to_modules(GENOME_INFO = "Bacteria",MODULE_ID = AD_modules,META_OUT = T,ADD_OUT = T)



# OUT <- tryCatch(query_missingGenes_from_module(nn_ko,all_modules[j]),error=function(x){NA})

###
unq_mod=all_modules
all_mod_rel=matrix(0,nrow=length(unq_mod),ncol=(ncol(ko_abn)-1))
rownames(all_mod_rel)=unq_mod
colnames(all_mod_rel)=colnames(ko_abn)[-1]


for(i in 1:nrow(all_mod_rel))
{
  unq_ko=intersect(ko_abn$`function-`,modules_ko[which(modules_ko[,1]==unq_mod[i]),2])
  
  if(length(unq_ko)>1)
  {
    sum1=apply(ko_abn[match(unq_ko,ko_abn$`function-`),-1],2,sum)
    all_mod_rel[i,]=unlist(sum1[match(colnames(all_mod_rel),names(sum1))])
    
  }
  if(length(unq_ko)==1)
  {
    sum1=ko_abn[match(unq_ko,ko_abn$`function-`),]
    all_mod_rel[i,]=unlist(sum1[match(colnames(all_mod_rel),names(sum1))])
  }
  
}

all_mod_rel_abn=apply(all_mod_rel,2,function(x){x/sum(x)})
# all_mod_rel_abn=all_mod_rel
all_mod_df=data.frame(Modules=rownames(all_mod_rel_abn))
all_mod_df=cbind(as.character(all_mod_df$Modules),all_mod_rel_abn)
colnames(all_mod_df)[1]="Modules"
all_mod_df=rbind(as.character(amira_metadata$Status[match(colnames(all_mod_df),amira_metadata$NAME)]),all_mod_df)


all_mod_df2=(all_mod_df[,-grep(pattern = "Baseline|CONTROL1",x=all_mod_df[1,])])

aa=query_output$METADATA$NAME_SHORT[match(all_mod_df2[,"Modules"],query_output$METADATA$MODULE_ID)]
aa[which(is.na(aa))]=""
all_mod_df2[1:5,"Modules"]
aa=str_c(all_mod_df2[,"Modules"],aa,sep="_")
all_mod_df2[,"Modules"]=aa

all_mod_df2=all_mod_df2[-c(grep(pattern = "ukary",x=all_mod_df2[,"Modules"]),grep(pattern = "eratan|eparan|ermatan|hondroitin|reatine",x=all_mod_df2[,"Modules"])),]
euk_modules=c("M00403","M00400","M00389","M00366","M00367","M00359","M00296","M00141","M00135","M00085","M00079","M00078","M00077","M00076","M00047")
rm_modules=c("Spliceosome","Proteasome","zeta_complex","GPI-anchor_biosynthesis","Sterol","N-glycan_biosynthesis,_complex_type","Ergocalciferol","Sphingosine","Ubiquitin_system","cortisol","Cell_signaling","RNA_processing","Dermatan","Chondroitin","plant","Photorespiration","Keratan","NADH_dehydrogenase_(ubiquinone)_Fe-S_protein/flavoprotein_complex","Repair_system","Inositol_phosphate_metabolism,_from_Ins(1,3,4,5)P4","Creatin","beta-Carotene","Heparan","Replication_system","N-glycan_precursor_trimming","eukaryotes","RNA_polymerase","Protein_processing","Heparan")

all_mod_df2=all_mod_df2[-grep(pattern = str_c(c(euk_modules,rm_modules,str_c("M00",378:415),str_c("M00",288:297),str_c("M000",66:75)),collapse = "|"),x=all_mod_df2[,"Modules"]),]

write.table(all_mod_df2[,-c(82,97)],str_c(path_to_home,"/Metwaly-et-al.-2020/Data/PICRUST2_human/picrust2_16S_norm_rel_abnv2.csv"),quote = F,sep = "\t",row.names = F)

#### Upload this file for LefSe analysis.


############### PLotting LefSe analysis
rr=read.csv(file = str_c(path_to_home,"/Metwaly-et-al.-2020/Data/PICRUST2_human/LDA_Effect_Size_active_plus_baseline_vs_inactive_human.lefse_internal_res"),header = F,sep = "\t")
colnames(rr)=c("Modules","Orig_log2FC","Condition","Norm_Log2FC","pval")
library("ggplot2")

rr$Norm_Log2FC[is.na(rr$Norm_Log2FC)]=0
rr$Condition=as.character(rr$Condition)
rr$Condition[which(rr$Condition=="")]="None"
rr$Modules=as.character(rr$Modules)

rr$Modules[grep(pattern = "M00841",x=rr$Modules)]="M00841_Tetrahydrofolate_biosynthesis"
rr$Modules[grep(pattern = "M00842",x=rr$Modules)]="M00842_Tetrahydrobiopterin_biosynthesis"
rr$Modules[grep(pattern = "M00843",x=rr$Modules)]="M00843_L_threo_Tetrahydrobiopterin_biosynthesis"

rr$Norm_Log2FC[which(rr$Condition=="Active post-HSCT")]=(-1)*rr$Norm_Log2FC[which(rr$Condition=="Active post-HSCT")]
rr$abs_Norm_log2FC=abs(rr$Norm_Log2FC)

rr$abs_Norm_log2FC=abs(rr$Norm_Log2FC)
rr$Norm_Log2FC[is.na(rr$Norm_Log2FC)]=0
rr$Norm_Log2FC=as.numeric(rr$Norm_Log2FC)
rr$pval=as.character(rr$pval)
rr$pval[which(rr$pval=="-")]=1
rr$pval=as.numeric(rr$pval)
rr$abs_Norm_log2FC=as.character(rr$abs_Norm_log2FC)
rr$abs_Norm_log2FC[which(is.na(rr$abs_Norm_log2FC))]=0
rr$abs_Norm_log2FC=as.numeric(rr$abs_Norm_log2FC)



ggplot(rr[abs(rr$Norm_Log2FC)>=2,])+geom_bar(aes(y=Norm_Log2FC,x=reorder(Modules,Norm_Log2FC),fill=Condition),stat="identity")+ theme_bw()+coord_flip()+ggsave("amira_picrust2_results.svg",width = 8,height = 15,limitsize = F)



library("stringr")
ko_abn=read.csv(file = "E:/humanized_PICRUST2/picrust2_res/picrust2_out_pipeline_edited/KO_metagenome_out/pred_metagenome_unstrat.tsv/pred_metagenome_unstrat.tsv",header = T,sep = "\t")
amira_metadata=read.csv(file = "E:/humanized_PICRUST2/mapping-file picrust.txt",header = T,sep = "\t")
colnames(ko_abn)=str_replace_all(str_replace_all(string = colnames(ko_abn),pattern = "^X",replacement = ""),pattern = "\\.",replacement = "-")

library("MetQy")
modules_ko=read.csv(file = "E:/module",header = F,sep = "\t")
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
all_mod_rel_abn=all_mod_rel
all_mod_df=data.frame(Modules=rownames(all_mod_rel_abn))
all_mod_df=cbind(as.character(all_mod_df$Modules),all_mod_rel_abn)
colnames(all_mod_df)[1]="Modules"
all_mod_df=rbind(as.character(amira_metadata$DA[match(colnames(all_mod_df),amira_metadata$X.SampleID)]),all_mod_df)

all_mod_df2=all_mod_df

aa=query_output$METADATA$NAME_SHORT[match(all_mod_df2[,"Modules"],query_output$METADATA$MODULE_ID)]
aa[which(is.na(aa))]=""
all_mod_df2[1:5,"Modules"]
aa=str_c(all_mod_df2[,"Modules"],aa,sep="_")
all_mod_df2[,"Modules"]=aa

all_mod_df2=all_mod_df2[-c(grep(pattern = "ukary",x=all_mod_df2[,"Modules"]),grep(pattern = "eratan|eparan|ermatan|hondroitin|reatine",x=all_mod_df2[,"Modules"])),]
euk_modules=c("M00403","M00400","M00389","M00366","M00367","M00359","M00296","M00141","M00135","M00085","M00079","M00078","M00077","M00076","M00047")
rm_modules=c("Spliceosome","Proteasome","zeta_complex","GPI-anchor_biosynthesis","Sterol","N-glycan_biosynthesis,_complex_type","Ergocalciferol","Sphingosine","Ubiquitin_system","cortisol","Cell_signaling","RNA_processing","Dermatan","Chondroitin","plant","Photorespiration","Keratan","NADH_dehydrogenase_(ubiquinone)_Fe-S_protein/flavoprotein_complex","Repair_system","Inositol_phosphate_metabolism,_from_Ins(1,3,4,5)P4","Creatin","beta-Carotene","Heparan","Replication_system","N-glycan_precursor_trimming","eukaryotes","RNA_polymerase","Protein_processing","Heparan")

all_mod_df2=all_mod_df2[-grep(pattern = str_c(c(euk_modules,rm_modules,str_c("M00",378:415),str_c("M00",288:297),str_c("M000",66:75)),collapse = "|"),x=all_mod_df2[,"Modules"]),]
all_mod_df2=all_mod_df2[,setdiff(colnames(all_mod_df2),c(as.character(seq(1,6,by=1)),c("S3","S6","S7")))]
all_mod_df2[1,grep(pattern = "Baseline",x=all_mod_df2[1,])]="Active post-HSCT"
all_mod_df2[1,grep(pattern = "Active post-HSCT",x=all_mod_df2[1,])]="Active"
all_mod_df2[1,grep(pattern = "Inactive post-HSCT",x=all_mod_df2[1,])]="Inactive"

write.table(all_mod_df2,"E:/humanized_PICRUST2/LefSe_analysis/picrust2_16S_norm_norel_abnv2_humanized_active_vs_inactive.csv",quote = F,sep = "\t",row.names = F)
## replace NA with Condition. Load this to LefSe online..

rr=read.csv(file = "E:/humanized_PICRUST2/LefSe_analysis/LDA_Effect_Size_active_plus_baseline_vs_inactive.lefse_internal_res",header = F,sep = "\t")
colnames(rr)=c("Modules","Orig_log2FC","Condition","Norm_Log2FC","pval")
library("ggplot2")

rr$Norm_Log2FC[is.na(rr$Norm_Log2FC)]=0
rr$Condition=as.character(rr$Condition)
rr$Condition[which(rr$Condition=="")]="None"
rr$Modules=as.character(rr$Modules)

rr$Modules[grep(pattern = "M00841",x=rr$Modules)]="M00841_Tetrahydrofolate_biosynthesis"
rr$Modules[grep(pattern = "M00842",x=rr$Modules)]="M00842_Tetrahydrobiopterin_biosynthesis"
rr$Modules[grep(pattern = "M00843",x=rr$Modules)]="M00843_L_threo_Tetrahydrobiopterin_biosynthesis"
rr$Modules[grep(pattern = "M00854",x=rr$Modules)]="M00854_Glycogen_biosynthesis"
rr$Modules[grep(pattern = "M00846",x=rr$Modules)]="M00846_Siroheme_biosynthesis,glutamate_to_siroheme"
rr$Modules[grep(pattern = "M00848",x=rr$Modules)]="M00848_Aurachin_biosynthesis,anthranilate_to_aurachinA"
rr$Modules[grep(pattern = "M00849",x=rr$Modules)]="M00849_C5_isoprenoid_biosynthesis,mevalonate_pathway,archaea"

rr$Norm_Log2FC[which(rr$Condition=="Inactive")]=(-1)*rr$Norm_Log2FC[which(rr$Condition=="Inactive")]
rr$abs_Norm_log2FC=abs(rr$Norm_Log2FC)
rr1=rr[sort(rr$abs_Norm_log2FC,decreasing = T,index.return=T)$ix[1:102],]
ggplot(rr1)+geom_bar(aes(y=Norm_Log2FC,x=reorder(Modules,Norm_Log2FC),fill=Condition),stat="identity")+ theme_bw()+coord_flip()+ggsave("E:/humanized_PICRUST2/LefSe_analysis/amira_picrust2_results_all102_humanized.svg",width = 8,height = 15,limitsize = F)

rr1=rr[sort(rr$abs_Norm_log2FC,decreasing = T,index.return=T)$ix[1:70],]
ggplot(rr1)+geom_bar(aes(y=Norm_Log2FC,x=reorder(Modules,Norm_Log2FC),fill=Condition),stat="identity")+ theme_bw()+coord_flip()+ggsave("E:/humanized_PICRUST2/LefSe_analysis/amira_picrust2_results_top10percent_humanized.svg",width = 8,height = 15,limitsize = F)

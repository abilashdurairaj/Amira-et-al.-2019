CAT_tax_count=function()
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
  cnt_path=args[1] 
  ref_path=args[2]
  # cnt_path="/path/to/megaHIT_contig_count_final/"
  cntg_cnt=list.files(path = cnt_path,pattern = "_bbmap_final")
  
  

  ref_path="/path/to/megaHIT_contigs/"
  
  ref_ann=list.files(path = ref_path,pattern = "_CAT_tax_refined.txt")
  
  for(i in 1:length(ref_ann))
  {
    ref_now=read.csv(file = str_c(ref_path,ref_ann[i]),sep = "\t",header = T)
     unknown_superkingdom=c(which(ref_now[,"superkingdom"]=="Unknown")) # ,which(ref_now[,"superkingdom"]=="Eukaryota")
     if(length(unknown_superkingdom)>0)
     {
      ref_now=ref_now[-unknown_superkingdom,]
      
     }
    
    ref_now_df=data.frame(Contig=ref_now$Contig)
    rrr=as.data.frame(ref_now)
    
    ref_now_df$Tax=apply(rrr[,1:7],1,function(x){str_c(x,collapse="|")})
    
    ref_now_short=str_replace_all(string = ref_ann[i],pattern = "_.*",replacement = "")
    cnt_dt=cntg_cnt[grep(pattern = ref_now_short,x=cntg_cnt)]
  
    for(j in 1:length(cnt_dt))
    {
      cnt_data=read.csv(file = str_c(cnt_path,cnt_dt[j]),sep = "\t",header = F)
      cnt_data=cnt_data[-which(cnt_data$V2=="*"),]
      cnt_data=as.data.frame(cnt_data)
      colnames(cnt_data)=c("Count","Contig")
      tax_mat_now=merge(x = cnt_data,y = ref_now_df,by="Contig") 
      tax_mat_cnt=tax_mat_now[,c("Tax","Count")] %>% group_by(Tax) %>% summarise_all(.funs = sum)
      write.table(x=tax_mat_cnt,file=str_c(ref_path,cnt_dt[j],"_final.txt"),quote = F,row.names = F,sep="\t")
      
    }
    }
  
 
  cnt_dt=list.files(path = ref_path,pattern = "_final_final.txt")
  for(i in 1:length(cnt_dt))
  {
  
    rr=read.csv(file=str_c(ref_path,cnt_dt[i]),header = T,sep = "\t")
    colnames(rr)[which(colnames(rr)=="Count")]=str_c(cnt_dt[i],"_count")
    
    if(i==1)
    {
      contig_count_mat=rr
    } else {
      
      contig_count_mat=merge(x = contig_count_mat,y = rr,by="Tax",all.x=TRUE,all.y=TRUE)
      
      
    }
    
      
  }
  contig_count_mat[is.na(contig_count_mat)]=0
  contig_count_rel=apply(contig_count_mat[,2:ncol(contig_count_mat)],2,function(x){x/sum(x)})
  write.table(contig_count_rel,file=str_c(ref_path,"tax_count_overall_rel.txt"),quote=F,row.names=F,sep="\t")
  
  
   
  }

CAT_tax_count()
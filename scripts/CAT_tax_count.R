CAT_tax_count=function()
{
  cnt_path="/naslx/projects/pr74xe/di52yal/Amira/megaHIT_contigs/contig_count/"
  cntg_cnt=list.files(path = cnt_path,pattern = "_bbmap_final")
  
  

  ref_path="/naslx/projects/pr74xe/di52yal/Amira/megaHIT_contigs/"
  
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
  
 
  contig_count_mat_16T106=apply(contig_count_mat[,2:3],1,sum)
  contig_count_mat_16TM29=apply(contig_count_mat[,4:5],1,sum)
  contig_count_mat_28T0=apply(contig_count_mat[,8:9],1,sum)
  contig_count_mat_28T52=apply(contig_count_mat[,10:11],1,sum)
  contig_count_mat_fin=contig_count_mat[,-c(2:5,8:11)]
  contig_count_mat_fin=cbind(contig_count_mat_fin,contig_count_mat_16T106,contig_count_mat_16TM29,contig_count_mat_28T0,contig_count_mat_28T52)
  colnames(contig_count_mat_fin)
  rownames(contig_count_mat_fin)=contig_count_mat_fin[,1]
  
  contig_count_mat_fin=contig_count_mat_fin[,-1]
  colnames(contig_count_mat_fin)=str_replace_all(string = colnames(contig_count_mat_fin),pattern = "_count_.*",replacement = "")
  
  cc=contig_count_mat_fin[,-grep(pattern = "^27|contig",x=colnames(contig_count_mat_fin))]
  cc=cc[-which(apply(cc,1,function(x){all(x<10)})==T),]
  cc=cc[-grep(pattern = "Eukaryo",x=rownames(cc)),]
  # cc=cc[-grep(pattern = "Unknown\\|Unknown\\|Unknown\\|Unknown\\|Unknown\\|Unknown",x=rownames(cc)),]
  contig_count_mat_fin=apply(cc,2,function(x){x/(sum(x))})
  
  # colnames(contig_count_mat_fin)[1]="ID"
  
    contig_count_mat_fin1=rbind(trim_melt$Donor_Disease_status[match(colnames(contig_count_mat_fin),as.character(trim_melt$Samples))],contig_count_mat_fin)
  
  write.table(contig_count_mat_fin1,file=str_c(ref_path,"tax_count_overall_rel_donor_disease_euk_removed.txt"),quote=F,row.names=T,sep="\t")
  
  
#  write.table(contig_count_rel,file=str_c(ref_path,"_tax_count_overall_rel.txt"),quote=F,row.names=F,sep="\t")
   
  }

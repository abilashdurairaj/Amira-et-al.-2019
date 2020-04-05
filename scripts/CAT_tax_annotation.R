###### Script to restructure taxonomic annotation to the contigs:

CAT_tax_annotation=function(CAT_path)
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
  
  # CAT_path="/path/to/megaHIT_contigs/"
  CAT_tax_files=list.files(path = CAT_path,pattern = "out.CAT.contig2classification_names_tax.txt",recursive = T)
  
  tax_hierarchy=c("superkingdom","phylum","class","order","family","genus","species")
  
  

  for(i in 1:length(CAT_tax_files))
  {
    
    rr=read.csv(file = str_c(CAT_path,CAT_tax_files[i]),header = F,sep = "\t",comment.char = "#")  
    CAT_tax_suffix=str_replace_all(string = CAT_tax_files[i],pattern = "_out.*",replacement = "")  
    
    message(str_c(CAT_tax_suffix," is started!"))  
    
    rr=rr[which(as.character(rr$V2)!=""),]
   message(str_c(nrow(rr), ": total i!"))
     CAT_matrix=matrix(,nrow=nrow(rr),ncol=length(tax_hierarchy))
    rownames(CAT_matrix)=as.character(rr$V1)
    colnames(CAT_matrix)=tax_hierarchy
  
    for(j in 1:nrow(rr))
    {
      tmp_hr=unlist(str_split(string = as.character(rr$V2[j]),pattern = "\\|"))
      tmp_hr=tmp_hr[tmp_hr!=""]
      
      
      if(length(tmp_hr)>0)
      {
        superkingdom_regex=grep(pattern = "(superkingdom)",x = tmp_hr)
        phylum_regex=grep(pattern = "(phylum)",x = tmp_hr)
        class_regex=grep(pattern = "(class)",x = tmp_hr)
        order_regex=grep(pattern = "(order)",x = tmp_hr)
        family_regex=grep(pattern = "(family)",x = tmp_hr)
        genus_regex=grep(pattern = "(genus)",x = tmp_hr)
        species_regex=grep(pattern = "(species)",x = tmp_hr)
        tmp_hr=str_replace_all(string = tmp_hr,pattern = ":.*",replacement = "")
        tmp_hr=str_replace_all(string = tmp_hr,pattern ="(species)|(genus)|(family)|(order)|(class)|(phylum)|(superkingdom)" ,replacement = "")
        tmp_hr=str_replace_all(string = tmp_hr,pattern = "\\(|\\)",replacement = "")
        CAT_matrix[j,"superkingdom"]=ifelse(test = length(superkingdom_regex)>0,yes = tmp_hr[superkingdom_regex],no = "Unknown")
        CAT_matrix[j,"phylum"]=ifelse(test = length(phylum_regex)>0,yes = tmp_hr[phylum_regex],no = "Unknown")
        CAT_matrix[j,"class"]=ifelse(test = length(class_regex)>0,yes = tmp_hr[class_regex],no = "Unknown")
        CAT_matrix[j,"order"]=ifelse(test = length(order_regex)>0,yes = tmp_hr[order_regex],no = "Unknown")
        CAT_matrix[j,"family"]=ifelse(test = length(family_regex)>0,yes = tmp_hr[family_regex],no = "Unknown")
        CAT_matrix[j,"genus"]=ifelse(test = length(genus_regex)>0,yes = tmp_hr[genus_regex],no = "Unknown")
        CAT_matrix[j,"species"]=ifelse(test = length(species_regex)>0,yes = tmp_hr[species_regex],no = "Unknown")
        message(str_c(j, " x ", i, " is done!"))
        }
      
      
    }
    CAT_df=as.data.frame(CAT_matrix)
    CAT_df$Contig=rownames(CAT_matrix)
    write.table(x=CAT_df,file = str_c(CAT_path,CAT_tax_suffix,"_tax_refined.txt"),quote = F,sep = "\t",row.names = F)
  message(str_c(CAT_tax_suffix," is done!"))  
  }
  
  
}

CAT_tax_annotation()

#############################################################

### Extract features for training/testing images ###

#############################################################
###Auther:Jihan Wei

### Input: a directory that contains images ready for processing

### Output: an .RData file contains processed features for the images

extract_feature<- function(img_dir,data_name="new_feature", export=T){
  # load libraries
  library("EBImage")
  no_files <- length(list.files(img_dir))
  fe<-matrix(NA, no_files ,32*32)    ##1024 features are extracted
  for(i in 1:no_files ){
    img <-readImage(paste0(img_dir, "image", "_",sprintf("%04.0f", i) ,".jpg"))
    img<- resize(img, 256,256)
    img<- thresh(img, w=60, h=60, offset=0.06)
    img<- resize(img,32,32)
    fe[i,] <- c(as.matrix(img))
    
  }
  # output constructed features
  if(export){
    save(fe, file=paste0("../output/", data_name, ".RData"))
  }
  return(fe)
}
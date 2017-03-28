library("EBImage")
setwd("C:/Users/Jihan Wei/Desktop/")

##Preprocessing for images to grey scale and rename (for Chinken)
img_dir<-"./ji/"
img_dir2<-"./ji2/"

ji.names<-list.files(img_dir)
ji.n<-length(ji.names)  #n.ji=128
j=1

for(i in ji.names){
  img <-readImage(paste0(img_dir,i))
  img<-channel(img, mode='gray')
  writeImage(img,file = paste0(img_dir2, "image", "_",sprintf("%04.0f", j) ,".jpg"))
  j=j+1
}


##Preprocessing for images to grey scale and rename (for Dog)
img_dir<-"./gou/"
img_dir2<-"./gou2/"

gou.names<-list.files(img_dir)
gou.n<-length(gou.names)    ##gou.n=133
j=1+ji.n  


for(i in gou.names){
  img <-readImage(paste0(img_dir,i))
  img<-channel(img, mode='gray')
  writeImage(img,file = paste0(img_dir2, "image", "_",sprintf("%04.0f", j) ,".jpg"))
  j=j+1
}

##Create lable for the extra images:
n<-ji.n+gou.n-1  ##n=260
y<-c(rep(0,ji.n),rep(1,gou.n-1))
write.csv(y,file = "./labels2.csv",row.names = F)
?write.csv

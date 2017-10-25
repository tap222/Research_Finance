rm(list = ls());gc()
library(mice)
sum(is.na(data))
tempData <- mice(data,m=5,maxit=50,meth='pmm',seed=500)
summary(tempData)
completedData <- complete(tempData,1)
write.csv(completedData,file='filename.csv',row.names=FALSE)

df <- read.csv('bank_imp.csv')
df <- df[(df[,2]>0),]
df <- df[(df[,3]>0),]
df <- df[(df[,4]>0),]
df <- df[(df[,5]>0),]
df <- df[(df[,6]>0),]
df <- df[(df[,7]>0),]
df <- df[(df[,8]>0),]
df <- df[(df[,9]>0),]
df <- df[(df[,10]>0),]

write.csv(df,file='filename.csv',row.names=FALSE)


rm(list= ls());gc()
setwd('C:\\Users\\10382\\Desktop\\Research_data')

sp <-read.csv('sp500.csv',header = T)
beta <- read.csv('beta.csv',header = T)
sp<-merge(sp,beta,by='Company.Name')

bank <- read.csv('bankset.csv',header = T)
auto <- read.csv('autoset.csv',header = T)
steel<- read.csv('steelset.csv',header = T)

auto_new <- merge(auto,sp, by = 'Company.Name')
write.csv(auto_new,file  = 'auto_new.csv')

bank_new <- merge(bank,sp, by = 'Company.Name')
write.csv(bank_new,file  = 'bank_new.csv')

steel_new <- merge(steel,sp, by = 'Company.Name')
write.csv(steel_new,file  = 'steel_new.csv')

sp$Main.product.service.group<-NULL
sp$Entity.type<-NULL
sp$Industry.group<-NULL
sp$Main.product.service.group.code<-NULL


company<- auto[,1:2]
df1<- auto[,3:7]
df2<- auto[,8:12]
df3<- auto[,13:17]
df4<- auto[,18:22]
df5<- auto[,23:27]
df6<- auto[,28:32]
df7<- auto[,33:37]
df8<- auto[,38:42]
df9<- auto[,43:47]
df10<- auto[,48:52]

df1 <-cbind(company,df1)
df2 <-cbind(company,df2)
df3 <-cbind(company,df3)
df4 <-cbind(company,df4)
df5 <-cbind(company,df5)
df6 <-cbind(company,df6)
df7 <-cbind(company,df7)
df8 <-cbind(company,df8)
df9 <-cbind(company,df9)
df10 <-cbind(company,df10)

library(data.table)
df_1<-rbindlist(list(df1, df2))[order(Company.Name)]
df_2<-rbindlist(list(df_1, df3))[order(Company.Name)]
df_3<-rbindlist(list(df_2, df4))[order(Company.Name)]
df_4<-rbindlist(list(df_3, df5))[order(Company.Name)]
df_5<-rbindlist(list(df_4, df6))[order(Company.Name)]
df_6<-rbindlist(list(df_5, df7))[order(Company.Name)]
df_7<-rbindlist(list(df_6, df8))[order(Company.Name)]
df_8<-rbindlist(list(df_7, df9))[order(Company.Name)]
df_9<-rbindlist(list(df_8, df10))[order(Company.Name)]
df <- df_9
View(df)

write.csv(df, file='steel_beta.csv',row.names = FALSE)
rm(auto,bank,steel,sp,beta)


auto_exp <- auto %>% group_by(FIRMS)
auto_exp <- auto %>% arrange(FIRMS)
t <-table(auto_exp$FIRMS)
t <- data.frame(t)
t$Company.Name <- t$Var1
t$Var1<-NULL



df <- auto[,c(1:2,53:62)]
company<- df[,1:2]
df1<- df$Beta
df2<- df$Beta.1
df3<- df$Beta.2
df4<- df$Beta.3
df5<- df$Beta.4
df6<- df$Beta.5
df7<- df$Beta.6
df8<- df$Beta.7
df9<- df$Beta.8
df10<- df$Beta.9

##To Convert Data

# Lets say I have a dataframe , df as following -
#df <- data.frame(a=c(2,3,-4,0,5,0),b=c(1,-2,3,4,0,0))
df<- read.csv('steel_final.csv')
df$Company.Name<-NULL

df <- df[which(df$ROE >= 0),]
df <- df[which(df$ROC >= 0),]
df <- df[which(df$NPM >= 0),]
df <- df[which(df$DIV >= 0),]
df <- df[which(df$DEP >= 0),]
df <- df[which(df$Beta >= 0),]
df <- df[which(df$P.B >= 0),]
df <- df[which(df$EVEBITDA >= 0),]
df <- df[which(df$PSALES >= 0),]

# create a custom function
fillwithMean <- function(x){
  na_index <- which(x == 0.00)        
  mean_x <- mean(x, na.rm=T)
  x[na_index] <- mean_x
  return(x)
}

df_t <- data.frame(apply(df,2,fillwithMean))
View(df_t)


cohort_build <- function(cohort_tabfile = "cohort-table.csv") {
  
  library("plyr")
  
  
  cbuild <- function(cohort_desc) {
    chrt <- data.frame(id=character(0),churn= logical(0))
    size = as.numeric(cohort_desc[2])
    cohort_index <-as.numeric(cohort_desc[1])
    a<-paste(sprintf("%02d",cohort_index),sprintf("%07d",seq(size)),sep = "") 
    b<-as.logical(rep(0,size))
    chrt <- data.frame(id=a,churn=b)
  }
  
  get_trans <- function(cases,month,avg,std,p) {
     trn_df <- data.frame(date=as.Date(character(0)),company_name=character(0),revenue=numeric(0),stringsAsFactors = FALSE)
     for (k in 1:nrow(cases)) {
       if(as.logical(rbinom(1,1,p))==TRUE) {
          id<-as.character(cases[k,]$id)
          date<-as.Date("2013-1-1")+months(month-1)
          revenue<-round(rnorm(1,mean=avg,sd=std))
          trn_df[nrow(trn_df)+1,]<-list(as.Date(date),id,revenue)
       }
     }
     
 
    trn_df
  }
  
  set.seed(Sys.time())
  cohort_table <- read.csv(cohort_tabfile)
  trans_df <- data.frame(date=as.Date(character(0)),company_name=character(0),revenue=numeric(0),stringsAsFactors = FALSE)
  lst = apply(cohort_table,1,cbuild) 
  
  for(i in 1:12) {
    for (j in 1:min(i,length(lst))) {
      pvec<-cohort_table[j,7:18] 
      curr_chrt<- as.data.frame(lst[j])
      tdf <- get_trans(subset(curr_chrt,curr_chrt$churn==FALSE),i,cohort_table[j,]$avg_revenue,cohort_table[j,]$std_revenue,as.numeric(pvec[i-j+1]))
      trans_df<-rbind(trans_df,tdf)
      
      funch<-which(lst[[j]]$churn==FALSE)[1]
      churnsize<-round((nrow(lst[[j]])-funch+1)*cohort_table$churn[j])
      lst[[j]]$churn[funch:(funch+churnsize-1)]<-TRUE

      
      print(sprintf("i=%d,j=%d,trns=%d,prob=%f",i,j,nrow(tdf),as.numeric(pvec[i-j+1])))
    }  
  }
  
trans_df
    
}
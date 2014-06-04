### IMPORT LIBRARIES ###
setwd("cohort")
library("scales")
library("plyr")
library("ggplot2")
library("lubridate")
library("reshape")
source('~/cohort/cohort_build.R')

### IMPORT DATA ###
account_data <- cohort_build()
account_data $date = as.Date(account_data$date)

df <- read.csv("cohort_activity.csv")
col_selector <- sapply(df,is.numeric) & names(df)!="signed_up"
df[,col_selector] <- with(df, df[,col_selector]/signed_up)
temp = as.matrix(df[,3:(length(df[1,]))])
colnames(temp) = paste('Month',sprintf("%02d", 0:(length(temp[1,])-1)),sep="")
rownames(temp) = as.vector(df$cohort)
dat2 <- melt(t(temp), id.var = "X1")

ggplot(dat2, aes(X1, X2)) +
  geom_tile(aes(fill = value)) + 
  geom_text(aes(fill = dat2$value, label = round(dat2$value, 3))) +
  scale_fill_gradient(low = "white", high = "red") +
  scale_y_discrete(limits = rev(levels(as.factor(dat2$X2)))) +
  labs(title = "Retention Cohort Table", x = "Months", y = "Cohort") +
  theme(axis.text = element_text( color = "black", size = 16)) + 
  theme(title = element_text(face = "bold.italic", color = "red", size = 16)) +
  theme(axis.title = element_text(face = "bold.italic", color = "red", size = 16))

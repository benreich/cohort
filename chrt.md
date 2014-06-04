Title
========================================================

This is an R Markdown document. Markdown is a simple formatting syntax for authoring web pages (click the **Help** toolbar button for more details on using R Markdown).

When you click the **Knit HTML** button a web page will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:


```r
setwd("cohort")
```

```
## Error: cannot change working directory
```

```r
con = gzcon(file("sit.gz", "rb"))
source(con)
close(con)
```


You can also embed plots, for example:


```r
plota.test()
```

```
## Warning: package 'quantmod' was built under R version 3.0.3
## Warning: package 'xts' was built under R version 3.0.3
```

```
## Loading required package: zoo
```

```
## Warning: package 'zoo' was built under R version 3.0.3
```

```
## 
## Attaching package: 'zoo'
## 
## The following objects are masked from 'package:base':
## 
##     as.Date, as.Date.numeric
```

```
## Warning: package 'TTR' was built under R version 3.0.3
```

```
## 
## Attaching package: 'TTR'
## 
## The following object is masked _by_ '.GlobalEnv':
## 
##     DVI
## 
## Version 0.4-0 included new data defaults. See ?getSymbols.
##     As of 0.4-0, 'getSymbols' uses env=parent.frame() and
##  auto.assign=TRUE by default.
## 
##  This  behavior  will be  phased out in 0.5-0  when the call  will
##  default to use auto.assign=FALSE. getOption("getSymbols.env") and 
##  getOptions("getSymbols.auto.assign") are now checked for alternate defaults
## 
##  This message is shown once per session and may be disabled by setting 
##  options("getSymbols.warning4.0"=FALSE). See ?getSymbol for more details
```

```
## pdf 
##   2
```



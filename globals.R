
library(ggplot2)
library(dplyr)
shp_df <- read.csv("data/irl_map.csv")

# note the use of <<- 
cases <- read.csv("data/Covid19CountyStatisticsHPSCIreland.csv")
cases <- cases[,c("CountyName","TimeStamp","PopulationCensus16","ConfirmedCovidCases")]
colnames(cases)[1] <- "id" # rename column so it matches name in other file

cases[is.na(cases)] <- 0
# create new field with cases per 1000 population
cases$Cases1000Pop <- 1000*cases$ConfirmedCovidCases / cases$PopulationCensus16

cases$TimeStamp <- paste(substr(cases$TimeStamp,9,10),
                         substr(cases$TimeStamp,6,7),
                         substr(cases$TimeStamp,1,4),
                         sep="/")

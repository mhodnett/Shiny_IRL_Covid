
shp_df <- read.csv("data/irl_map.csv")

#Look at the cases data and select the fields we want out of it
cases <- read.csv("data/Covid19CountyStatisticsHPSCIreland.csv")
cases <- cases[,c("CountyName","TimeStamp","PopulationCensus16","ConfirmedCovidCases")]
colnames(cases)[1] <- "id" # rename column so it matches name in other file

cases$Date <- substr(cases$TimeStamp,1,10)
cases <- cases[order(cases$id, cases$Date),]
cases$CumulativeCases <- cases$ConfirmedCovidCases
cases <- mutate(cases,
                previous_value = lag(ConfirmedCovidCases, order_by=id))
cases$ConfirmedCovidCases <- cases$CumulativeCases - cases$previous_value
cases$previous_value <- NULL

#Look at the cases data and select the fields we want out of it
# replace all NA's with zeros
cases[is.na(cases)] <- 0
# create new field with cases per 1000 population
cases$Cases100KPop <- 100000*cases$ConfirmedCovidCases / cases$PopulationCensus16

cases$TimeStamp <- paste(substr(cases$TimeStamp,9,10),
                         substr(cases$TimeStamp,6,7),
                         substr(cases$TimeStamp,1,4),
                         sep="/")

counties <- unique(cases$id)

cases <- cases[,c("Date",setdiff(names(cases),"Date"))]
cases <- cases[cases$Date>="2020/03/01",]

####
#head(cases)
# quality check, lets calculate the 14 day average per 100k pop
# this value is reported in the news daily and is approx 150
#cases2 <- cases[cases$Date>="2021/03/03",]
#county_data <- unique(cases[,c("id","PopulationCensus16")])
#100000*sum(cases2$ConfirmedCovidCases) / sum(county_data$PopulationCensus16)

#min(cases$Date)
#max(cases$Date)

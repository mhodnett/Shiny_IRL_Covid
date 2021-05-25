#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

library(ggplot2)
library(dplyr)
shp_df <- read.csv("data/irl_map.csv")

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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$mapPlot <- renderPlot({

        dat <- input$dateSelect
        dat <- paste(substr(dat,9,10),
                     substr(dat,6,7),
                     substr(dat,1,4),
                     sep="/")
        print(dat)
        day_cases <- cases[cases$TimeStamp==dat,]
        
        
        shp_cases <- left_join(shp_df, day_cases, by="id")
        ggplot() + ggtitle(paste0("Cases for ",dat))+
            geom_polygon(data = shp_cases,colour = "black",
                         aes(x=long, y=lat, group=group, fill=Cases1000Pop))+
            scale_fill_gradient(low = "blue", high = "red")+
            theme_void()+
            theme(plot.title = element_text(hjust = 0.5)) # needed to center plot title
    })

})

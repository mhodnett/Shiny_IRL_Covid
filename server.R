#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(DT)

source("globals.R", local=TRUE)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$mapPlot <- renderPlot({
        dat <- paste(
            substr(input$dateSelect,9,10),
            substr(input$dateSelect,6,7),
            substr(input$dateSelect,1,4),
            sep="/"
        )
        print(dat)
        day_cases <- cases[cases$TimeStamp==dat,]
        
        shp_cases <- left_join(shp_df, day_cases, by="id")
        ggplot() + ggtitle(paste0("Cases for ",dat))+
            geom_polygon(data = shp_cases,colour = "black",
                         aes(x=long, y=lat, group=group, fill=Cases100KPop))+
            scale_fill_gradient(low = "yellow", high = "brown")+
            theme_void()+
            theme(plot.title = element_text(hjust = 1.0)) # needed to center plot title
    })
    
    output$countyTable=renderDT({
        print(input$county)
        county_cases <- cases[cases$id==input$county,c("id","Date","ConfirmedCovidCases","Cases100KPop")]
        county_cases$TimeStamp <-NULL
        colnames(county_cases)[1] = "County"
        county_cases %>% 
            arrange(desc(Date))
    })

})

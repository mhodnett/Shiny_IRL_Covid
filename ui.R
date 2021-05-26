#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(DT)

source("globals.R", local=TRUE)

ui <- dashboardPage(
    dashboardHeader(title = "Covid dashboard"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Map", tabName = "map", icon = icon("map"))
        )
    ),
    dashboardBody(
        
        tabItems(
            # First tab content
            tabItem(tabName = "map",
                    
                    fluidRow(
                        box(width=4,
                            title = "Controls",
                            sliderInput("dateSelect",
                                        "Select a date:",
                                        min = as.Date(min(cases$Date),"%Y/%m/%d"),
                                        max = as.Date(max(cases$Date),"%Y/%m/%d"),
                                        value = as.Date(max(cases$Date),"%Y/%m/%d"),
                                        timeFormat = "%d/%m/%Y",
                                        animate=animationOptions(interval=2000)
                            )
                        ),
                        box(width=8,
                            plotOutput("mapPlot",height=580,width=480))
                    )
            )
            
            
            
        )
        
    )
)

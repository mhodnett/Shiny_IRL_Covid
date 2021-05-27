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
            menuItem("Map", tabName = "map", icon = icon("map")),
            menuItem("Data", tabName = "data", icon = icon("th"))
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
                    ),
                    tags$div(class = "header", checked = NA,
                             tags$hr(),
                             tags$p("Covid cases per county. Select a date from above and press the 'Play' button to see the animation!"),
                             tags$a(href = "https://data.gov.ie/dataset/covid19countystatisticshpscireland1", paste0("Data source, last updated - ",max(cases$Date)))
                    )
                ),
                box(width=8,
                    plotOutput("mapPlot",height=580,width=480))
            )
            ),
            
            # First tab content
            tabItem(tabName = "data",
                    fluidRow(
                        box(width=4,
                            title = "Controls",
                            selectInput("county","County:",counties)
                        )
                    ),
                    fluidRow(width=12,
                        DTOutput("countyTable")
                    )
                    )
        )
        
    )
)

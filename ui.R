#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Covid Tracker"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("dateSelect",
                        "Dates:",
                        min = as.Date("01/03/2020","%d/%m/%Y"),
                        max = as.Date("13/03/2021","%d/%m/%Y"),
                        value=as.Date("13/03/2021","%d/%m/%Y"),
                        timeFormat="%d/%m/%Y",
                        animate =
                            animationOptions(interval = 2000))
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("mapPlot")
        )
    )
))

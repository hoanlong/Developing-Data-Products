library(shiny)

shinyUI(fluidPage(
        titlePanel("Gompertz and Makeham's Tables for Belgium"),
        sidebarLayout(
                sidebarPanel(
                        strong("Instruction"),
                        p("The Shiny App calculates the mortality tables used by Belgian life insurance companies to derive their tariff and provisions."),
                        p("Change the following parameters:"),
                        p("- Age <- Chose the age of the individual to perform the calculation"),
                        p("- Sex <- Chose the sex of the individual to perform the calculation"),
                        p("- N <- Chose the time of projection"),
                        p("- Insurance type <- Chose if you want to perform the calculation for a 'death' or 'survival' insurance type contract"),
                        p("On the right part of the website, the probability of death, probability of survival and the remaining life expectancy will be computed."),
                        br(),
                        strong("Parameters of the individual and the insurance type"),
                        br(),
                        sliderInput("Age",
                                    "Age:",
                                    min = 0,
                                    max = 120,
                                    value = 25),
                        sliderInput("N",
                                    "N:",
                                    min = 1,
                                    max = 120,
                                    value = 1),
                        selectInput("Selected_Sex", "Sex: ", c("female", "male"), "female"),
                        selectInput("Selected_Insurance_Type","Insurance type: ", c("death", "survival"), "survival")
                ),
                mainPanel(
                        h3("Calculation outputs"),
                        plotOutput("distPlot"),
                        h4("A. Probability of death over the N next years:"),
                        verbatimTextOutput("calc_01"),
                        h4("B. Probability of death over 1 year in N years:"),
                        verbatimTextOutput("calc_02"),
                        h4("C. Probability of survival over the N next years:"),
                        verbatimTextOutput("calc_03"),
                        h4("D. Complete remaining life expectancy:"),
                        verbatimTextOutput("calc_04")
                )
        )
))
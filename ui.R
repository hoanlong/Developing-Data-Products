library(shiny)

shinyUI(fluidPage(
        titlePanel("Gompertz and Makeham's Tables for Belgium"),
        sidebarLayout(
                sidebarPanel(
                        strong("Instruction"),
                        p("- Chose your age, sex, the time of projection (N), and the type of insurance (death or survival)."),
                        p("- The probability of death, survival and the remaining life expectancy will be computed."),
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
library(shiny)
source("./actuarial_function.R")

shinyServer(function(input, output) {
        output$calc_01 <- renderPrint({
                age = input$Age
                N = input$N
                sex = input$Selected_Sex
                if (sex == "female"){
                        sex = "f"
                        main = "Number of survivors by age from a cohort of 1m individuals (female)"
                } else{
                        sex = "m"
                        main = "Number of survivors by age from a cohort of 1m individuals (male)"
                }
                insurance_type = input$Selected_Insurance_Type
                proba_death_n(age = age, N = N, sex = sex, insurance_type = insurance_type)
        })
        output$calc_02 <- renderPrint({
                age = input$Age
                N = input$N
                sex = input$Selected_Sex
                if (sex == "female"){
                        sex = "f"
                        main = "Number of survivors by age from a cohort of 1m individuals (female)"
                } else{
                        sex = "m"
                        main = "Number of survivors by age from a cohort of 1m individuals (male)"
                }
                insurance_type = input$Selected_Insurance_Type
                proba_death_n1(age = age, N = N, sex = sex, insurance_type = insurance_type)
        })
        output$calc_03 <- renderPrint({
                age = input$Age
                N = input$N
                sex = input$Selected_Sex
                if (sex == "female"){
                        sex = "f"
                        main = "Number of survivors by age from a cohort of 1m individuals (female)"
                } else{
                        sex = "m"
                        main = "Number of survivors by age from a cohort of 1m individuals (male)"
                }
                insurance_type = input$Selected_Insurance_Type
                proba_survi_n(age = age, N = N, sex = sex, insurance_type = insurance_type)
        })
        output$calc_04 <- renderPrint({
                age = input$Age
                sex = input$Selected_Sex
                if (sex == "female"){
                        sex = "f"
                        main = "Number of survivors by age from a cohort of 1m individuals (female)"
                } else{
                        sex = "m"
                        main = "Number of survivors by age from a cohort of 1m individuals (male)"
                }
                insurance_type = input$Selected_Insurance_Type
                life_expect(age = age, sex = sex, insurance_type = insurance_type)
        })
        output$distPlot <- renderPlot({
                age = input$Age
                N = input$N
                sex = input$Selected_Sex
                if (sex == "female"){
                        sex = "f"
                        main = "Number of survivors by age from a cohort of 1m individuals (female)"
                } else{
                        sex = "m"
                        main = "Number of survivors by age from a cohort of 1m individuals (male)"
                }
                insurance_type = input$Selected_Insurance_Type
                curve(survivor(age = x, sex = sex, insurance_type = insurance_type), 0, 120, type = "b", ylab = "number of survivors", xlab = "age", main = main)
                abline(v = age, col = 3)
                abline(v = min(age + N, 120), col = 2)
                legend(x = "topright", legend = c("Age", "N"), col = c("green", "red"), lty = 1, lwd = 1, bty = "n", seg.len = 3.5)
        })
})
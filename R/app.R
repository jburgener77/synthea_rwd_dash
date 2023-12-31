library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(ggrepel)

patient_table <- read.csv("../csv/patient_data.csv", 
                          stringsAsFactors = FALSE)
observations_table <- read.csv("../csv/observations_data.csv",
                               stringsAsFactors = FALSE)
conditions_table <- read.csv("../csv/conditions_data.csv",
                             stringsAsFactors = FALSE)
medications_table <- read.csv("../csv/medications_data.csv",
                              stringsAsFactors = FALSE)
procedures_table <- read.csv("../csv/procedures_data.csv",
                             stringsAsFactors = FALSE)
claims_table <- read.csv("../csv/claims_data.csv",
                         stringsAsFactors = FALSE)

# Define UI for app that generates table
ui <- fluidPage(
  titlePanel("Synthea EHR Viewer"),
  fluidRow(
    tabsetPanel(
      type = "pills",
      tabPanel("Tables",
        div(
          splitLayout(
            textInput("first_name", "First Name", ""),
            textInput("middle_name", "Middle Name", ""),
            textInput("family_name", "Family Name", "")
          )
        ),
        tabsetPanel(
          type = "tabs",
          tabPanel("Patients", DTOutput("patients_table")),
          tabPanel("Observations", DTOutput("observations_table")),
          tabPanel("Conditions", DTOutput("conditions_table")),
          tabPanel("Procedures", DTOutput("procedures_table")),
          tabPanel("Medications", DTOutput("medications_table")),
          tabPanel("Claims", DTOutput("claims_table"))
        )
      ),
      tabPanel("Plots",
        tabsetPanel(
          type = "tabs",
          tabPanel("Lifetime", div(textOutput("plot_text"),
                                   plotOutput("procedures_over_time")))
        )
      )
    )
  )
)
server <- function(input, output) {
  # Patient Characteristics Table
  sub_table <- reactive(patient_table[
    (grepl(paste0("^", input$first_name, ".*."),
           patient_table$first_name) &
       grepl(paste0("^", input$middle_name, ".*."),
             patient_table$middle_name) &
       grepl(paste0("^", input$family_name, ".*."),
             patient_table$family_name)),
  ])
  output$patients_table <- renderDT(sub_table(),
    options = list(lengthChange = FALSE, searching = FALSE,
                   scrollY = TRUE)
  )
  # Other Tables
  output$observations_table <- renderDT(
    observations_table[observations_table$uuid %in%
                         sub_table()$uuid, ],
    options = list(lengthChange = FALSE, searching = FALSE)
  )
  output$conditions_table <- renderDT(
    conditions_table[conditions_table$uuid %in% sub_table()$uuid, ],
    options = list(lengthChange = FALSE, searching = FALSE)
  )
  output$procedures_table <- renderDT(
    procedures_table[procedures_table$uuid %in% sub_table()$uuid, ],
    options = list(lengthChange = FALSE, searching = FALSE)
  )
  output$medications_table <- renderDT(
    medications_table[medications_table$uuid %in% sub_table()$uuid, ],
    options = list(lengthChange = FALSE, searching = FALSE)
  )
  output$claims_table <- renderDT(
    claims_table[claims_table$uuid %in% sub_table()$uuid, ],
    options = list(lengthChange = FALSE, searching = FALSE)
  )
  # Plots
  plot_string <- reactive(
    ifelse(input$first_name == "" &&
        input$middle_name == "" &&
        input$family_name == "",
      "Please Select a Patient",
      paste0(sub_table()$uuid, collapse = " & ")
    )
  )
  output$plot_text <- plot_string
  data_1 <- reactive(
    procedures_table[procedures_table$uuid %in% sub_table()$uuid, ] %>%
      ggplot(aes(y = as.Date(start_date, format = "%Y-%m-%d"),
                 x = length(start_date):1, color = code_text)) +
      geom_jitter()
  )
  output$procedures_over_time <- renderPlot(data_1())
}
shinyApp(ui, server)

# TODO: have a tab that shows other tables based on claims, procedures etc.
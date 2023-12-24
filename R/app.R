library(shiny)
library(DT)

patient_table <- read.csv("../csv/patient_data.csv")
observations_table <- read.csv("../csv/observations_data.csv")

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
          tabPanel("Observations", DTOutput("observations_table"))
        )
      ),
      tabPanel("Plots",
        tabsetPanel(
          type = "tabs",
          tabPanel("Lifetime", "")
        )
      )
    )
  )
)
server <- function(input, output) {
  # Patient Characteristics Table
  output$patients_table <- renderDT(
    patient_table[
      (grepl(paste0("^", input$first_name, ".*."),
             patient_table$first_name) &
         grepl(paste0("^", input$middle_name, ".*."),
               patient_table$middle_name) &
         grepl(paste0("^", input$family_name, ".*."),
               patient_table$family_name)),
    ],
    options = list(lengthChange = FALSE, searching = FALSE,
                   scrollY = TRUE)
  )
  # Observations Table
  output$observations_table <- renderDT(
    observations_table[observations_table$uuid %in% patient_table$uuid,],
    options = list(lengthChange = FALSE, searching = FALSE)
  )
}
shinyApp(ui, server)

# TODO: have a tab that shows other tables based on claims, procedures etc.
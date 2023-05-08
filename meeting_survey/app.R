#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinysurveys)

lab_meeting_day_time <- data.frame(question = c("Your name",
                                                "Mondays 14:00-16:00 (usual time)",
                                                "Mondays 14:00-16:00 (usual time)",
                                                "Mondays 12:00-14:00",
                                                "Mondays 12:00-14:00",
                                                "Tuesdays 12:00-14:00",
                                                "Tuesdays 12:00-14:00",
                                                "Tuesdays 14:00-16:00",
                                                "Tuesdays 14:00-16:00",
                                                "Thursdays 14:00-16:00",
                                                "Thursdays 14:00-16:00"),
                                   option = c("Your name here","Yes", "No", "Yes", "No", "Yes", "No",
                                              "Yes", "No", "Yes", "No"),
                                   input_type = c("text", "y/n", "y/n", "y/n",
                                                  "y/n", "y/n", "y/n", "y/n",
                                                  "y/n", "y/n", "y/n"),
                                   input_id = c("name", "m1416", "m1416",
                                                "m1214", "m1214", "t1214",
                                                "t1214", "t1416", "t1416",
                                                "th1416", "th1416"),
                                   dependence = NA,
                                   dependence_value = NA,
                                   required = T)


ui <- fluidPage(
  surveyOutput(df = lab_meeting_day_time,
               survey_title = "Lab meeting day/time",
               survey_description = "Please indicate whether you are available to meet for lab meeting at the following times. All meetings will start at 15 after because of the akademische Viertelstunde.")
)

server <- function(input, output, session) {
  renderSurvey()
  
  observeEvent(input$submit, {
    showModal(modalDialog(
      title = "Thank you for completing the survey!",
      "Your response has been recorded, and we will be in contact soon about a new lab meeting time."
    ))
    
    response_data <- getSurveyData(custom_id = input$name)
    print(response_data)
  })
  
}

shiny::shinyApp(ui = ui, server = server)
ui <- fluidPage(
  
  # Application title
  titlePanel("Slack Channel Builder"),
  
  # Sidebar with calendar input
  inputPanel(
    textInput("api_token", "Enter your Slack API token."),
    textInput("sheets_url", "Enter the Google Sheets URL."),
    tags$br(),
    actionButton("goButton", "Create my Slack workspace!"),
    textOutput("status")
  )
)
ui <- fluidPage(
  
  # Application title
  titlePanel("Slack Channel Builder"),
  
  #description
  wellPanel("This app builds one Slack channel for each hackathon team and invites all the team members. To use this app you need two things:",
            tags$br(),
            tags$li("A Google Sheet containing the email addresses of all your participants and the name of the team they will be participating in. These columns must be called email and team (all lower case)."),
            tags$li("A Slack workspace. First, create your Slack workspace (directions at https://get.slack.help/hc/en-us/articles/206845317-Create-a-Slack-workspace). Next, get the API token for your workspace from https://api.slack.com/custom-integrations/legacy-tokens.")
            ),
  
  # Input
  inputPanel(
    textInput("api_token", "Enter your Slack API token."),
    textInput("sheets_url", "Enter the Google Sheets URL."),
    tags$br(),
    actionButton("goButton", "Create my Slack workspace!"),
    textOutput("status")
  )
)

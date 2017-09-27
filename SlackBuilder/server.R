server <- function(input, output, session) {
  
  library(slackr)
  library(googlesheets)
  library(httr)
  
  output$status <- renderText({
    if (input$goButton > 0) {
      sheet_id <- gs_url(as.character(input$sheets_url))
      dat <- gs_read(sheet_id, ws = 1, col_names = TRUE)
      dat <- dat[, c(7, 13)] #gs_read pulls in more than we need - keep just the relevant columns containing email address and team name
      names(dat) <- c("email", "team")
      print(paste(nrow(dat), "people will be invited to your Slack workspace."))
      ##assemble the URLs to make the API calls
      for (i in 1:nrow(dat)){
        #create the URL
        email <- dat[i, 1]
        team <- dat[i, 2]
        token <- input$api_token
        url <- paste("https://slack.com/api/users.admin.invite?token=", token, "&email=", email, "&channels=", team, sep="")
      print(url)  
      }
      
    }
  })
  
  
  renderText({
    slackrSetup(channel = "#general", username = "lisa", api_token = input$api_token)
    if (input$goButton > 0) {
      print(paste("You have entered", input$api_token))
    }
  })
}
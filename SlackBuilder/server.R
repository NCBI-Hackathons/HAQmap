server <- function(input, output, session) {
  
  library(slackr)
  library(googlesheets)
  library(httr)
  
  output$status <- renderText({
    if (input$goButton > 0) {
      sheet_id <- gs_url(as.character(input$sheets_url))
      dat <- gs_read(sheet_id, ws = 1, col_names = TRUE)
      dat <- dat[, c("email", "team")] #gs_read pulls in more than we need - keep just the relevant columns containing email address and team name
      print(paste(length(unique(dat$email)), "people will be invited to your Slack workspace."))
      print(paste(length(unique(dat$team)), "team channels will be created."))
      
      ##create the needed channels 
      for (i in 1:length(unique(dat$team))){
        #extract the team name
        team <- as.character(unique(dat$team)[i]) 
        #create the url
        url <- paste("https://slack.com/api/channels.create?token=", api_token, "&name=", team, sep="")
        #make the call
        resp <- POST(url)
        #find all the rows with that team name
        rows <- which(dat$team == team)
        #put the team ID for the team in all the rows containing that team name
        for (j in 1:length(rows)) {
          row <- rows[j]
        dat$team_id[rows[j]] <- content(resp)$channel$id
        }
    }
        
      ##invite the members
      for (i in 1:nrow(dat)){
        email <- dat$email[i]
        team <- dat$team_id[i]
        token <- api_token #input$api_token
        url <- paste("https://slack.com/api/users.admin.invite?token=", token, "&email=", email, "&channels=", team, sep="")
        response <- POST(url)
        if (content(response)$ok == TRUE){
          dat$invited[i] <- content(response)$ok
          dat$not_invited_reason[i] <- NA
        }
        else {
        dat$invited[i] <- content(response)$ok
        dat$not_invited_reason[i] <- content(response)$error
        }
      }
      
    }
  })
  
  
  renderText({
  
    if (input$goButton > 0) {
      print(paste("You have entered", input$api_token))
    }
  })
}

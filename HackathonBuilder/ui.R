ui <- fluidPage(

  # Application title
  titlePanel("NCBI-Style Hackathon Calendar Builder"),
  
  # Sidebar with calendar input
  sidebarLayout(
    sidebarPanel(dateInput(
      'date',
      label = 'Select the first day for your hackathon.',
      value = NULL,
      min= Sys.Date()
    ),
    googleAuthUI("loginButton"),
    actionButton("goButton", "Create my hackathon!"),
    textOutput("create")
    ),
    
    # Display the calendar
    mainPanel(
      tags$h4(textOutput("dateText")),
      DT::dataTableOutput('tbl')
    )
  )
)
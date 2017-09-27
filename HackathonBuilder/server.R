server <- function(input, output, session) {
  rv <- reactiveValues(
    login = FALSE
  )
  ##PART ONE: Create the calendar
  #print the start date of the hackathon
  output$dateText <- renderText({
    paste("You have selected", as.character(input$date), "as the start date for your hackathon.", "\n")
  })
  
  #create the data frame with the calendar  
  Data = reactive({
    if (input$date > 0) {
      r1 <- c(as.character(input$date - 60), "Recruit team leads", "Host", "Super damn essential")
      r2 <- c(as.character(input$date - 30), "Select a hackathon mascot", "Host", "Meh whatever")
      r3 <- c(as.character(input$date - 15), "Book a room", "Site organizer", "Super damn essential")
      r4 <- c(as.character(input$date), "Time to Hack!!!", "All the awesome people", "Super damn essential")
      df <- rbind(r1, r2, r3, r4)
      names(df) <- c("Date", "Task", "Person Responsible", "Importance")
      return(list(df=df))
    }
  })
  output$tbl = DT::renderDataTable(
    Data()$df, options = list(dom = 't'), rownames = FALSE
  )
  
  #print the waiting message
  
  
  
  ##PART TWO: create the google drive folder and populate it
  output$wait <- renderText({
    print("Please wait while we build your hackathon kit.")
  })
  
  output$create <- renderText({
    access_token <- callModule(googleAuth, "loginButton")
    input$goButton
    if (input$goButton > 0) {
      library(googleAuthR)
      library(googledrive)
      library(googlesheets)
      
      #do the Google authentication

      #make the name for the folder based on the date
      path <- paste("Hackathon_", input$date, sep="")
      drive_mkdir(path, starred = TRUE)
      path_id <- drive_get(path = path)
      path_id <- path_id$id[1]
      googlesheets::gs_new(paste("calendar", input$date, sep=""), ws_title = path, input = Data()$df) 
      drive_mv(paste("calendar", input$date, sep=""), path = path, name = "Calendar")
      
      ##copy the contents of the Master Google Drive folder
      names <- drive_ls(as_id("https://drive.google.com/drive/folders/0B8k0pVjtUn5tbWJyODFGSTdXNjQ"))
      for (i in 1:nrow(names)){
        drive_cp(file = as_id(names$id[i]), path = as_id(path_id), name = names$name[i])
      }
      
    
      
      
      
      
      #template <- drive_cp(file = as_id("https://docs.google.com/document/d/14DycE62xpFncUr5hP-D4hBf3AFirJGh0uAgBRjevnt8/edit"), path = path, name = "Manuscript Template")
      #application <- drive_cp(as_id("https://docs.google.com/forms/d/1RaEd70m_2Y4--rPzjTLHpYrT7B8a1nWqpjorLBFUhQU/"), path = path, name = "Application Form")
      #create the sheet that collects the application form data
      #roster <- drive_cp(as_id("https://docs.google.com/spreadsheets/d/1oxTEwplhi2BuARmXkG2HFfFRV4wjx23uWumThZdmm0o/edit#gid=1999195006"), path = path, name = "Master Sheet")  
      
      # the calendar sheet key is accessed by calendar$sheet_key
      print(path)
      new_files <- drive_ls(path)
      print(new_files)
      masterSheetKey <- new_files[which(new_files$name=="Application_form (Responses)"),2][[1]][1]
      masterSheet <- gs_key(masterSheetKey)
      masterSheet %>% gs_ws_new(ws_title = "FILE_IDS", input=new_files[,1:2], trim=TRUE, verbose=TRUE)
      masterSheet %>% gs_ws_new(ws_title = "CALENDAR", input=Data()$df, trim=TRUE, verbose=TRUE)
      
      
      
      print("Your hackathon kit has been created!")
    }
  })
}
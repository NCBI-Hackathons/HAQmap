library(googleAuthR)
library(shiny)

options(shiny.port = 1221)
options("googleAuthR.scopes.selected" = c("https://www.googleapis.com/auth/drive", "https://www.googleapis.com/auth/userinfo.profile"))
options("googleAuthR.webapp.client_id" = "xxx")
options("googleAuthR.webapp.client_secret" = "xxx")
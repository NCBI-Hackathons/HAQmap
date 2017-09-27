library(googleAuthR)
library(shiny)

options(shiny.port = 1221)
options("googleAuthR.scopes.selected" = c("https://www.googleapis.com/auth/drive", "https://www.googleapis.com/auth/userinfo.profile"))
options("googleAuthR.webapp.client_id" = "693332622892-fl1bkv4jtq22nh238kgnpj24mfbin37i.apps.googleusercontent.com")
options("googleAuthR.webapp.client_secret" = "sQYLbECcS3K1Tj1-cwXNvbY-")
shinyServer(function(input, output, session) {
  # source("global.R")
  # session$onSessionEnded(stopApp)
  source(file.path("server", "server_bleeding.R"), local = TRUE)$value
  source(file.path("server", "server_about.R"), local = TRUE)$value

})

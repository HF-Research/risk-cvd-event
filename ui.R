ui <- div(

  fluidPage(
    img(
      src = "hf-logo.png",
      align = "left",
      style = "padding-top: 20px; padding-bottom: 40px; padding-left: 1rem;",
      height = "110px"
    ),
    div(style = "padding-left: 0px; padding-right: 0px;",
        titlePanel(
          title = "", windowTitle = prj_title
        ))
  ),
  navbarPage(
    title = prj_title,
    collapsible = TRUE,
    theme = "www/cars-style.css",
    source(file.path("ui", "ui_bleeding.R"), local = TRUE)$value,
    source(file.path("ui", "ui_about.R"), local = TRUE)$value

  )
)

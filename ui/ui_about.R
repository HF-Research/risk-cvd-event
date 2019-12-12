tabPanel(
  ui_about_title,
  useShinyjs(),


  wellPanel(
    class = "explanitory_well",
    div(class = "results_header", explanitory_header),
    br(),
    div(class = "explanitory_text", explanitory_text_1),
    br(),
    div(class = "explanitory_text", explanitory_text_2),
    br(),
    tags$ul(
      class = "explanitory_text",
      tags$li(explanitory_text_3),
      tags$li(explanitory_text_4)
    ),
    br(),
    br(),
    fluidRow(column(
      class = "results",
      8,
      div(class = "ref", references),
      tags$ol(
        class = "ref",
        tags$li(ref1),
        tags$li(ref2),
        tags$li(ref3),
        tags$li(ref4)
      )
    ))



  )

)

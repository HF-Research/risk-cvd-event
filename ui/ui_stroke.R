tabPanel(
  ui_stroke_title,
  useShinyjs(),

  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "cars-style.css")

  ),
  fluidRow(
    # STROKE-INPUT-------------------------------------------------------------------
    column(
      id = "input_col",
      6,
      wellPanel(

        numericInput(
          inputId = "user_age",
          label = in_age,
          min = 20,
          max = 99,
          value = "Age"
        ),

        shinyWidgets::radioGroupButtons(
          inputId = "sex",
          label = in_sex,
          choices = c("Mand" = "no",
                      "Kvinde" = "yes"),
          checkIcon = list(yes = icon("check")),
          selected =  "no",
          # width = button.width,
          justified = TRUE
        ),

        br(),
        div(id = "in_prevDiag", in_prevDiag),
        br(),

        shinyWidgets::radioGroupButtons(
          inputId = "hf",
          label = in_hf,
          choiceNames = in_yesNo_choice,
          selected =  ("no"),
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE
        ),

        shinyWidgets::radioGroupButtons(
          inputId = "diabetes",
          label = in_diab,

          choiceNames = in_yesNo_choice,
          selected =  ("no"),
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE
        ),

        shinyWidgets::radioGroupButtons(
          inputId = "vasc",
          label = in_vasc,
          choiceNames = in_yesNo_choice,
          selected =  ("no"),
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE
        ),


        shinyWidgets::radioGroupButtons(
          inputId = "stroke",
          label = in_stroke,
          choiceNames = in_yesNo_choice,
          selected =  "no",
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE
        ),

        shinyWidgets::radioGroupButtons(
          inputId = "hyperT",
          label = in_hyperT,
          choiceNames = in_yesNo_choice,
          selected =  ("no"),
          choiceValues = c("no",
                           "yes"),
          checkIcon = list(yes = icon("check")),
          # width = button.width,
          justified = TRUE
        )
      )
    ),


    # STROKE-OUTPUT ------------------------------------------------------------------

    column(
      id = "results",
      6,
      tabsetPanel(
        type = "pills",
        tabPanel(
          results_1,
          fluidRow(
            wellPanel(
              class = "results_well",
              # div(class = "results_header", results_stroke_header),
              div(class = "results_header", textOutput("stroke_desc1")),
              tags$h1(strong(textOutput("enter_age"))),
              d3Output("plot_riskbar", height = "100%"),

              br()

            )
          ),


          fluidRow(
            wellPanel(
              id = "plot_matrix",
              class = "results_well",
              div(class = "output_desc", textOutput("stroke_desc2")),
              br(),
              uiOutput("plot_stroke")

            )
          )
          ),

        tabPanel(results_2,
                 fluidRow(wellPanel(id = "results_gauge")),


                 fluidRow(wellPanel(id = "results_plot_stroke")))
      ),


      hr()



    )
  )
)

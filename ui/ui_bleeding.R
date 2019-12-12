tabPanel(
  ui_bleeding_title,
  useShinyjs(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "cars-style.css")
  ),
    
  # BLEEDING ----------------------------------------------------------------
  fluidRow(column(
    id = "input_col",
    6,
    wellPanel(
      # BLEEDING-INPUT ----------------------------------------------------------


      div(class = "titles", input_title),
      br(),

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
      ),

      shinyWidgets::radioGroupButtons(
        inputId = "bleeding",
        label = in_bleed,
        choiceNames = in_yesNo_choice,
        selected =  ("no"),
        choiceValues = c("no",
                         "yes"),
        checkIcon = list(yes = icon("check")),
        # width = button.width,
        justified = TRUE
      ),

      shinyWidgets::radioGroupButtons(
        inputId = "ckd",
        label = in_ckd,
        choiceNames = in_yesNo_choice,
        selected =  ("no"),
        choiceValues = c("no",
                         "yes"),
        checkIcon = list(yes = icon("check")),
        # width = button.width,
        justified = TRUE
      ),

      shinyWidgets::radioGroupButtons(
        inputId = "drugs",
        label = in_drug,
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
  column(id = "bleeding_results",
         6,
         tabsetPanel(type = "tabs",
                     tabPanel(
                       results_1,
                       fluidRow(
                         wellPanel(
                           class = "results_well",
                           # div(class = "results_header", results_stroke_header),
                           div(class = "results_header"),

                           br()

                         )
                       )
                     ))
  )))

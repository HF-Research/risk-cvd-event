onclick("hf", jsButtonColor("hf", "#AF060F", value = "yes"))

showModal(
  modalDialog(
    title = paste0("Beta testing ", prj_title),
    easyClose = TRUE,
    fade = TRUE,
    tags$p(
      tags$b(
        paste0(prj_title, " does not work with Internet Explorer. Please choose Chrome/Firefox/Safari/Edge")
      )
    ),
    tags$br(),
    tags$p(
      paste0("This is a beta version of ", prj_title, " that should only be used for testing purposes.
    The data presented is awaiting peer review and has not been published."
    )),
    tags$p("Please send any feedback to mphelps@hjerteforeningen.dk"),
    tags$br(),
    tags$p("Click anywhere to dismiss")
  )
)



# REACTIVE FUNCTIONS ------------------------------------------------------
txt2num <- reactive({
  as.numeric(input$user_age)
})

subsetStroke <- reactive({
  # Reactive function will cache it's output. It will only run again if input
  # has changed, otherwise, repeated calls to it will only access the cached
  # values, not re-calculate.
  stroke.dt[age == txt2num() &
              female %in% input$sex &
              stroke %in% input$stroke &
              heartfailure %in% input$hf &
              diabetes %in% input$diabetes &
              hypertension %in% input$hyperT &
              vascular %in% input$vasc,
            stroke1y]
})

subsetBleed <- reactive({
  bleed.dt[age == txt2num() &
             hypertension %in% input$hyperT &
             stroke %in% input$stroke &
             ckd %in% input$ckd &
             bleeding %in% input$bleeding &
             drugs %in% input$drugs,
           bleeding1y]
})

dataPrep <- reactive({
  n <- 1000
  x <-
    data.frame(matrix(
      seq(0.01, 24, length.out = n),
      nrow = n,
      ncol = 1
    ))
  colnames(x) <- "v1"
  x
})

colorRamp <- reactive({
  # Create first color ramp. We will extract a color from near the green side of
  # this first color ramp. Then we make a second color ramp where we spline
  # through the green-ish color we just extract. This will have the effect of
  # pulling the green color up off the bottom after dong the log-transform.
  n <- 1000
  col_pal_1 <- colorRampPalette(colors = c("#2CDE0D", "red"))
  col_ramp_1 <- col_pal_1(n)

  # Make the second color ramp where we spline through the extracted color from
  # the first color ramp.
  col_pal <-
    colorRampPalette(colors = c("#2CDE0D", col_ramp_1[65], "red"))
  col_pal(n)

})

plotRiskBar <- reactive({
  ggplot(dataPrep(), aes(x = 1, y = v1)) + geom_tile(aes(fill = v1)) +
    scale_fill_gradientn(colors = colorRamp(),
                         trans = 'log') +
    theme_minimal() +
    theme(
      axis.text = element_blank(),
      axis.title = element_blank(),
      panel.grid = element_blank(),
      legend.position = "nonoe"
    )

})

plotd3 <- reactive({
  r2d3(subsetStroke(), script = "gauge.js")

})

enterAge <- reactive({
  if (!is.valid.age(txt2num()))
    enter_age
})




# VALID AGE OUTPUT --------------------------------------------------------

output$enter_age <- renderText(enterAge())




# SHOW/HIDE LOGIC ---------------------------------------------------------

observe({
  shinyjs::toggle(
    id = "plot_matrix",
    condition = is.valid.age(txt2num()),
    anim = TRUE,
    time = 0.2
  )
})


# WRITE STROKE OUTPUT -----------------------------------------------------
output$strokeRisk <- renderText({
  outputHelper1(subsetStroke(), txt2num(), enter_age)
})

output$stroke_desc1 <- renderText({
  ifelse(is.valid.age(txt2num()), results_stroke_header, "")
})

output$stroke_desc2 <- renderText({
  outputHelper2(
    data = subsetStroke(),
    age = txt2num(),
    out2 = out_stroke2,
    out3 = out_stroke3,
    outLessOne = out_strokeLessOne
  )

})

# WRITE BLEEDING OUTPUT ---------------------------------------------------
output$bleedRisk <- renderText({
  outputHelper1(subsetBleed(), txt2num(), enter_age)
})

output$bleed_desc1 <- renderText({
  ifelse(is.valid.age(txt2num()), out_bleeding1, "")
})

output$bleed_desc2 <- renderText({
  outputHelper2(
    data = subsetBleed(),
    age = txt2num(),
    out2 = out_bleeding2,
    out3 = out_bleeding3,
    outLessOne = out_bleedingLessOne
  )

})



# VISUALIZE NUMBER OF SICK - STROKE ---------------------------------------
output$plot_stroke <- renderUI({
  # Get the values for the board:
  # browser()
  if (is.valid.age(txt2num())) {
    n_sick_stroke <- round(subsetStroke(), digits = 0)
    n_population <- 100
    board_fill <- c(rep(0, n_population - n_sick_stroke),
                    rep(1, n_sick_stroke))
    n_rows <- 10
    n_cols <- 10
    board <- matrix(board_fill,
                    nrow = n_rows,
                    ncol = n_cols,
                    byrow = TRUE)

    # Assign appropriate div IDs to each cell in the board:
    isolate({
      div(id = "board-inner",
          lapply(seq(n_rows), function(row) {
            tagList(div(class = "board-row",
                        lapply(seq(n_cols), function(col) {
                          # browser()
                          value <- board[row, col]
                          # value <- board_entries(values$board)[row, col]
                          visClass <- ifelse(value == 0, "off", "on")
                          id <- sprintf("cell-%s-%s", row, col)
                          div(id = id,
                              class = paste("board-cell", visClass))
                        })),
                    # This empty div seems to provide a way to "break" the rows. Without this
                    # div element, the rows all move to one long line
                    div())
          }))
    })
  }
})

output$plot_riskbar <- renderD3({
  if (is.valid.age(txt2num())) {
    plotd3()

    # plotRiskBar() +
    # geom_hline(yintercept = subsetStroke(), size = 1)
  }
})

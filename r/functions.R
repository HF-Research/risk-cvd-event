# HELPER FUNCTIONS --------------------------------------------------------
jsButtonSelectionColor <- function(active = TRUE, color){
  # Colors active or non-active buttons in shinyWidgets library
  if (active) {
    paste0("$('.btn.radiobtn.btn-default.active').css({'background-color':'",
           color,
           "'});")
  }
  else {
    paste0("$('.btn.radiobtn.btn-default').css({'background-color':'",
           color,
           "'});")
  }
}



jsButtonColor <- function(var, color, value) {
  # Makes simple js code to color buttons in shinyWidgets library. From:
  # https://github.com/dreamRs/shinyWidgets/issues/41
  # var, color and yes/no need to be in quotes
  paste0(
    "$(\"button.btn.radiobtn.btn-default.active input:radio[name='",
    var,
    "'][value='",
    paste0(value),
    "']\").parent().css({'background-color': '",
    color,
    "',
    'border-color': '#FAFAFA'});"
  )
}



is.valid.age <- function(x) {
  !is.na(x) &&
    x >= 20 &&
    x <= 99 &&
    x %% 1 == 0
}

outputHelper1 <- function(data, age, age_warning){
  # Outputs results if age is valid, if not - gives warning to enter age
  if (!is.valid.age(age)) {
    age_warning
  } else {
    ifelse(data < 0.1,
           paste0("<0.1%"),
           paste0(sprintf(
             "%.1f",
             round(data,
                   digits = 1)
           ),
           "%"))
  }
}

outputHelper2 <- function(data, age, out2, out3, outLessOne){
  # Write description of output if age is valid
  if (is.valid.age(age)) {
    threshold <-
      (round(data, digits = 1) * 0.01 * 100)
    ifelse(
      threshold >= 1,
      paste0(out2, threshold, out3),
      outLessOne
    )
  } else {
    ""
  }

}

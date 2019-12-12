library(data.table)
stroke.dt <- fread("data/stroke-1year-risk-predictions.txt")


# Re-order columns to the order patients will enter their variables information
# into the shiny app
new.var.order.stroke <-  c(
  "age",
  "female",
  "stroke",
  "heartfailure",
  "diabetes",
  "hypertension",
  "vascular",
  "chadsvasc",
  "stroke1y.lower",
  "stroke1y",
  "stroke1y.upper",
  "I63.lower",
  "I63",
  "I63.upper",
  "thromb1y.lower",
  "thromb1y",
  "thromb1y.upper",
  "year2000"
)

setcolorder(stroke.dt, new.var.order.stroke)
setkeyv(stroke.dt, new.var.order.stroke)


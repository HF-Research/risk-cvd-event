# Text file for Shiny UI.
#
# Make edits to the UI in this file
# Var names should not contain "." due to conflicts with JavaScript

# TITLE -------------------------------------------------------------------
prj_title <- "CVD risiko"
subtitle_txt <- "Calculator of Absolute Risk of Bleeding"

ui_tab1_title <- enc2utf8("CVD risk")
ui_about_title <- enc2utf8(paste0("Om ", prj_title))

# INPUT UI ------------------------------------------------------------------
input_title <- "1. INPUT"
in_age <- "Patientens alder (mellem 35 og 99):"
in_sex <- "Køn"


in_prevDiag <- "Har patienten tidligere været diagnosticeret med følgende:"

in_stroke <- "Apopleksi/ TCI / Perifer emboli?"
in_hf <- "Hjertesvigt?"
in_hyperT <- "Hypertension?"
in_diab <- "Diabetes mellitus?"
in_vasc <-
  "Vaskulær sygdom? (tidligere myokardieinfarkt, perifer arteriel sygdom)"
in_yesNo_choice <- c("Nej", "Ja")

# Bleeding variables
in_bleed <- "Previous major bleeding"
in_ckd <- "Abnormal renal or liver function"
in_drug <- "Drug or alcohol abuse"


help_stroke <-
  "Previous stroke / Transient Ischemic attack / thromboembolism"
help_hf <- "Congestive heart failure/ Left ventricular dysfunction"
help_hyperT <-
  "Treatment with antihypertensive drugs or resting sBP >= 140mmHg and/or
dBP>=90mmHg"
help_diab <-
  "Treatment with oral hypoglycemic drugs or Glycated hemoglobin
(HbA1C) ≥ 48 mmol/mol (≥ 6.5 DCCT %)"
help_vasc <-
  "Prior myocardial infarction, peripheral artery disease"
# Must be in quotedt pixels (px), e.g.: "100px"



# TAB NAMES ---------------------------------------------------------------

results_1 <- "Quick results"
results_2 <- "Expanded results"

# STROKE RESULTS ----------------------------------------------------------


results_stroke_title <- "2. RESULTATER"
results_stroke_header <-
  "Risikoen for at få apopleksi inden for et år efter diagnosen atrieflimren er:"


out_stroke2 <- "Det betyder at  "
out_stroke3 <- " ud af 100 patienter med de samme risikofaktorer vil få
apopleksi inden for året efter diagnosen"
out_strokeLessOne <-
  "Det betyder at <1 ud af 100 patienter med de samme risikofaktorer vil få
apopleksi inden for året efter diagnosen."

out_stroke4 <- "Dette er repræsenteret i nedenstående figur. Der er i alt 100
cirkler, der repræsenterer 100 patienter med de samme risikofaktorer. Hver rød
cirkel repræsenterer en patient, der oplevede et apopleksi, mens hver grønne
cirkel repræsenterer en patient, der ikke oplevede det. "



# BLEEDING RESULTS --------------------------------------------------------

results_bleeding_title <- "3. BLEEDING RISK"
out_bleeding1 <-
  "The risk of having any bleeding event within one year
following AF diagnosis is:"

out_bleeding2 <- "This means that "
out_bleeding3 <- " out of 1000 patients with the same risk
factors would experience any bleeding event within the year following diagnosis"
out_bleedingLessOne <-
  "This means that <1 out of every 1000 patients with the same risk factors
would experience a major bleeding event within one year following diagnosis"


# EXPLANITORY TEXT --------------------------------------------------------

explanitory_header <- paste0("Om  ", prj_title, " lommeregneren")

explanitory_text_1 <- paste0(
  prj_title,
  "
 beregner den absolutte 1 - årige risiko for blødning for patienter med
atrieflimren som har startet antikoagulationsbehandling inden diagnosen. Lommeregneren er baseret
på en stor kohorte af danske patienter indlagt med atrieflimren for første gang
på hospitalet [1]."
)

explanitory_text_2 <- "
Lommeregneren anvender de samme risikofaktorer som HAS-BLED-scoren [2]
som er anbefalet i de seneste europæiske / amerikanske retningslinjer til at
vurdere indikationen for antikoagulatonsbehandling til patienter med
atrieflimren [3-4]. De vigtigste forskelle er følgende:"
explanitory_text_3 <-
  "Alder er inkluderet som en kontinuerlig variabel"
explanitory_text_4 <-
  "Den samlede risikoberegning tager højde for ikke en sum af risikofaktorer,
men deres individuelle bidrag."



references <- "References:"
references_size <- "12px"

ref1 <-
  "Lee J-Y.C, Ozenne B, Toft-Petersen AP, Phelps MD, Gislason G, Olesen JB,
Torp-Pedersen C, Gerds TA. The individual risk of stroke in patients with atrial
fibrillation by the CHADSVASC score."
ref_size <- "12px"

ref2 <-
  "Kirchhof P, Benussi S, Kotecha D, Ahlsson A, Atar D, Casadei B, m.fl.
2016 ESC Guidelines for the management of atrial fibrillation developed in collaboration with EACTS.
Eur Heart J. 7. October 2016;37(38):2893–962."


ref3 <-
  "January CT, Wann LS, Alpert JS, Calkins H, Cigarroa JE, Cleveland JC, m.fl.
2014 AHA/ACC/HRS Guideline for the Management of Patients With Atrial Fibrillation:
Executive Summary: A Report of the American College of Cardiology/
American Heart Association Task Force on Practice Guidelines and the Heart Rhythm Society.
J Am Coll Cardiol. 2. December 2014;64(21):2246–80."


ref4 <- "Lip GYH, Nieuwlaat R, Pisters R, Lane DA, Crijns HJGM.
Refining clinical risk stratification for predicting stroke and thromboembolism in atrial fibrillation
using a novel risk factor-based approach: the euro heart survey on atrial fibrillation.
Chest. February 2010;137(2):263-72."



# Text that appears when user has not entered an appropriate age (i.e. <20 ||
# >99 || not a whole number)
enter_age <-
  "Indtast patientens alder (mellem 20 og 99) i feltet"

library(dplyr)
library(haven)

gles_raw <- read_dta("data_raw/gles_2025/ZA10100_v3-0-0.dta")

gles <- gles_raw |>
  mutate(

  # Vote choice -------------------------------------------------------------
    vote = case_when(q114ba == 1 ~   "CDU/CSU",
                     q114ba == 4 ~   "SPD",
                     q114ba == 5 ~   "FDP",
                     q114ba == 6 ~   "GRUENE",
                     q114ba == 7 ~   "DIE LINKE",
                     q114ba == 322 ~ "AfD",
                     q114ba == 801 ~ "andere Partei"),
    vote = factor(vote, levels = c("CDU/CSU",
                                   "SPD",
                                   "FDP",
                                   "GRUENE",
                                   "DIE LINKE",
                                   "AfD",
                                   "andere Partei")),
  
  # Vote for the AdD --------------------------------------------------------
    vote_afd = case_when(vote == "AfD" ~ "Yes", 
                         !is.na(vote) ~ "No"),
    vote_afd = factor(vote_afd, levels = c("No", "Yes")), 
  
  # University education ----------------------------------------------------
    edu = if_else(d8i == 1 | d8o == 1 | d8p == 1 | d8q == 1,
                       "High",
                       "Low"),
    edu = factor(edu, levels = c("Low", "High")),
  
  # Household income --------------------------------------------------------
    income = if_else(d63 > 0, 
                     d63, 
                     NA_real_),
    income = case_when(income <= quantile(income, na.rm = TRUE)[2] ~ "Q1 (lowest)",
                       income > quantile(income, na.rm = TRUE)[2] & income <= quantile(income, na.rm = TRUE)[3] ~ "Q2",
                       income > quantile(income, na.rm = TRUE)[3] & income <= quantile(income, na.rm = TRUE)[4] ~ "Q3",
                       income > quantile(income, na.rm = TRUE)[4] ~ "Q4 (highest)"),
    income = factor(income),
  
  # Place of residence ------------------------------------------------------
    residence = case_when(wum6 == 1 ~ "Big city",
                          wum6 == 2 ~ "Outskirts of a big city",
                          wum6 == 3 ~ "Medium or small town",
                          wum6 %in% c(4, 5) ~ "Rural"),
    residence = factor(residence, levels = c("Big city",
                                             "Outskirts of a big city",
                                             "Medium or small town",
                                             "Rural")),
  
  # Region ------------------------------------------------------------------
    region = recode_values(ostwest2, 
                         0 ~ "East", 
                         1 ~ "West"),
    region = factor(region, levels = c("West", "East")),
  
  # Gender ------------------------------------------------------------------
  gender = recode_values(d1, 
                         1 ~ "Male", 
                         2 ~ "Female"),
  gender = factor(gender, levels = c("Female", "Male")),
  
  # Age ---------------------------------------------------------------------
    yearborn = case_when(d2a == "1935 oder frueher" ~ 1935,
                         d2a == ~ "-99 keine Angabe" ~ NA_real_,
                         TRUE ~ as.numeric(d2a)),
    age = 2025 - yearborn,
    age_group = case_when(age < 30 ~ "16-29", 
                          age >= 30 & age < 55 ~ "30-54", 
                          age >= 55 ~ "55+"),
    age_group = factor(age_group)
  
  ) |>
  select(vote_afd, 
         edu, 
         income, 
         residence, 
         region, 
         gender,
         age_group)

# Add labels --------------------------------------------------------------

attr(gles$vote_afd, "label") <- "AfD vote (2nd vote)"
attr(gles$edu, "label") <- "Education (High: university education)"
attr(gles$income, "label") <- "Household income (quartiles)"
attr(gles$residence, "label") <- "Place of residence"
attr(gles$region, "label") <- "Region: West/East"
attr(gles$gender, "label") <- "Gender"
attr(gles$age_group, "label") <- "Age group"

saveRDS(gles, file = "data/2026-07-02_gles.rds")

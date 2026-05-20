# Bundeswahlleiterin
# Seminar session: 2026-05-21
# ==============================================================================

# Source: https://www.bundeswahlleiterin.de/bundestagswahlen/2025/ergebnisse/opendata.html

library(dplyr)
library(readr)

# Import results from Bundeswahlleiter ------------------------------------

bwl_results_raw <- read_csv2("data_raw/bwl_btw_2025/kerg.csv", 
                             skip = 8,
                             col_names = FALSE)

bwl_results <- bwl_results_raw  |> 
  select(district_num = X1,
         district_name = X2,
         state = X3,
         n_eligible = X5,
         n_voting = X11,
         n_valid_2nd_vote = X19,
         spd = X23,
         cdu = X27,
         greens = X31,
         fdp = X35,
         afd = X39,
         csu = X43,
         left = X47,
         bsw = X127) |>
  mutate(across(c(district_num, state), as.numeric)) |> 
  filter(!is.na(state) & state != 99) |>
  mutate(turnout = (n_voting / n_eligible) * 100,
         # Convert number of valid 2nd vote to percentages
         across(c(spd, 
                  cdu, 
                  greens, 
                  fdp,
                  afd,
                  csu,
                  left,
                  bsw),
                ~ (.x / n_valid_2nd_vote) * 100),
         union = coalesce(cdu, csu),
         state = case_when(state == 1 ~ "SH",
                                state == 2 ~ "HH",
                                state == 3 ~ "NI",
                                state == 4 ~ "HB",
                                state == 5 ~ "NW",
                                state == 6 ~ "HE",
                                state == 7 ~ "RP",
                                state == 8 ~ "BW",
                                state == 9 ~ "BY",
                                state == 10 ~ "SL",
                                state == 11 ~ "BE",
                                state == 12 ~ "BB",
                                state == 13 ~ "MV",
                                state == 14 ~ "SN",
                                state == 15 ~ "ST",
                                state == 16 ~ "TH"),
         state = factor(state),
         region = case_when(state == "BE" ~ "Berlin",
                            state %in% c("BB", "MV", "SN", "ST", "TH") ~ "East",
                            TRUE ~ "West"),
         region = factor(region, levels = c("West", "East", "Berlin"))) |>
  select(state,
         region,
         district_num,
         district_name,
         turnout,
         union,
         afd,
         spd,
         greens,
         left,
         bsw,
         fdp)


# Import structure data ---------------------------------------------------

bwl_str_raw <- read_csv2("data_raw/bwl_btw_2025/btw2025_strukturdaten.csv", 
                         skip = 9)

bwl_str <- bwl_str_raw |>
  select(
    district_num = `Wahlkreis-Nr.`,
    gdp = `Bruttoinlandsprodukt 2021 (EUR je EW)`,
    income = `Verfügbares Einkommen der privaten Haushalte 2021 (EUR je EW)`,
    unemp = `Arbeitslosenquote November 2024 - insgesamt`
  ) |>
  mutate(
    district_num = as.numeric(district_num),
    gdp = gdp / 1000,
    income = income / 1000
  )


# Merge data --------------------------------------------------------------

bwl <- bwl_results |>
  left_join(bwl_str, by = join_by(district_num))


# Add variable labels -----------------------------------------------------

attr(bwl$state, "label") <- "State"
attr(bwl$region, "label") <- "Region"
attr(bwl$district_num, "label") <- "District number"
attr(bwl$district_name, "label") <- "District name"
attr(bwl$turnout, "label") <- "Voter turnout, federal election 2025"
attr(bwl$union, "label") <- "Vote share CDU/CSU (%)"
attr(bwl$afd, "label") <- "Vote share AfD (%)"
attr(bwl$spd, "label") <- "Vote share SPD (%)"
attr(bwl$greens, "label") <- "Vote share Greens (%)"
attr(bwl$left, "label") <- "Vote share The Left (%)"
attr(bwl$bsw, "label") <- "Vote share BSW (%)"
attr(bwl$fdp, "label") <- "Vote share FDP (%)"
attr(bwl$gdp, "label") <- "Gross domestic product 2021 (x 1,000 EUR per capita)"
attr(bwl$income, "label") <- "Disposable household income 2021 (x 1,000 EUR per capita)"
attr(bwl$unemp, "label") <- "Unemployment rate November 2024 - total"

# Save data ---------------------------------------------------------------

saveRDS(bwl, file = "data/2026-05-21_bwl.rds")

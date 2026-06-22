library(dplyr)
library(readxl)
library(tidyr) # Pivot data from wide to long (and vice versa)
library(worldbank) # Import World Bank Data

# Note: observations are merged by country code (ISO-3C) and year. 

# Download raw data -------------------------------------------------------

# https://www.idea.int/data-tools/data/advanced-search?tid=293

# Select database (and questions) > Voter Turnout Database > Parliamentary > Voter Turnout + Compulsory voting
# Select the geographic scope > Alphabetically > Select all
# Time options > From 2015 to 2025
# Export

idea_raw <- read_xls("data_raw/idea/idea_voter_turnout_2026-06-22.xls",
                     skip = 2,
                     na = "-",
                     col_names = c("country",
                                   "iso2c",
                                   "ccode",
                                   "date",
                                   "turnout",
                                   "compul_voting"
                                   ),
                     col_types = c("text", 
                                   "text", 
                                   "text", 
                                   "text", 
                                   "numeric", 
                                   "text")
                     )

idea <- idea_raw |>
  mutate(year = substr(date, 1, 4), # Extracts first 4 characters of Date
         year = as.numeric(year),
         compul_voting = factor(compul_voting)) |> 
  select(country,
         ccode,
         year,
         turnout,
         compul_voting) |> 
  group_by(country) |> 
  slice_max(year) # Keep last election by country


# Import V-Dem Data -------------------------------------------------------

vdem_raw <- readRDS("data_raw/v-dem/V-Dem-CY-Full+Others-v16.rds")

vdem <- vdem_raw |>
  filter(year >= 2016) |>
  select(
    ccode = country_text_id,
    year,
    voting_age = v2elage,
    elect_system = v2elparlel,
    democracy = v2x_polyarchy,
    corruption = v2x_corr,
    regime = v2x_regime
  ) |>
  mutate(
    regime = case_when(
      regime == 0 ~ "Closed autocracy",
      regime == 1 ~ "Electoral autocracy",
      regime == 2 ~ "Electoral democracy",
      regime == 3 ~ "Liberal democracy"
    ),
    regime = factor(
      regime,
      levels = c(
        "Closed autocracy",
        "Electoral autocracy",
        "Electoral democracy",
        "Liberal democracy"
      )
    ),
    
    voting_age = factor(voting_age, levels = c("16", "17", "18")),
    
    elect_system = case_when(
      elect_system == 0 ~ "Majoritarian",
      elect_system == 1 ~ "Proportional",
      elect_system == 2 ~ "Mixed"
    ),
    elect_system = factor(
      elect_system,
      levels = c("Majoritarian", "Proportional", "Mixed")
    )
  )

# Import World Bank Data --------------------------------------------------

# Note: Look for indicators with wb_search()

indicators <- c(
  "NY.GDP.PCAP.PP.KD",   # GDP per capita, PPP (constant 2017 international $)
  "SL.UEM.TOTL.ZS",      # Unemployment, total (% of total labor force)
  "SP.POP.TOTL",         # Total population
  "SI.POV.GINI"          # Gini index
)

wb_raw <- wb_data(indicator = indicators, 
                  mrv = 10, # Keep last 10 values
                  gapfill = TRUE # Extend last value if missing
                  )

wb <- wb_raw |>
  select(country_code, 
         date, 
         indicator_id, 
         value
  ) |>
  filter(!is.na(country_code)) |> 
  pivot_wider(names_from = indicator_id,
              values_from = value) |>
  rename(ccode = country_code, 
         year = date,
         gdp = NY.GDP.PCAP.PP.KD,
         unemp = SL.UEM.TOTL.ZS,
         population = SP.POP.TOTL,
         gini = SI.POV.GINI) |>
  mutate(gdp = gdp / 1000,
         population = population / 1000000) |> 
  select(ccode,
         year, 
         gdp,
         unemp,
         population,
         gini) |> 
  filter(year %in% 2015:2025)


# Merge datasets ----------------------------------------------------------

main <- idea |>
  left_join(vdem, by = c("ccode", "year")) |>
  # Keep only observations for electoral and liberal democracies
  filter(regime == "Electoral democracy" | regime == "Liberal democracy")  |>
  select(-c(regime)) |>
  left_join(wb, by = c("ccode", "year")) 


# Add variable labels -----------------------------------------------------

attr(main$country, "label") <- "Country"
attr(main$ccode, "label") <- "Country code (ISO-3C)"
attr(main$year, "label") <- "Year"
attr(main$turnout, "label") <- "Voter turnout (based on registered voters)"
attr(main$democracy, "label") <- "Electoral democracy index"
attr(main$corruption, "label") <- "Corruption index"
attr(main$voting_age, "label") <- "Voting age"
attr(main$compul_voting, "label") <- "Compulsory voting"
attr(main$elect_system, "label") <- "Electoral system"
attr(main$gdp, "label") <- "GDP per capita, PPP (in thousands of dollars)"
attr(main$unemp, "label") <- "Unemployment, total (% of total labor force)"
attr(main$population, "label") <- "Total population (in millions)"
attr(main$gini, "label") <- "Gini index"

# Save data ---------------------------------------------------------------

saveRDS(main, "data/2026-06-25_idea.rds")


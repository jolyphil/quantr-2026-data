library(countrycode)
library(dplyr)
library(haven)
library(readr)
library(tidyr)
library(worldbank)

issp_raw <- read_stata("data_raw/issp/ZA10010_v1-0-0.dta")


# -------------------------------------------------------------------------
# Satisfaction with democracy

attributes(issp_raw$v38)

# $label
# [1] "Q15 Poorly/well: How well does democracy work in [CNTRY] today"
# 
# $format.stata
# [1] "%16.0g"
# 
# $class
# [1] "haven_labelled" "vctrs_vctr"     "double"        
# 
# $labels
# -9. No answer -8. Can't choose   0. Very poorly    10. Very well 
#               -9               -8                0               10 

# -------------------------------------------------------------------------
# Support for economic redistribution

attributes(issp_raw$v45)
# $label
# [1] "Q22 Agree/ Disagree: It should be governmt.'s responsibility to reduce income di"
# 
# $format.stata
# [1] "%29.0g"
# 
# $class
# [1] "haven_labelled" "vctrs_vctr"     "double"        
# 
# $labels
# -9. No answer              -8. Can't choose             1. Strongly agree 
#                            -9                            -8                             1 
#                      2. Agree 3. Neither agree nor disagree                   4. Disagree 
#                             2                             3                             4 
#          5. Strongly disagree 
#                             5 


# -------------------------------------------------------------------------
# Social trust

attributes(issp_raw$v59)
# $label
# [1] "Q36 People can be trusted OR you can't be too careful in dealing with people"
# 
# $format.stata
# [1] "%66.0g"
# 
# $class
# [1] "haven_labelled" "vctrs_vctr"     "double"        
# 
# $labels
# -9. No answer 
# -9 
# -8. Can't choose 
#                                                               -8 
#                           1. People can almost always be trusted 
#                                                                1 
#                                 2. People can usually be trusted 
#                                                                2 
#       3. You usually can't be too careful in dealing with people 
# 3 
# 4. You almost always can’t be too careful in dealing with people 
# 4 

issp <- issp_raw |> 
  mutate(demosatis = recode_values(v38,
                                   6:10 ~ 1,
                                   0:5  ~ 0),
         redis = recode_values(v45,
                               1:2 ~ 1,
                               3:5 ~ 0),
         soctrust = recode_values(v59,
                                      1:2 ~ 1,
                                      3:4 ~ 0)) |>
  rename(ccode = c_alphan) |> 
  group_by(ccode) |> 
  summarize(across(
              .cols = c(demosatis,
                        redis,
                        soctrust),
              .fns = ~ weighted.mean(x = .x, w = WEIGHT_COM, na.rm = TRUE) * 100),
            year = mean(DATEYR) |> round()) |> 
  mutate(country = countrycode(ccode,
                               origin = "iso2c",
                               destination = "country.name")) |>
  mutate(postcommunist = if_else(country %in% c("Croatia",
                                                "Hungary",
                                                "Lithuania",
                                                "Russia",
                                                "Slovakia",
                                                "Slovenia"),
                                 "Yes",
                                 "No"),
         postcommunist = factor(postcommunist, levels = c("No", 
                                                          "Yes"))) |> 
  relocate(country) |> 
  relocate(year, .after = ccode)

# Import World Bank Data --------------------------------------------------

# Note: Look for indicators with wb_search()

indicators <- c(
  "NY.GDP.PCAP.PP.KD",   # GDP per capita, PPP (constant 2017 international $)
  "SL.UEM.TOTL.ZS"      # Unemployment, total (% of total labor force)
)

wb_raw <- wb_data(indicator = indicators, 
                  country = unique(issp$ccode),
                  start_date = 2022,
                  end_date = 2025) 

wb <- wb_raw |>
  select(ccode = country_id, 
         year = date, 
         indicator_id, 
         value
  ) |>
  pivot_wider(names_from = indicator_id,
              values_from = value) |> 
  rename(gdp = NY.GDP.PCAP.PP.KD,
         unemp = SL.UEM.TOTL.ZS) |> 
  mutate(gdp = gdp / 1000) |> 
  arrange(ccode, year)


# Import V-Dem Data -------------------------------------------------------

# v2x_polyarchy: Electoral democracy index
# v2x_corr: Corruption index

vdem_raw <- readRDS("data_raw/v-dem/V-Dem-CY-Core-v16.rds")

vdem <- vdem_raw |>
  select(country_text_id, year, v2x_polyarchy, v2x_corr) |>
  rename(ccode = country_text_id,
         democracy = v2x_polyarchy,
         corruption = v2x_corr) |>
  mutate(ccode = countrycode(ccode,
                             origin = "iso3c",
                             destination = "iso2c"))

# Merge datasets ----------------------------------------------------------

main <- issp |>
  left_join(wb, by = c("ccode", "year")) |>
  left_join(vdem, by = c("ccode", "year"))


# Add variable labels -----------------------------------------------------

attr(main$country, "label") <- "Country"
attr(main$ccode, "label") <- "Country code, ISO2C"
attr(main$year, "label") <- "Year"
attr(main$demosatis, "label") <- "Satisfaction with democracy (%)"
attr(main$redis, "label") <- "Support for redistribution (%)"
attr(main$soctrust, "label") <- "Social trust (%)"
attr(main$postcommunist, "label") <- "Postcommunist country"
attr(main$gdp, "label") <- "GDP per capita, PPP (1000$)"
attr(main$unemp, "label") <- "Unemployment, total (% of total labor force)"
attr(main$democracy, "label") <- "Electoral democracy index"
attr(main$corruption, "label") <- "Corruption index"

# Save dataset ------------------------------------------------------------

saveRDS(main, "data/2026-06-18_issp.rds")

library(dplyr)

party <- c("CDU/CSU",
           "AfD",
           "SPD",
           "Bündnis 90/Die Grünen",
           "Die Linke",
           "Other")
seat_n <- c(207,
            150,
            120,
            85,
            64,
            3)
leader <- c("J. Spahn",
            "T. Chrupalla; A. Weidel",
            "Miersch, M.", 
            "K. Dröge; B. Haßelmann",
            "H. Reichinnek; S. Pellmann",
            NA)

bt <- data.frame(party, seat_n, leader) |> 
  mutate(seat_share = seat_n / sum(seat_n),
         seat_share = round(seat_share, digits = 2),
         gov = if_else(party %in% c("CDU/CSU", "SPD"),
                       "Government",
                       "Opposition"),
         gov = factor(gov, levels = c("Opposition", "Government"))) |> 
  relocate(seat_share, .after = seat_n)

saveRDS(bt, "data/2026-06-04_bt.rds")

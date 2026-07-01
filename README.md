# Data preparation for the "Quantitative Analysis in R" BA seminar (summer semester 2026)

This repository contains raw data on topics relevant in political sociology and scripts to transform it. You are free to use this material for your research project. 

---

## May 7: Subset of the European Social Survey (ESS), Round 11

### Raw Data

- Reference: European Social Survey European Research Infrastructure (ESS ERIC). (2026). ESS11 integrated file, edition 4.1 [Data set]. Sikt - Norwegian Agency for Shared Services in Education and Research. https://doi.org/10.21338/ess11e04_1
- License: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0)
- Raw data (CSV): [`data_raw/ess_11/ESS11e04_1.csv`](data_raw/ess_11/ESS11e04_1.csv)
- Codebook (HTML): [`data_raw/ess_11/ESS11e04_1_codebook.html`](data_raw/ess_11/ESS11e04_1_codebook.html)

### Files

- Clean data (RDS): [`data/2026-05-07_ess_11.rds`](data/2026-05-07_ess_11.rds)
- Data preparation script (R): [`data_raw/ess_11/2026-05-07_ess_11_data_preparation.R`](data_raw/ess_11/2026-05-07_ess_11_data_preparation.R)

---

## May 21: Data on the German federal election 2025

### Raw Data

**Election results**

- Reference: Bundeswahlleiterin. (2025). _Bundestagswahl 2025: Amtliches Endergebnis_. https://www.bundeswahlleiterin.de/bundestagswahlen/2025/ergebnisse/opendata.html 
- License: [Data licence Germany – attribution – version 2.0](https://www.govdata.de/dl-de/by-2-0)
- Data file (CSV): [`data_raw/bwl_btw_2025/kerg.csv`](data_raw/bwl_btw_2025/kerg.csv)

**Structural data**

- Reference: Bundeswahlleiterin & Bundesagentur für Arbeit. (2025). _Strukturdaten für die Wahlkreise zum 21. Deutschen Bundestag_. https://www.bundeswahlleiterin.de/bundestagswahlen/2025/ergebnisse/opendata.html 
- License: [Data licence Germany – attribution – version 2.0](https://www.govdata.de/dl-de/by-2-0)
- Data file (CSV): [`data_raw/bwl_btw_2025/btw2025_strukturdaten.csv`](data_raw/bwl_btw_2025/btw2025_strukturdaten.csv)

### Data preparation

- Data preparation script (R): [`data_raw/bwl_btw_2025/2026-05-21_bwl_btw_2025_data_preparation.R`](data_raw/bwl_btw_2025/2026-05-21_bwl_btw_2025_data_preparation.R)
- Clean data (RDS): [`data/bwl_btw_2025/2026-05-21_bwl.rds`](data/bwl_btw_2025/2026-05-21_bwl.rds)

---

## June 18: ISSP data aggregated at the country level and merged with World Bank and V-Dem data

### Raw data

**ISSP, National Identity and Citizenship Module (2023)**

- Reference: ISSP Research Group (2026). International Social Survey Programme: National Identity & Citizenship - ISSP 2023 (ZA10010; Version 1.0.0) [Data set]. GESIS, Köln. https://doi.org/10.4232/5.ZA10010.1.0.0
- License: [GESIS access Category A]()
- Data file (Stata, DTA): Download from GESIS at https://doi.org/10.4232/5.ZA10010.1.0.0 (registration required)

**Democracy indices**

- Reference:
  * Coppedge, M., Gerring, J., Knutsen, C. H., Lindberg, S. I., Teorell, J., Altman, D., Angiolillo, F., Bernhard, M., Cornell, A., Fish, M. S., Fox, L., Gastaldi, L., Gjerløw, H., Glynn, A., Good God, A., Hicken, A., Kinzelbach, K., Krusell, J., Marquardt, K. L., ... Ziblatt, D. (2026). V-Dem [Country-Year/Country-Date] Dataset (Version 16) [Data set]. _Varieties of Democracy (V-Dem) Project_. https://doi.org/10.23696/vdemds26
  * Pemstein, D., Marquardt, K. L., Tzelgov, E., Wang, Y.-T., Medzihorsky, J., Krusell, J., Miri, F., & von Römer, J. (2026). The V-Dem measurement model: Latent variable analysis for cross-national and cross-temporal expert-coded data (11th ed., V-Dem Working Paper No. 21). _Varieties of Democracy Institute_, University of Gothenburg. https://www.v-dem.net/media/publications/wp21_2025.pdf
- License: "open source and free for anyone to use"
- Data file (RDS): [`data_raw/v-dem/V-Dem-CY-Core-v16.rds`](data_raw/v-dem/V-Dem-CY-Core-v16.rds)

**Economic data**

- Reference: World Bank. (2026). World Bank Open Data. https://data.worldbank.org/ 
- License: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0)
- Data file: Data imported using the [_worldbank_](https://m-muecke.github.io/worldbank/) R package. 

### Data preparation

- Data preparation script (R): [`data_raw/issp/2026-06-18_issp_data_preparation.R`](data_raw/issp/2026-06-18_issp_data_preparation.R)
- Clean data (RDS): [`data/2026-06-18_issp.rds`](data/2026-06-18_issp.rds)

---

## June 25: Voter turnout data from the International IDEA merged with World Bank and V-Dem data

### Raw Data

**Voter turnout data**

- Reference: International IDEA. (2026). Voter Turnout Database. https://www.idea.int/data-tools/data/voter-turnout-database 
- License: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0)
- Data file (Excel): [`data_raw/idea/idea_voter_turnout_2026-06-22.xls`](data_raw/idea/idea_voter_turnout_2026-06-22.xls)

**Democracy indices**

- Reference:
  * Coppedge, M., Gerring, J., Knutsen, C. H., Lindberg, S. I., Teorell, J., Altman, D., Angiolillo, F., Bernhard, M., Cornell, A., Fish, M. S., Fox, L., Gastaldi, L., Gjerløw, H., Glynn, A., Good God, A., Hicken, A., Kinzelbach, K., Krusell, J., Marquardt, K. L., ... Ziblatt, D. (2026). V-Dem [Country-Year/Country-Date] Dataset (Version 16) [Data set]. _Varieties of Democracy (V-Dem) Project_. https://doi.org/10.23696/vdemds26
  * Pemstein, D., Marquardt, K. L., Tzelgov, E., Wang, Y.-T., Medzihorsky, J., Krusell, J., Miri, F., & von Römer, J. (2026). The V-Dem measurement model: Latent variable analysis for cross-national and cross-temporal expert-coded data (11th ed., V-Dem Working Paper No. 21). _Varieties of Democracy Institute_, University of Gothenburg. https://www.v-dem.net/media/publications/wp21_2025.pdf
- License: "open source and free for anyone to use"
- Data file (RDS): [`data_raw/v-dem/V-Dem-CY-Full+Others-v16.rds`](data_raw/v-dem/V-Dem-CY-Full+Others-v16.rds)

**Economic data**

- Reference: World Bank. (2026). World Bank Open Data. https://data.worldbank.org/ 
- License: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0)
- Data file: Data imported using the [_worldbank_](https://m-muecke.github.io/worldbank/) R package. 

### Data preparation

- Data preparation script (R): [`data_raw/idea/2026-06-25_idea_data_preparation.R`](data_raw/idea/2026-06-25_idea_data_preparation.R)
- Clean data (RDS): [`data/2026-06-25_idea.rds`](data/2026-06-25_idea.rds)

---

## July 2 (1/2): Subset of the European Social Survey (ESS), Round 11

### Raw Data

- Reference: European Social Survey European Research Infrastructure (ESS ERIC). (2026). ESS11 integrated file, edition 4.1 [Data set]. Sikt - Norwegian Agency for Shared Services in Education and Research. https://doi.org/10.21338/ess11e04_1
- License: [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0)
- Raw data (CSV): [`data_raw/ess_11/ESS11e04_1.csv`](data_raw/ess_11/ESS11e04_1.csv)
- Codebook (HTML): [`data_raw/ess_11/ESS11e04_1_codebook.html`](data_raw/ess_11/ESS11e04_1_codebook.html)

### Files

- Clean data (RDS): [`data/2026-07-02_ess_11.rds`](data/2026-07-02_ess_11.rds)
- Data preparation script (R): [`data_raw/ess_11/2026-07-02_ess_11_data_preparation.R`](data_raw/ess_11/2026-07-02_ess_11_data_preparation.R)

---

## July 2 (2/2):  German Longitudinal Election Study (GLES), Cross-Section 2025, Post-Election

### Files

- Clean data (RDS): [`data/2026-07-02_gles.rds`](data/2026-07-02_gles.rds)
- Data preparation script (R): [`data_raw/gles_2025/2026-07-02_gles_2025_data_preparation.R`](data_raw/gles_2025/2026-07-02_gles_2025_data_preparation.R)

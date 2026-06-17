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
- Clean data (RDS): [`data/bwl_btw_2025/2026-05-07_ess_11.rds`](data/bwl_btw_2025/2026-05-07_ess_11.rds)

---

## June 18: ISSP data aggregated at the country level and merged with World Bank and V-Dem data

### Data preparation

- Data preparation script (R): [`data_raw/issp/2026-06-18_issp_data_preparation.R`](data_raw/issp/2026-06-18_issp_data_preparation.R)
- Clean data (RDS): [`data/2026-06-18_issp.rds`](data/2026-06-18_issp.rds)

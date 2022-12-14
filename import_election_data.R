library(tidyverse)

election_raw <- read.csv("2020_general_election_data/president.csv")
voter_reg_raw <- read.csv("2020_general_election_data/voter data.csv")
voter_pop_raw <- read.csv("2020_general_election_data/vtds20g_pop.txt")

election <- 
  election_raw %>% 
  select(VTDKEY, Biden = BidenD_20G_President, Trump = TrumpR_20G_President) %>% 
  left_join(
    voter_reg_raw %>% 
      select(VTDKEY, Voter_Registration, Turnout), 
    by = c("VTDKEY" = "VTDKEY")
  ) %>% 
  left_join(
    voter_pop_raw %>% 
      select(VTDKEY, VTD, vap, anglovap, nanglovap, FENAME), 
    by = c("VTDKEY" = "VTDKEY")
  )

save(election, file = "csv_and_matfiles/election_data.Rdata")
write.csv(election, file = "csv_and_matfiles/district_demographics.csv")


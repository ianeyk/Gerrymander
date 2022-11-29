library(tidyverse)

election_raw <- read.csv("2020_general_election_data/president.csv")
voter_reg_raw <- read.csv("2020_general_election_data/voter data.csv")

election <- 
  election_raw %>% 
  select(VTDKEY, Biden = BidenD_20G_President, Trump = TrumpR_20G_President) %>% 
  left_join(
    voter_reg_raw %>% 
      select(VTDKEY, Voter_Registration, Turnout), 
    by = c("VTDKEY" = "VTDKEY")
  )

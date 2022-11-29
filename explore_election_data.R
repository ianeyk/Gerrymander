load("election_data.Rdata")

election %>% 
  distinct(VTD)

election %>% 
  filter(VTD == 0015)

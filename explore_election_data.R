load("election_data.Rdata")

# show that for a given VTD, there are multiple VTDKEY's in different counties
election %>% 
  filter(VTD == "0015")


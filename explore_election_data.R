library(tidyverse)

# load("election_data.Rdata")

# show that for a given VTD, there are multiple VTDKEY's in different counties
# election %>% 
#   filter(VTD == "0015")

# in_map_but_not_in_pop <- 
#   district_outlines %>% 
#     anti_join(election, by = c("VTDKEY" = "VTDKEY"))
# 
# in_pop_but_not_in_map <- 
#   election %>% 
#     anti_join(district_outlines, by = c("VTDKEY" = "VTDKEY"))


biden_trump_sum <- 
  election %>% 
    # select(CNTYVTD, vap, Biden, Trump) %>% 
    select(VTDKEY, vap, Biden, Trump) %>% 
    na.omit(vap) %>% 
    mutate(Biden_Trump_sum = Biden + Trump, .keep = "unused") %>% 
    mutate(vap_turnout = Biden_Trump_sum / vap) %>% 
    arrange(desc(vap_turnout))

biden_trump_sum %>% 
  na.omit(vap) %>% 
  filter(vap_turnout > 1)

election %>% 
  # filter(VTDKEY.x < 2500, VTDKEY.x > 2000) %>% 
  ggplot() + 
  geom_point(mapping = aes(x = VTDKEY.x, y = VTDKEY.y), color = "blue") + 
  geom_point(mapping = aes(x = VTDKEY.x, y = VTDKEY.x), color = "red")

election %>% 
  # filter(VTDKEY.x < 2500, VTDKEY.x > 2000) %>% 
  ggplot() + 
  geom_point(mapping = aes(x = VTDKEY.y, y = VTDKEY.x), color = "blue") + 
  geom_point(mapping = aes(x = VTDKEY.y, y = VTDKEY.y), color = "red")

election %>% 
  # filter(VTDKEY.x < 2500, VTDKEY.x > 2000) %>%
  mutate(biden_trump_sum = Biden + Trump) %>% 
  rowwise() %>% 
  mutate(turnout = min(biden_trump_sum / vap * 5000, 15000)) %>% 
  ggplot() + 
  geom_point(mapping = aes(x = VTDKEY.x, y = vap), color = "blue") + 
  geom_point(mapping = aes(x = VTDKEY.x, y = biden_trump_sum), color = "red") + 
  geom_line(mapping = aes(x = VTDKEY.x, y = turnout), color = "green")

election %>% 
  ggplot() + 
  geom_point(mapping = aes(x = CNTYVTD.x, y = CNTYVTD.y), color = "blue") + 
  geom_point(mapping = aes(x = CNTYVTD.x, y = CNTYVTD.x), color = "red")


# Load packages
library(sf)
library(mapview)
library(spdep)
library(igraph)

# data
district_outlines <- st_read("raw_data/vtds20g_2020/VTDs20G_2020.shp")

# display data
mapview(district_outlines)

# estimate first order adjacency matrix
nb_result <- poly2nb(district_outlines, queen = FALSE)
district_adjacency_mat <- nb2mat(nb_result, style = "B")

district_graph <- graph.adjacency(district_adjacency_mat)
district_edge_list <- get.edgelist(district_graph)

write.csv(district_edge_list, file = "district_edge_list.csv")


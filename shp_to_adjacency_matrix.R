# Load packages
library(sf)
library(mapview)
library(spdep)
library(igraph)

# data
district_outlines <- st_read("raw_data/vtds_22p/VTDs_22P.shp")

# display data
mapview(district_outlines)

# estimate first order adjacency matrix
district_adjacency_mat <- nb2mat(poly2nb(district_outlines), style = "B")
district_adjacency_mat[1:10, 1:10]

district_graph <- graph.adjacency(district_adjacency_mat)
district_edge_list <- get.edgelist(district_graph)

write.csv(district_edge_list, file = "district_edge_list.csv")


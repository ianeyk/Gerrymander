%% Generate Graph
edges = readtable("district_edge_list.csv");
edges = edges(:, 2:end);
edges_array = table2array(edges);
EdgeTable = table(edges_array,'VariableNames',{'EndNodes'});

population = readtable("district_demographics.csv");
population = population(:, 2:end);

G = graph(EdgeTable);
%% Adjacency Matrix
A = adjacency(G)

[idx, src, dst] = lib.generateSpanningTrees(A);
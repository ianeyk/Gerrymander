clear; % So the workspace is cleared and ready to save

%% Read Data and Generate VTD Graph
% Read in centroid data generated from geographic district map in R
centroids = readmatrix("csv_and_matfiles/district_centroids.csv");
centroids = centroids(2:end, 2:end); % readmatrix tends to add an extra column for indexes and a row of NaN's at the top

% Read in population data cleaned in R
population = readtable("csv_and_matfiles/district_demographics.csv");
population = population(:, ["VTDKEY", "Biden", "Trump", "Voter_Registration", "Turnout", "vap", "anglovap", "FENAME"]);

% Read edge list generated from geographic district map in R
edges = readmatrix("csv_and_matfiles/district_edge_list.csv");
edges = edges(2:end, 2:end); % readmatrix tends to add an extra column for indexes and a row of NaN's at the top
nodes = unique(edges);
EdgeTable = table(edges,'VariableNames',{'EndNodes'});
NodeTable = table(nodes, 'VariableNames', {'VTDKEY'});
NodeTable = join(NodeTable,population);

% Create graph object and adjacency matrix
G = simplify(graph(EdgeTable, NodeTable));
A = adjacency(G);
% Use this to see a plot of the graph
plot(G, 'XData', centroids(:,1), 'YData', centroids(:,2));

% Add a column to G with the index of each county in alphabetical order. Used as a starting point for the ReCom algorithm.
county_names = unique(G.Nodes.FENAME);
for idx = 1:length(county_names)
    county_name = county_names(idx);
    G.Nodes.district_id(strcmp(G.Nodes.FENAME, county_name)) = idx;
end

save("recomb_initial_state.mat");
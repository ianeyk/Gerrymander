%% Generate Graph
edges = readtable("csv_and_matfiles/district_edge_list.csv");
edges = edges(:, 2:3);
edges_array = table2array(edges);
nodes = unique(edges_array);
EdgeTable = table(edges_array,'VariableNames',{'EndNodes'});
centroids = readmatrix("csv_and_matfiles/district_centroids.csv");
centroids = centroids(2:end, 2:end);

population = readtable("csv_and_matfiles/district_demographics.csv");
population = population(:, ["VTDKEY", "Biden", "Trump", "Voter_Registration", "Turnout", "vap", "anglovap", "FENAME"]);

NodeTable = table(nodes, 'VariableNames', {'VTDKEY'});
NodeTable = join(NodeTable,population);

G = simplify(graph(EdgeTable, NodeTable));
A = adjacency(G);
% plot(G, 'XData', centroids(:,1), 'YData', centroids(:,2));

county_names = unique(G.Nodes.FENAME)
for jj = 1:length(county_names)
    county_name = county_names(jj)
%     strcmp(G.Nodes.FENAME, county_name)
    G.Nodes.starting_districts(strcmp(G.Nodes.FENAME, county_name)) = jj
end

%% Spanning Tree Algorithm
G2 = G;

root = randsample(nodes, 1);

T = graph(); % final spanning tree
u = root;
disp("Working... You will not see the first output for a few seconds.")
for node = 1:length(nodes)
    % first, if the node is already in T, then skip it
    if any(T.Edges.EndNodes == node, "all") & length(T.Edges.EndNodes) > 0
        continue
    end
    S = digraph; % intermediate spanning tree
    u = node;
    
    stop_while = false;
    while ~stop_while
        adjacent_nodes = find(A(u, :));
        if length(adjacent_nodes) == 1
            next_node = adjacent_nodes
        else
            next_node = randsample(find(A(u, :)), 1);
        end
%         Gedges = table2array(G.Edges);
%         assert(sum((Gedges(:, 1) == u & Gedges(:, 2) == next_node) | (Gedges(:, 2) == u & Gedges(:, 1) == next_node)) == 1);
        stop_while = any(T.Edges.EndNodes == next_node, "all") | length(S.Edges.EndNodes) > 2000;
        if (~stop_while | true)
            
            alpha = S.Edges.EndNodes(:, 1) == next_node;
            if any(alpha)
                assert(sum(alpha) == 1)
                S = rmedge(S, find(alpha));
            end
            S = addedge(S, u, next_node); % add new edge
            
            u = next_node;
        end
    end

%     overlapping_nodes = intersect(S.Edges.EndNodes(:), T.Edges.EndNodes(:))

    T = addedge(T, S.Edges);

    n_nodes_in_T = size(T.Edges.EndNodes, 1)

    plot(T, 'XData', centroids(1:max(T.Edges.EndNodes(:)), 1), 'YData', centroids(1:max(T.Edges.EndNodes(:)), 2));
end

%% plot
T
% plot(T);
plot(T, 'XData', centroids(:,1), 'YData', centroids(:,2));
save("csv_and_matfiles/example_spanning_tree.mat", "G", "T");
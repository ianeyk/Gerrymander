%% Generate Graph
edges = readtable("district_edge_list.csv");
edges = edges(:, 2:3);
edges_array = table2array(edges);
nodes = unique(edges_array);
EdgeTable = table(edges_array,'VariableNames',{'EndNodes'});


population = readtable("district_demographics.csv");
population = population(:, ["VTDKEY", "Biden", "Trump", "Voter_Registration", "Turnout", "vap", "anglovap", "FENAME"]);

NodeTable = table(nodes, 'VariableNames',{'VTDKEY'});
NodeTable = join(NodeTable,population);

G = graph(EdgeTable, NodeTable);
plot(G)
%% Spanning Tree Algorithm
G2 = G;

root = randsample(nodes, 1);

% T = graph; % final spanning tree
S = graph;
u = root;

for node = 1:length(nodes)
    
    u = node;
    
    at_least_one_iteration = false;
    while at_least_one_iteration | ~(any(S.Edges.EndNodes(1:end-1) == u))
        next_node = randsample(find(A(u, :)), 1);
        S = addedge(S, u, next_node);
        u = next_node;

        at_least_one_iteration = false;
    end

%     S = addedge(S, u, next_node);

%     if any(S.nodes == next_node)
%         S = addedge(S, u, next_node);
%     end

end

result = S.Edges;

%% plot
S
plot(S);
%% Part 2
bins = conncomp(S)
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
% plot(G)
%% Spanning Tree Algorithm
G2 = G;

root = randsample(nodes, 1);

T = graph(); % final spanning tree
u = root;

for node = 1:length(nodes)
    % first, if the node is already in T, then skip it
    if ~any(T.Edges.EndNodes == node, "all") & length(T.Edges.EndNodes) > 0
        continue
    end
    S = digraph; % intermediate spanning tree
    u = node;
    
    stop_while = false;
    while ~stop_while
        stop_while = any(T.Edges.EndNodes == u, "all") | length(S.Edges.EndNodes) > 1000;
        if (~stop_while | true)
            next_node = randsample(find(A(u, :)), 1);
            
            alpha = S.Edges.EndNodes(:, 1) == next_node;
            if any(alpha)
                assert(sum(alpha == 1))
                S = rmedge(S, find(alpha));
            end
            S = addedge(S, u, next_node); % add new edge
            
            u = next_node;
        end
    end

    T = addedge(T, S.Edges); % TODO: make sure this works, because S is directed and T is undirected

    n_edges_in_T = size(T.Edges.EndNodes)
%     S = addedge(S, u, next_node);

%     if any(S.nodes == next_node)
%         S = addedge(S, u, next_node);
%     end

end

%% plot
T
plot(T);
%% Clear and load initial state
clear;
close;
load("recomb_initial_state.mat");

G_iter = G;
D_old = graph();
D = find_all_adjacent_districts(G, G_iter, D_old, 1:max(G.Nodes.district_id), true);

n_districts_to_combine = 700;
districts_to_combine = D.Edges.EndNodes(randsample(1:length(D.Edges.EndNodes(:, 1)), n_districts_to_combine), :);
for dd = 1:n_districts_to_combine
    district1 = districts_to_combine(dd, 1);
    district2 = districts_to_combine(dd, 2);
    G.Nodes.district_id(G.Nodes.district_id == district2) = district1;
end
len_unique = length(unique(G.Nodes.district_id))
%%
recomb_iterations = 100;
for recomb_iteration = 1:recomb_iterations
recomb_iteration

T = graph();
while (length(T.Edges.EndNodes) < 1) % | (max(conncomp(T)) > 1)
    two_district_ids = D.Edges.EndNodes(randsample(length(D.Edges.EndNodes), 1), :);
    H = subgraph(G, G.Nodes.district_id == two_district_ids(1) | G.Nodes.district_id == two_district_ids(2));

%     disp("More than one connected component or returned an empty tree. Trying again")
    disp("Returned an empty tree. Trying again")
    T = spanning_tree(H);
end
district1 = split_tree(H, T);

green_highlights = [];
magenta_highlights = [];

for node = 1:length(H.Nodes.VTDKEY)
    was = G_iter.Nodes.district_id(H.Nodes.VTDKEY(node))
    if district1(node)
        is_now = two_district_ids(1)
        G_iter.Nodes.district_id(H.Nodes.VTDKEY(node)) = two_district_ids(1);
        green_highlights(end + 1) = H.Nodes.VTDKEY(node);
    else
        is_now = two_district_ids(2)
        G_iter.Nodes.district_id(H.Nodes.VTDKEY(node)) = two_district_ids(2);
        magenta_highlights(end + 1) = H.Nodes.VTDKEY(node);
    end
end

clf;
plt = plot(G_iter, 'XData', centroids(:,1), 'YData', centroids(:,2));
plt.NodeCData = G_iter.Nodes.district_id;
colorbar
% highlight(plt, green_highlights, 'nodecolor', 'g')
% highlight(plt, magenta_highlights, 'nodecolor', 'm')

% matching = G_iter.Nodes.district_id == G.Nodes.district_id;
% sum_not_matching = sum(~matching)
end
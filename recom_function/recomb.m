%% Clear and load initial state
clear;
close;
load("recomb_initial_state.mat");

% G_iter is the graph that will hold the new district ID's. G is preserved as a reference, with the original district ID's.
G_iter = G;

% initialize all nodes to district_id = 1. Then pick 5 nodes to re-assign.This creates 1 massive district and 4 tiny ones
G_iter.Nodes.district_id = zeros(height(G.Nodes), 1) + 1;
node_ids_to_change = randsample(1:height(G.Nodes), 5);
for gg = 1:5
    G_iter.Nodes.district_id(node_ids_to_change(gg)) = gg;
end

D = find_all_adjacent_districts(G_iter);
%%
unique_districts = G_iter.Nodes.district_id;
plt = plot(G_iter, 'XData', centroids(:,1), 'YData', centroids(:,2));
plt.NodeCData = unique_districts;
colorbar;

%%
image_series_name = randi(10.^4);
mkdir("image_series/image_series_" + image_series_name);
recomb_iterations = 100;
for recomb_iteration = 1:recomb_iterations
recomb_iteration
% try

T = graph();
while (length(T.Edges.EndNodes) < 1) % | (max(conncomp(T)) > 1)
    D = find_all_adjacent_districts(G_iter, G_iter, graph(), unique(G_iter.Nodes.district_id), true);
    figure(3);
    clf;
    plot(D);

    two_district_ids = D.Edges.EndNodes(randsample(length(D.Edges.EndNodes), 1), :);

    H = subgraph(G_iter, G_iter.Nodes.district_id == two_district_ids(1) | G_iter.Nodes.district_id == two_district_ids(2));

%     disp("More than one connected component or returned an empty tree. Trying again")
    disp("Returned an empty tree. Trying again")
    T = spanning_tree(H);
end
district1 = split_tree(H, T);

green_highlights = [];
magenta_highlights = [];

for node = 1:length(H.Nodes.VTDKEY)
    was = G_iter.Nodes.district_id(H.Nodes.VTDKEY(node));
    if district1(node)
        is_now = two_district_ids(1);
        G_iter.Nodes.district_id(H.Nodes.VTDKEY(node)) = two_district_ids(1);
        green_highlights(end + 1) = H.Nodes.VTDKEY(node);
    else
        is_now = two_district_ids(2);
        G_iter.Nodes.district_id(H.Nodes.VTDKEY(node)) = two_district_ids(2);
        magenta_highlights(end + 1) = H.Nodes.VTDKEY(node);
    end
end
%%
figure(1);
plt = plot(G_iter, 'XData', centroids(:,1), 'YData', centroids(:,2));
unique_district_ids = unique(G_iter.Nodes.district_id)
% unique_districts = zeros(length(G_iter.Nodes.district_id), 1);
% for uu = 1:length(unique_district_ids)
%     unique_district_id = unique_district_ids(uu);
%     unique_districts(G_iter.Nodes.district_id == unique_district_id) = uu;
% end
% plt.NodeCData = unique_districts;
plt.NodeCData = G_iter.Nodes.district_id;
colorbar
drawnow;
saveas(plt, "image_series/image_series_" + image_series_name + "/image_series_" + image_series_name + "_" + recomb_iteration + ".png");
% highlight(plt, green_highlights, 'nodecolor', 'g')
% highlight(plt, magenta_highlights, 'nodecolor', 'm')

% matching = G_iter.Nodes.district_id == G.Nodes.district_id;
% sum_not_matching = sum(~matching)
% catch
% end
end
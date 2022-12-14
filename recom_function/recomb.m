%% Clear and load initial state
clear;
close;
load("recomb_initial_state.mat");

% Choose a unique ID for this run through the algorithm. This will be used to store unique file names
run_id = randi(10.^4);
mkdir("image_series/image_series_" + run_id);

% G_iter is the graph that will hold the new district ID's. G is preserved as a reference, with the original district ID's.
G_iter = G;

% initialize all nodes to district_id = 1. Then pick 5 nodes to re-assign.This creates 1 massive district and 4 tiny ones
n_new_districts = 30;
G_iter.Nodes.district_id = zeros(height(G.Nodes), 1) + 1;
node_ids_to_change = randsample(1:height(G.Nodes), n_new_districts);
for gg = 1:n_new_districts
    G_iter.Nodes.district_id(node_ids_to_change(gg)) = gg;
end

%%
save_every_n = 10;
recomb_iterations = 2000;
district_ids_after_iterations = zeros(length(G_iter.Nodes.district_id), recomb_iterations ./ save_every_n + 5);
for recomb_iteration = 1:recomb_iterations
    recomb_iteration
    % try

    T = graph();
    while length(T.Edges.EndNodes) < 1
        % make a graph of all adjacent districts, so we can choose which ones to combine
        D = find_all_adjacent_districts(G_iter);
        figure(3);
        clf;
        plot(D);
        title("Adjacent Districts By District ID")

        % pick a random edge from the district adjacency graph D and get the district_id's that correspond to the end nodes.
        two_district_ids = D.Edges.EndNodes(randsample(length(D.Edges.EndNodes), 1), :);

        % create the subgraph containing only nodes in either district that is being joined.
        H = subgraph(G_iter, ismember(G_iter.Nodes.district_id, two_district_ids));

        T = spanning_tree(H);
        if length(T.Edges.EndNodes) < 1
            disp("Returned an empty tree. Trying again")
        end
    end 
    nodes_in_new_half_district = split_tree(H, T);

    G_iter.Nodes.district_id(H.Nodes.VTDKEY(nodes_in_new_half_district)) = two_district_ids(1);
    G_iter.Nodes.district_id(H.Nodes.VTDKEY(~nodes_in_new_half_district)) = two_district_ids(2);

    %%
    figure(1);
    plt = plot(G_iter, 'XData', centroids(:,1), 'YData', centroids(:,2));
    plt.NodeCData = G_iter.Nodes.district_id;
    colorbar;
    title(sprintf("District Map For %d Unique Districts After %d Iterations", n_new_districts, recomb_iteration));
    drawnow;
    saveas(plt, "image_series/image_series_" + run_id + "/image_series_" + run_id + "_" + recomb_iteration + ".png");

    % catch
    % end
    if mod(recomb_iteration, save_every_n) == 0
        district_ids_after_iterations(:, ceil(recomb_iteration ./ save_every_n)) = G_iter.Nodes.district_id;
    end
end
save("two_hundred_runs_01.mat", "district_ids_after_iterations");
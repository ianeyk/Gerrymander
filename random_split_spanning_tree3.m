%% Generate longest diameter path
centroids = readmatrix("csv_and_matfiles/district_centroids.csv");
centroids = centroids(2:end, 2:end);

load("csv_and_matfiles/example_spanning_tree.mat");
% G: original graph. Has a table containing voting-age population (vap) and other demographics.
% T: spanning tree on G generated previously.

% Run breadth-first search once to determine the farthest node from a random starting point.
bfs = bfsearch(T, randi(length(T.Edges.EndNodes)));
start_vertex = bfs(end);

% From one extreme node, find the other extreme node using another breadth-first search.
% The last node to be reached by the bfs is the farthest node from the starting point.
bfs2 = bfsearch(T, start_vertex, 'finishnode');
end_vertex = bfs2(end);

% Find the shortest path between the two farthest-apart nodes. This is the diameter of the graph.
% We will pick edges along this path to remove. The thinking is that the ideal splitting point
% will lie along this path (not guaranteed to be true, but a good guess).
p = shortestpath(T, start_vertex, end_vertex);

% For accounting purposes, make it have an even number of nodes
if mod(length(p), 2) == 1
    p = p(1:end - 1);
end

% Split the path p down the middle to determine the order of edges to try.
% We will start with the edge in the middle, and then work our way outwards towards the extremes.
% The idea is that the splitting point is likely to be near the middle of path p.
midpoint = length(p) / 2;
p2 = [flip(p(1:midpoint)); p(midpoint + 1:end)];
p_order = p2(:).';

%% Find balanced splitting point

population_target = sum(table2array(G.Nodes(:, "vap"))) ./ 2; % total population / 2
% population_bounds = population_target .* [0.95, 1.05];

figure(1);
clf;
for ii = 1:length(p) - 1

    T_temp = T; % create a throwaway (temporary) graph on which we will remove an edge
    % remove the next edge on the re-ordered path p
    T_temp = rmedge(T_temp, p_order(ii), p(find(p == p_order(ii)) + 1));

    first_half = conncomp(T_temp) == 1; % find indices of nodes in the first connected component
    pop_of_first_half = sum(table2array(G.Nodes(first_half, "vap"))); % find the voting-age population among the first half
    error = (pop_of_first_half - population_target) ./ population_target .* 100; % percent difference from desired population
    
    iteration = ii; % for display
    disp(table(iteration, error))

    % Plot spanning tree with nodes colored.
    % Uncomment the first h= line to plot nodes as an abstract spanning tree
    % Uncomment the second h= line to plot nodes as districts in their geographic locations
    clf;
    h = plot(T);
    % h = plot(T, 'XData', centroids(:,1), 'YData', centroids(:,2));
    highlight(h, first_half, "EdgeColor", "red", "NodeColor", "red");
    drawnow;
    pause(.1);

    if abs(error) < 8 % percent
        break
    end
end
%% Plot geographically
figure(2);
clf;
h2 = plot(T, 'XData', centroids(:,1), 'YData', centroids(:,2));
highlight(h2, first_half, "EdgeColor", "red", "NodeColor", "red");


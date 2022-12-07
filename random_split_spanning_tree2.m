load("csv_and_matfiles/example_spanning_tree.mat"); 

bfs = bfsearch(T, 1990, 'finishnode');
% bfs_end = bfs(ceil(length(T.Edges.EndNodes) .* 3 ./ 4));
bfs_end = bfs(end);

n = dfsearch(T, bfs_end, 'finishnode');

vaps_on_path = table2array(G.Nodes(n, "vap"));
more_than_half = cumsum(vaps_on_path) >= sum(vaps_on_path) ./ 2;
halfway_index = find(more_than_half, 1);
first_half_of_tree = n(1:halfway_index);
flip_ordering = flip(first_half_of_tree);

population_target = sum(vaps_on_path) ./ 2;
population_bounds = population_target .* [0.95, 1.05];

figure(1);
clf;
edges = T.Edges.EndNodes;
for ii = 1:length(edges)
    T_temp = T;
    T_temp = rmedge(T_temp, flip_ordering(ii));
    first_half = conncomp(T_temp) == 1;
    vaps_on_path = table2array(G.Nodes(first_half, "vap"));
    error = (sum(vaps_on_path) - population_target) ./ population_target .* 100
    
    clf;
    h = plot(T);
    highlight(h, first_half, "EdgeColor", "red", "NodeColor", "red");
    drawnow;
    pause(0.5);

    if abs(error) < 5; % percent
        break
    end
end

load("csv_and_matfiles/example_spanning_tree.mat"); 

new_tree = shortestpathtree(T, 1);
ordered_tree = toposort(sh).';

bfs = bfsearch(T, 1990, 'finishnode');
% bfs_end = bfs(ceil(length(T.Edges.EndNodes) .* 3 ./ 4));
bfs_end = bfs(end);

n = bfsearch(T, bfs_end, 'finishnode');
% n = dfsearch(T,1, 'finishnode');

%% use Graph n
vaps_on_path = table2array(G.Nodes(n, "vap"));

more_than_half = cumsum(vaps_on_path) >= sum(vaps_on_path) ./ 2;

halfway_index = find(more_than_half, 1);

first_half_of_tree = n(1:halfway_index);
second_half_of_tree = n(halfway_index + 1:end);

figure(1);
clf;
h = plot(T);
% h = plot(T, 'XData', centroids(:,1), 'YData', centroids(:,2));
step = 40;
prev_i = 1;
for i = 1:step:length(first_half_of_tree)
%     highlight(h, fist_half_of_tree, "EdgeColor", "red", "NodeColor", "red");
    highlight(h, first_half_of_tree(prev_i:i), "EdgeColor", "red", "NodeColor", "red");
    drawnow;
    prev_i = i
%     pause(0.01);
end

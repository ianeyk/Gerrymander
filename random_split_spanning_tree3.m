load("csv_and_matfiles/example_spanning_tree.mat"); 

bfs = bfsearch(T, 1990, 'finishnode');
% bfs_end = bfs(ceil(length(T.Edges.EndNodes) .* 3 ./ 4));
start_vertex = bfs(end);

bfs2 = bfsearch(T, start_vertex, 'finishnode');
end_vertex = bfs2(end);

p = shortestpath(T, start_vertex, end_vertex);
if mod(length(p), 2) == 1
    p = p(1:end - 1);
end
l = length(p);
p2 = [flip(p(1:l ./ 2)); p(l ./ 2 + 1:end)];
p_interspersed = p2(:).';

%% 
% vaps_on_path = table2array(G.Nodes(n, "vap"));
% more_than_half = cumsum(vaps_on_path) >= sum(vaps_on_path) ./ 2;
% halfway_index = find(more_than_half, 1);
% first_half_of_tree = n(1:halfway_index);
% flip_ordering = flip(first_half_of_tree);

population_target = sum(table2array(G.Nodes(:, "vap"))) ./ 2;
population_bounds = population_target .* [0.95, 1.05];

figure(1);
clf;
edges = T.Edges.EndNodes;
for ii = 1:length(p-1)
    T_temp = T;
    T_temp = rmedge(T_temp, p_interspersed(ii), p(find(p == p_interspersed(ii)) + 1));
    first_half = conncomp(T_temp) == 1;
    vaps_on_path = table2array(G.Nodes(first_half, "vap"));
    error = (sum(vaps_on_path) - population_target) ./ population_target .* 100
    
    clf;
    h = plot(T);
%     h = plot(T, 'XData', centroids(:,1), 'YData', centroids(:,2));
    highlight(h, first_half, "EdgeColor", "red", "NodeColor", "red");
%     highlight(h, p_interspersed, "EdgeColor", "red", "NodeColor", "red");
%     break;
    drawnow;
    pause(.1);
    ii

    if abs(error) < 2 % percent
        break
    end
end
%% plot geographically
figure(2);
clf;
h2 = plot(T, 'XData', centroids(:,1), 'YData', centroids(:,2));
highlight(h2, first_half, "EdgeColor", "red", "NodeColor", "red");


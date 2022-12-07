load("csv_and_matfiles/example_spanning_tree.mat"); 

n_trials = 100;
ps_output = zeros(n_trials, 490);
for ii = 1:n_trials
    
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

    ps_output(ii, :) = p_interspersed;
end

ps_output
function first_half = split_tree(G, T)
    %% Generate longest diameter path
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
    p_idx = round(length(p) ./ 2);

    %% Find balanced splitting point

    population_target = sum(table2array(G.Nodes(:, "vap"))) ./ 2; % population of both districts / 2

    figure(1);
    clf;
    prev_error = 100; % percent
    stop_iteration = 0;
    p_direction = 16; % positive or negative
    ready_to_quit = false;
    for ii = 1:length(p) - 1
        if p_idx == 1 || p_idx == length(p)
            break
        end
        T_temp = rmedge(T, p(p_idx), p(p_idx + sign(p_direction))); % create a copy of T which we can remove edges from

        first_half = conncomp(T_temp) == 1; % find indices of nodes in the first connected component
        pop_of_first_half = sum(table2array(G.Nodes(first_half, "vap"))); % find the voting-age population among the first half
        percent_error = (pop_of_first_half - population_target) ./ population_target .* 100; % percent difference from desired population

        % display statistics
        iteration = ii; % for display
        disp(table(iteration, percent_error, p_direction))

        % Plot spanning tree with nodes colored.
        % Uncomment the first h= line to plot nodes as an abstract spanning tree
        % Uncomment the second h= line to plot nodes as districts in their geographic locations
        figure(2);
        clf;
        h = plot(T);
        %         h = plot(T, 'XData', centroids(:,1), 'YData', centroids(:,2));
        highlight(h, first_half, "EdgeColor", "red", "NodeColor", "red");
        title(sprintf("Spanning Tree Split Population Error = %.2f percent\n", percent_error));
        drawnow;
        % pause(.1);

        % continue with algorithm
        if ready_to_quit
            disp("Minimum error reached.")
            fprintf("Minimum error margin was %.2f percent\n", percent_error)
            break
        end

        if abs(percent_error) > abs(prev_error)
%             p_idx = p_idx - p_direction; % undo the last step
            prev_direction = p_direction;
            p_direction = floor(-p_direction ./ 2); % change directions
            stop_iteration = stop_iteration + 1;

            if abs(p_direction) == 1
                ready_to_quit = true; % on the next iteration
            end
        end


        prev_error = percent_error;
        p_idx = p_idx + p_direction;
    end
end
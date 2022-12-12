function T = spanning_tree(G)
    A = adjacency(G);
    nodes = unique(G.Edges.EndNodes);
    %% Spanning Tree Algorithm
    T = graph(); % initialize final spanning tree
    disp("Working... You will not see the first output for a few seconds.")
    
    for node = 1:length(nodes) % loop through every node to make sure it is in the final tree
        
        % first, if the node is already in T, then skip it
        if any(T.Edges.EndNodes == node, "all") & length(T.Edges.EndNodes) > 0
            continue
        end
        
        % create intermediate spanning tree. It is directed so we can keep track of the ordered pairs of nodes
        S = digraph;
        
        u = node; % starting node
    
        stop_while = false;
        increment = 1;
        while ~stop_while
            adjacent_nodes = find(A(u, :)); % get a list of nodes adjacent to u from the adjacency matrix
    
            % This if statement is needed because randsample returns a different value if the input has length 1 vs. length > 1
            if length(adjacent_nodes) == 1
                next_node = adjacent_nodes;
            else
                next_node = randsample(adjacent_nodes, 1);
            end
    
            % optional debugging assertion to make sure next_node is actually adjacent to u
            % Gedges = table2array(G.Edges);
            % assert(sum((Gedges(:, 1) == u & Gedges(:, 2) == next_node) | (Gedges(:, 2) == u & Gedges(:, 1) == next_node)) == 1);
    
            stop_while = any(T.Edges.EndNodes == next_node, "all") | length(S.Edges.EndNodes) > ((length(nodes) ./ 2 + 1));
            increment = increment + 1;
            node_already_connected = S.Edges.EndNodes(:, 1) == next_node;
            if any(node_already_connected)
                assert(sum(node_already_connected) == 1) % each node should have only one connection
                S = rmedge(S, find(node_already_connected)); % remove the old connection before adding the new edge
            end
            S = addedge(S, u, next_node); % add new edge
            
            u = next_node;
        end
        
        % optional debugging statement to make sure the new graph S only intersects with the final tree in one place
        % overlapping_nodes = intersect(S.Edges.EndNodes(:), T.Edges.EndNodes(:))
    
        % Add all edges in graph S to graph T
        T = addedge(T, S.Edges);
    
        n_nodes_in_T = size(T.Edges.EndNodes, 1); % for display
    end
end
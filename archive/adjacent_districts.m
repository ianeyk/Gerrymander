function H = adjacent_districts(G)
    A = adjacency(G);

    n_districts = max(G.Nodes.district_id)
    first_district_id = randsample(n_districts, 1); % draw two samples without replacement
    first_district_nodes = find(G.Nodes.district_id == first_district_id)
    if length(first_district_nodes) == 1
        starting_node = first_district_nodes(1);
    else
        starting_node = randsample(first_district_nodes, 1)
    end
    next_node = starting_node;
    second_district_id = first_district_id
    while second_district_id == first_district_id % until it's different
        adjacent_nodes = find(A(next_node, :)); % get a list of nodes adjacent to u from the adjacency matrix
        % This if statement is needed because randsample returns a different value if the input has length 1 vs. length > 1
        if length(adjacent_nodes) == 1
            next_node = adjacent_nodes;
        else
            next_node = randsample(adjacent_nodes, 1);
        end
        second_district_id = G.Nodes.district_id(next_node);
    end
    
    H = subgraph(G, G.Nodes.district_id == first_district_id | G.Nodes.district_id == second_district_id)
end
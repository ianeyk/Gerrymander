function D = find_all_adjacent_districts(G, old_G, old_D, districts_to_find, skip_delete)
    A = adjacency(G);
    nodes = unique(G.Edges.EndNodes);

    n_districts = max(G.Nodes.district_id);


    % start by removing all the bad edges from old_D
    old_A = adjacency(old_G);
    D = old_D;
    for kk = 1:length(districts_to_find)
        district_1 = districts_to_find(kk);
        district_1_nodes = find(G.Nodes.district_id == district_1)

        % remove old edges
        if ~skip_delete
        for ii = 1:length(district_1_nodes)
            district_1_node = district_1_nodes(ii);
            adjacent_nodes = find(old_A(district_1_node, :)); % old adjacency matrix
            for jj = 1:length(adjacent_nodes)
                adjacent_node = adjacent_nodes(jj);
                adjacent_district = G.Nodes.district_id(adjacent_node);
                D = rmedge(D, district_1, adjacent_district);
            end
        end
        end

        % add new edges
        for ii = 1:length(district_1_nodes)
            district_1_node = district_1_nodes(ii);
            adjacent_nodes = find(A(district_1_node, :)); % new adjacency matrix
            for jj = 1:length(adjacent_nodes)
                adjacent_node = adjacent_nodes(jj);
                adjacent_district = G.Nodes.district_id(adjacent_node);
                D = addedge(D, district_1, adjacent_district);
            end
        end
    end

    D = simplify(D);
    D
    assert(size(D.Nodes, 1) == n_districts)
end
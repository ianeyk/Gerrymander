function D = find_all_adjacent_districts(G_iter)
    D = graph();
    
    % For each edge, get the district_id's of the end nodes, then take only the unique (distinct) pairs of districts
    % which are connected to each other.
    district_connections = unique(G_iter.Nodes.district_id(G_iter.Edges.EndNodes), 'rows');

    % Add the distinct edges to the graph of adacent district
    for dd = 1:size(district_connections, 1)
        D = addedge(D, district_connections(dd, 1), district_connections(dd, 2));
    end
    D = simplify(D); % remove self loops
end
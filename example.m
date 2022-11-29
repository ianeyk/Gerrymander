%--------------------------------------------------------------------------
% Example for the use of getNumberSpanningTrees and generateSpanningTrees.
% The graph considered below is taken from p. 463 in The Art of Computer
% Programming, vol. 4A (Combinatorial Algorithms, Part 1), by Donald E. Knuth.
%
%   Authors:
%     Matthias Hotz <matthias.hotz@tum.de>
%
%--------------------------------------------------------------------------

A = sparse([1 1 2 2 3], [2 3 3 4 4], ones(5, 1), 4, 4)'  % Adjacency matrix

fprintf('\nNumber of spanning trees: %d\n', lib.getNumberSpanningTrees(A));

[idx, src, dst] = lib.generateSpanningTrees(A);

for i = 1:size(idx, 2)
    fprintf('\n%4i:', i);
    for j = 1:size(idx, 1)
        fprintf('  (%i,%i)', src(idx(j, i)), dst(idx(j, i)));
    end
end
fprintf('\n\n');

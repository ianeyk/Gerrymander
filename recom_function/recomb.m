%% Clear and load initial state
clear;
close;
load("recomb_initial_state.mat");

H = adjacent_districts(G);

%% Run Recomb algorithm
T = spanning_tree(H);
district1 = split_tree(H, T);
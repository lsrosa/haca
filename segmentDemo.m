clear variables;
close all;

%%
filename = 'data/demonstrations/squares.bag';
[position, velocity, effort] = read_demonstration(filename);

%%
distance_matrix = conDist(position, position);
kernel_matrix = conKnl(distance_matrix, 'nei', 0.02); % K in the paper

%%
parameters = struct( ...
  'kF',   {  10,  10}, ...
  'k',    {  4,   }, ... % number of clusters!
  'nMi',  {  8,   4}, ... % minimun and maximum number of samples in the segment
  'nMa',  {  10,   6}, ... % parameters{1} is the first hierarchy level (fine grained) - parameters{2} is the second (coarse grained)
  'ini',  { 'p', 'p'}, ... % initialization
  'nIni', {  5,  10}, ...
  'redL', {  5,   1});

%%
initial_segmentation = segIni(kernel_matrix, parameters(1));

%%
final_segmentation = haca(kernel_matrix, parameters, initial_segmentation);    

%% plot
plot_trajectory(position)
%%
%plot_segmentation(position, final_segmentation(2))
%%
showM(kernel_matrix, 'fig', [1 1 1 1]);
title('Kernel matrix (K)');

showSegBar(final_segmentation(1), 'fig', [2 2 1 1], 'mkSiz', 0, 'lnWid', 1);
showSegBar(final_segmentation(2), 'fig', [2 2 1 2], 'mkSiz', 0, 'lnWid', 1);

clear variables;
close all;

%%
parameters = struct( ...
  'kF',   {  2,  2}, ...
  'k',    {  8,   4}, ... % number of clusters!
  'nMi',  {  4,   5}, ... % minimun and maximum number of samples in the segment
  'nMa',  {  6,  8}, ... % weird??? parameters{1} is the first hierarchy level (fine grained) - parameters{2} is the second (coarse grained)
  'ini',  { 'p', 'p'}, ... % initialization
  'nIni', {  5,  1}, ...
  'redL', {  5,  1});

%%
filenames = dir('data/demonstrations/point*.bag');
%%
hold on;
n_demos = numel(filenames);
all_velocities = [];
sizes = zeros(n_demos, 2);

for i = 1:n_demos
    filename = strcat(filenames(i).folder, '/', filenames(i).name);
    [position, velocity, effort] = read_demonstration(filename);
    all_velocities = [all_velocities, velocity];
    sizes(i,:) = size(velocity); 
end

%%
distance_matrix = conDist(all_velocities, all_velocities);
kernel_matrix = conKnl(distance_matrix, 'nei', 0.2); % K in the paper
initial_segmentation = segIni(kernel_matrix, parameters(1));
final_segmentation = haca(kernel_matrix, parameters, initial_segmentation);

%%
plot_trajectory(all_velocities)
%% De-segments
segmentations = unconcat_segmentation(sizes, final_segmentation);

%{
disp('-----------')
size(final_segmentation(2).G)
disp('-----------')
acc = [0 0]
for i=1:5 
    sizes(i,2)
    size(segmentations(i,2).s) 
    size(segmentations(i,2).G)
    acc = acc + size(segmentations(i,2).G)
    disp('-----')
end
%}

%%
showM(kernel_matrix, 'fig', [1 1 1 1]);
title('Kernel matrix (K)');

showSegBar(final_segmentation(1), 'fig', [2 n_demos+1 2 1], 'mkSiz', 0, 'lnWid', 1);
    showSegBar(final_segmentation(2), 'fig', [2 n_demos+1 2 2], 'mkSiz', 0, 'lnWid', 1);

for i = 1:n_demos
    showSegBar(segmentations(i, 1), 'fig', [2 n_demos+1 2 2+2*i-1], 'mkSiz', 0, 'lnWid', 1);
    showSegBar(segmentations(i, 2), 'fig', [2 n_demos+1 2 2+2*i], 'mkSiz', 0, 'lnWid', 1);
end
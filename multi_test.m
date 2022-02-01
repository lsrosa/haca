clear variables;
close all;

%
parameters = struct( ...
  'kF',   {  10,  10}, ...
  'k',    {  4,   4}, ... % number of clusters!
  'nMi',  {  8,   4}, ... % minimun and maximum number of samples in the segment
  'nMa',  {  10,   6}, ... % parameters{1} is the first hierarchy level (fine grained) - parameters{2} is the second (coarse grained)
  'ini',  { 'p', 'p'}, ... % initialization
  'nIni', {  5,  10}, ...
  'redL', {  5,   1});

%
filenames = dir('data/demonstrations/point*.bag');
%
hold on;
n_demos = numel(filenames);
for i = 1:n_demos
    filename = strcat(filenames(i).folder, '/', filenames(i).name);
    [position, velocity, effort] = read_demonstration(filename);
    distance_matrix = conDist(velocity, velocity);
    kernel_matrix = conKnl(distance_matrix, 'nei', 0.02); % K in the paper
    initial_segmentation = segIni(kernel_matrix, parameters(1));
    final_segmentation = haca(kernel_matrix, parameters, initial_segmentation);
    
    showM(kernel_matrix, 'fig', [1 1 n_demos i]);
    title('Kernel matrix (K)');

    showSegBar(final_segmentation(1), 'fig', [2 n_demos 2 2*i-1], 'mkSiz', 0, 'lnWid', 1);
    showSegBar(final_segmentation(2), 'fig', [2 n_demos 2 2*i], 'mkSiz', 0, 'lnWid', 1);
end

%

clear variables;
%%
filename = 'data/demonstrations/squares.bag';
[position, ~, ~] = read_demonstration(filename);
%%
distance_matrix = conDist(position, position);
kernel_matrix = conKnl(distance_matrix, 'nei', 0.02);
%%
initial_segmentation = segIni(kernel_matrix, paraH(1));
%%
final_segmentation = segAlg('haca', [], kernel_matrix, paraH, initial_segmentation);    
    
%%
% Original STUFF bellow
%%
% The value of tag could be set to any integer between 1 and 14
% which correspods to the trial number of subject 86.
% You can derive similar results as shown in http://humansensing.cs.cmu.edu/projects/aca_more_results.html
tag = 5; 

wsSrc = mocSegSrc(tag);
[para, paraH] = stFld(wsSrc, 'para', 'paraH');

%% feature
wsData = mocSegData(wsSrc);
[X, segT] = stFld(wsData, 'X', 'segT'); % getX and segT from wsData (useless function)
K = conKnl(conDist(X, X), 'nei', .02); % construct kernel from distance matrix, conDist construct the distance matrix 
para.nIni = 1;

%% init
seg0s = segIni(K, para);

%% gmm
segGmm = segAlg('gmm', [], K, para, seg0s, segT);

%% aca
[segAca, segAcas] = segAlg('aca', [], K, para, seg0s, segT);

%% haca
seg0s = segIni(K, paraH(1));
segHaca = segAlg('haca', [], K, paraH, seg0s, segT);

%% plot
showM(K, 'fig', [1 1 2 1]);
title('Kernel matrix (K)');
showSeq(X, 'fig', [1 1 2 2]);
title('feature in 2-D space');
showSegBar(segT,   'fig', [2 4 1 1], 'mkSiz', 0, 'lnWid', 1);
showSegBar(segAca, 'fig', [2 4 1 2], 'mkSiz', 0, 'lnWid', 1);
title(sprintf('aca accuracy %.2f', segAca.acc));
showSegBar(segHaca(end), 'fig', [2 4 1 3], 'mkSiz', 0, 'lnWid', 1);
title(sprintf('haca accuracy %.2f', segHaca(end).acc));
showSegBar(segGmm, 'fig', [2 4 1 4], 'mkSiz', 0, 'lnWid', 1);
title(sprintf('gmm accuracy %.2f', segGmm.acc));

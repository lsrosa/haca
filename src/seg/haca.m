function [seg, segs, objs, accs, iOpt] = segAlg(K, para, seg0s)
% Temporal segmentation via specific algorithm.
%
% Input
%   X       -  sequence, dim x n
%   K       -  kernel matrix, n x n
%   para    -  segmentation parameter
%   seg0s   -  initial segmentation, 1 x nIni (cell)
%   segT    -  ground-truth segmentation (can be empty)
%
% Output
%   seg     -  segmentation with minimum cost: seg = segs{iOpt}, where iOpt = argmin_i costs(i)
%   segs    -  all segmentations, 1 x nIni (cell)
%   objs    -  ojbective, 1 x nIni
%   accs    -  accuracy (if segT is specified), 1 x nIni
%   iOpt    -  the index of optimal initial segmentation
%
% History
%   create  -  Leandro de Souza Rosa (l.desouzarosa@tudelft.nl), 27-01-2022

nIni = length(seg0s);
segs = cell(1, nIni);
[objs, accs] = zeross(1, nIni);
for i = 1 : nIni
    prom('m', 'new segmentation (%s): %d time\n', alg, i);

    % initialization
    seg0 = seg0s{i};

    seg = segHaca(K, para, seg0);
    objs(i) = seg(end).obj;

    % record
    segs{i} = seg;
end

% choose the result with minimum objective value
[~, iOpt] = min(objs);
seg = segs{iOpt};


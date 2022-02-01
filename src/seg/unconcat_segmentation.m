function segmentations = unconcat_segmentation(sizes, concatenated_segmentation)
%   [SEGMENTATIONS] = UNCONCAT_SEGMENTATION(SIZES, CONCATENATED_SEGMENTATION) split a segmentation of concatenated signals into
%   one segmentation per signal
%   
%   SIZES is a matrix with the sizes of the signals that were concatenated to create CONCATENATED_SEGMENTATION

% History
%   create  -  Leandro de Souza Rosa, 01-02-2022

    if( sum(sizes(:,2)) ~= concatenated_segmentation(2).s(end)-1)
        error('Sum of sizes does not match the concatenated segmentation')
    end
    
    [n_segmentations, ~] = size(sizes);
    n_nivels = numel(concatenated_segmentation);
    segmentations = repmat(struct(), n_segmentations, n_nivels);
    
    for nivel = 1:n_nivels
        
        seg = concatenated_segmentation(nivel);
        
        for i = 1:n_segmentations
            n_samples = sizes(i, 2);
            ub = find(seg.s >= n_samples, 1, 'first');
            seg.s(ub)
        
            % copy values
            segmentations(i, nivel).s = seg.s(:, 1:ub);
            segmentations(i, nivel).G = seg.G(:, 1:ub-1);
            
            % correct last values
            segmentations(i, nivel).s(end) = n_samples+1; % +1 to keep the format with HACA
            seg.s = seg.s - n_samples;
        
            %drop already remove values
            idx = find(seg.s > 0, 1, 'first'); %not the same as ub if the numbers match exactly
            seg.s = seg.s(:, idx:end);
            seg.G = seg.G(:, idx:end);
        end
    end
end
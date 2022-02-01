function segmentations = unconcat_segmentation(sizes, concatenated_segmentation)

    if( sum(sizes(:,2)) ~= final_segmentation(2).s(end)-1)
        error('Sum of sizes does not match the concatenated segmentation')
    end
    
    [n_segmentations, ~] = size(sizes);

    for nivel = 1:numel(concatenated_segmentation)
        
        seg = concatenated_segmentation(nivel)
        
        for i = 1:n_segmentations
            n_samples = sizes(i, 2)
            ub = find(seg.s >= n_samples, 1, 'first')
            seg.s(ub)
        
            % copy values
            partial_seg = struct();
            partial_seg.s = seg.s(:, 1:ub);
            partial_seg.G = seg.G(:, 1:ub-1);
            
            % correct last values
            partial_seg.s(end) = n_samples
            seg.s = seg.s - n_samples
        
            %drop already remove values
            idx = find(seg.s > 0, 1, 'first')
            seg.s = seg.s(:, idx:end);
            seg.G = seg.G(:, idx:end)
        end
    end
end
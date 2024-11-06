function bw_clean = clean_segmented_image(bw, min_object_size, min_hole_size)
% Remove small objects, if necessary
if min_object_size > 0
    cc_objects = bwconncomp(bw);
    area_objects = cellfun('size', cc_objects.PixelIdxList, 1);
    bw_clean = false(size(bw));
    inds = area_objects >= min_object_size;
    bw_clean(cell2mat(cc_objects.PixelIdxList(inds)')) = true;
else
    bw_clean = bw;
end
% Fill in holes, if necessary
if min_hole_size > 0
    cc_holes = bwconncomp(~bw_clean);
    area_holes = cellfun('size', cc_holes.PixelIdxList, 1);
    inds = area_holes < min_hole_size;
    bw_clean(cell2mat(cc_holes.PixelIdxList(inds)')) = true;
end
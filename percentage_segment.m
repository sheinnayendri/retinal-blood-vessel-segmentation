function [bw, sorted_pix] = percentage_segment(im, proportion, dark, bw_mask, sorted_pix)
% Sort pixels in image, if a sorted array is not already available
if nargin < 5 || isempty(sorted_pix)
    if ~isempty(bw_mask)
        sorted_pix = sort(im(bw_mask(:)));
    else
        sorted_pix = sort(im(:));
    end
end

% Convert to a proportion if we appear to have got a percentage
if proportion > 1
    proportion = proportion / 100;
    warning('PERCENTAGE_SEGMENT:THRESHOLD', 'The threshold exceeds 1; it will be divided by 100.');
end

% Invert PERCENT if DARK
if dark
    proportion = 1 - proportion;
end

% Get threshold
[threshold, sorted_pix] = percentage_threshold(sorted_pix, proportion, true);

% Threshold to get darkest or lightest objects
if dark
    bw = im <= threshold;
else
    bw = im > threshold;
end

% Apply mask
if ~isempty(bw_mask)
    bw = bw & bw_mask;
end
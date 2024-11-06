function [w, s_out] = iuwt_vessel_all(im, levels, padding)

if nargin < 3
   padding = 'symmetric';
end

% Determine output class - single if input is single, or contains many elements
if strcmp(class(im), 'single') || numel(im) > 10000000
    wclass = 'single';
    s_in = single(im);
else
    wclass = 'double';
    s_in = double(im);
end   

% Preallocate wavelet output; 3-d even if input is a vector
w = zeros([size(im) length(levels)], wclass);

% B3 spline coefficients for filter
b3 = [1 4 6 4 1] / 16;

% Compute transform
for ii = 1:levels(end)
    % Create convolution kernel
    h = dilate_wavelet_kernel(b3, 2^(ii-1)-1);
    
    % Convolve and subtract to get wavelet level
    s_out = imfilter(s_in, h' * h, padding);

    % Store wavelet level only if it's in LEVELS
    ind = find(levels == ii);
    if isscalar(ind)
        w(:,:,ind) = s_in - s_out;
    end
    
    % Update input for new iteration
    s_in = s_out;
end

% Remove singleton dimensions
w = squeeze(w);


function h2 = dilate_wavelet_kernel(h, spacing)
% Dilates a wavelet kernel by entering SPACING zeros between each
% coefficient of the filter kernel H.

% Check input
if ~isvector(h) && ~isscalar(spacing)
    error(['Invalid input to DILATE_WAVELET_KERNEL: ' ...
          'H must be a vector and SPACING must be a scalar']);
end

% Preallocate the expanded filter
h2 = zeros(1, numel(h) + spacing * (numel(h) - 1));
% Ensure output kernel orientation is the same
if size(h,1) > size(h,2)
    h2 = h2';
end
% Put in the coefficients
h2(1:spacing+1:end) = h;
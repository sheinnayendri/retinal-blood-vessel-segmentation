function [threshold, data_sorted] = percentage_threshold(data, proportion, sorted)
% Need to make data a vector
if ~isvector(data)
    data = data(:);
end

% If not told whether data is sorted, need to check
if nargin < 3
    sorted = issorted(data);
end

% Sort data if necessary
if ~sorted
    data_sorted = sort(data);
else
    data_sorted = data;
end

% Calculate threshold value
if proportion > 1
    proportion = proportion / 100;
end
proportion = 1-proportion;
thresh_ind = round(proportion * numel(data_sorted));
if thresh_ind > numel(data_sorted)
    threshold = Inf;
elseif thresh_ind < 1
    threshold = -Inf;
else
    threshold = data_sorted(thresh_ind);
end
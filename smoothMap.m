% Smooth map using a guassian filter
% smoothed = smoothMap(map, sigma);
%   map         HxW - map
%   sigma           - gaussian sigma
%   hsize       1x2 - size of the smoothing window
%   smoothed    HxW - smoothed map
function smoothed = smoothMap(map, sigma, hsize);

g = fspecial('gaussian', hsize, sigma);
smoothed = imfilter(map,g,'replicate');
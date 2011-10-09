% Build histogram for laser data
% H = histLaserData(laser, binRange)
%   laser     LxB   - laser data
%   binRange        - bin range (in cm)
%   histogram H     - bins
function histogram = histLaserData(laser, binRange)

[N, B] = size(laser);
laser = reshape(laser', 1, N*B);

m = max(laser);
nBins = floor(m/binRange)+1;        

histogram = hist(laser, nBins);




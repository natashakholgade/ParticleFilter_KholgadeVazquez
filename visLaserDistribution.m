% Visualize laser data distribution
%   measurements LxB  - L measurements, each composed by B beams
%   xrange       1x2  - x coordinate range for scatter plot (e.g., [1,LxB])      
%   color             - scatter plot color
function visLaserDistribution(measurements, xrange, color)

[L, B] = size(measurements);
measurements = reshape(measurements',1,L*B);

scatter(xrange(1):xrange(2), measurements, 1, color);
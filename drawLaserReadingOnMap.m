% Draw laser reading over map
%   laserlog        1x187   - one laser logs (as output by loadLogFile)
%   stride                  - laser stride (1 = draw all beams)
%   offset                  - laser (forward) offset from robot's center
%   map             WxH     - occupancy map
%   resolution              - map resolution
function drawLaserReadingOnMap(laserlog, stride, offset, map, resolution)

% get the orientation of the particle and center it at [0, 0]
particles = laserlog(1:3)';  
% get sensor measurements
laser = laserlog(7:186);
% get the laser hits without thresholding
hits = beamHit(particles, laser, stride, offset);
% convert hits from Bx1x2 to Bx2
hits = squeeze(hits);
% draw 
vismap(map); hold on;
drawLaserHits(particles', offset, hits, 1/resolution);

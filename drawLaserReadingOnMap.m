% Draw laser reading over map
%   laserlog        1x187   - one laser log (as output by loadLogFile)
%   stride                  - laser stride (1 = draw all beams)
%   offset                  - laser (forward) offset from robot's center
%   map             HxW     - occupancy map
%   resolution              - map resolution
%   drawmap                 - draw map? Either 1 or 0
function drawLaserReadingOnMap(laserlog, stride, offset, map, resolution, drawmap)

% get the orientation of the particle and center it at [0, 0]
particle = laserlog(1:3)';  
% get sensor measurements
laser = laserlog(7:186);
% get the laser hits without thresholding
hits = beamHit(particle, laser, stride, offset);
% convert hits from Bx1x2 to Bx2
hits = squeeze(hits);
% draw 
if drawmap; vismap(map); end
hold on;
drawLaserHits(particle', offset, hits, 1/resolution);

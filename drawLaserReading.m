% Draw laser reading in an abstract space
%   laserlog        1x187   - one laser log (as output by loadLogFile)
%   minT                    - min allowed laser reading 
%   maxT                    - max allowed laser reading
%   stride                  - laser stride (1 = draw all beams)
%   offset                  - laser (forward) offset from robot's center
function drawLaserReading(laserlog, minT, maxT, stride, offset)

% get the orientation of the particle and center it at [0, 0]
particles = [0; 0; laserlog(3)];  
% get sensor measurements
laser = laserlog(7:186);
% get the laser hits
hits = beamHitThresholded(particles, laser, minT, maxT, ...
                            stride, offset);
% convert hits from Bx1x2 to Bx2
hits = squeeze(hits);
% draw 
drawLaserHits(particles', offset, hits, 1);
% Construct ideal laser measurement from a map
% laser = idealLaserMeasurementFromMap(particle, map, resolution)
%   particle    3x1   - particle [x, y, theta]
%   offset            - laser (forward) offset from the center of the robot
%   map         HxW   - map
%   resolution        - map resolution (in cm)
%   hitThresh         - occupancy threshold for hit detection (e.g., 0.8)
%   maxRange          - maximum laser range
%   laser       1x180 - laser measurement
%   hits        2x180 - hits coordinates
%
% Inserts the particle in the world (map) and ray casts the 180 laser beams 
% (beams go from 0deg to 179deg). A hit is detected when the ray passes 
% through a cell in the map with occupancy > hitThresh.
% 
% This function is useful to build known laser measurements and test
% approaches to compute the weight of particles.
function [laser, hits] = ...
    idealLaserMeasurementFromMap(particle, offset, map, resolution, ...
                                 hitThresh, maxRange)

[H, W] = size(map);                                 % map dimensions
theta = particle(3);                                % laser/robot angle
laserPosition = particle(1:2) + ...                 % laser position
                   [cos(theta); sin(theta)]*offset;                     
               
% Check laser is inside map before continuing...
laserCell = floor(laserPosition/resolution);
if (map(sub2ind(size(map),laserCell(2),laserCell(1))) > hitThresh)
    display('CAUTION. The robot is positioned in a occupied cell!');
end
if (laserCell(1) < 1 || laserCell(1) > W || ...
        laserCell(2) < 1 || laserCell(2) > H)
   error('The laser of the robot falls outside the bounds of the map.');
end

% Construct subscript matrices to check for occupancy values...
% Use the following property for 2d lines:
%   X_2 = X_1 + d*cos(theta)
%   Y_2 = Y_1 + d*sin(theta)
% where (X_1, Y_1) and (X_2, Y_2) are the extreme points of a line, and 
% d^2 = (Y_2 - Y_1)^2 + (X_2 - X_1)^2
beamAngles =  theta - (0:179)*pi/180 + pi/2;        % beam angles
c = cos(beamAngles);                                % cosines
s = sin(beamAngles);                                % sines
xmax = maxRange.*c';                                % X_2 for all beams
ymax = maxRange.*s';                                % Y_2 for all beams
step = resolution/maxRange;                         % line step (1/(maxRange/resolution))
x = (xmax*(0:step:1-step/2))' + laserPosition(1);   % x coords per beam (cm)
y = (ymax*(0:step:1-step/2))' + laserPosition(2);   % y coords per beam (cm) 

% The matrices x and y have the coordinates of distributed sample points 
% along the beams. This coordinates are now used to check occupancy 
% probabilities in the map. 

% Retrieve occupancy values
xmap = floor(x./resolution);                        % x coords in map
ymap = floor(y./resolution);                        % y coords in map
xmap(xmap<1) = 1; xmap(xmap>W) = W;                 % threshold xmap to map
ymap(ymap<1) = 1; ymap(ymap>H) = H;                 % threshold ymap to map
occupancy = map(sub2ind(size(map), ymap, xmap));    % all occupancy probs

% Find the index for the hits
nPts = size(occupancy,1);                           % num of pts along beams
nBeams = size(occupancy,2);                         % num of beams
[~,subrow] = max(occupancy >= hitThresh);           % first hit per beam
hitind = sub2ind([nPts,nBeams],subrow,1:nBeams);    % index of hit cells
hits = [x(hitind); y(hitind)];                      % hits coordinates

diff = repmat(laserPosition,1,180) - hits;
laser = sqrt(sum(diff.^2));
% Construct ideal laser measurement from a map
% laser = idealLaserMeasurementFromMap(particles, stride, offset, map, resolution, hitThresh, maxRange)
%   particles    3xN  - particles [x, y, theta]
%   stride            - laser stride (> 0)
%   offset            - laser (forward) offset from the center of the robot
%   map         HxW   - map
%   resolution        - map resolution (in cm)
%   hitThresh         - occupancy threshold for hit detection (e.g., 0.8)
%   maxRange          - maximum laser range
%   laser       NxS   - laser measurement
%   hits        NxSx2 - hits coordinates
%
% Inserts the particle in the world (map) and ray casts the 180 laser beams 
% (beams go from 0deg to 179deg). A hit is detected when the ray passes 
% through a cell in the map with occupancy > hitThresh.
% 
% This function is useful to build known laser measurements and test
% approaches to compute the weight of particles.
function [laser, hits] = ...
    idealLaserMeasurementFromMap(particles, stride, offset, map, resolution, ...
                                 hitThresh, maxRange)

N = size(particles, 2);                             % number of particles
[H, W] = size(map);                                 % map dimensions
theta = particles(3,:);                             % laser/robot angle
laserPosition = particles(1:2,:) + ...              % laser position
                   [cos(theta); sin(theta)]*offset;                     
               
% Check laser is inside map before continuing...
laserCell = floor(laserPosition/resolution);
% if (map(sub2ind(size(map),laserCell(2),laserCell(1))) > hitThresh)
%     display('CAUTION. The laser is positioned in a occupied cell!');
% end
% if (laserCell(1) < 1 || laserCell(1) > W || ...
%         laserCell(2) < 1 || laserCell(2) > H)
%    error('The laser of the robot falls outside the bounds of the map.');
% end
% outside = laserCell(1,:) < 1 | laserCell(1,:) > W | ...
%              laserCell(2,:) | laserCell(2,:) > H;
% laserCell(1,laserCell(1,:) < 1) = W/2; 
% laserCell(1,laserCell(1,:) > W) = W/2;
% laserCell(2,laserCell(2,:) < 1) = H/2; 
% laserCell(2,laserCell(2,:) > H) = H/2;


% Construct subscript matrices to check for occupancy values...
% Use the following property for 2d lines:
%   X_2 = X_1 + d*cos(theta)
%   Y_2 = Y_1 + d*sin(theta)
% where (X_1, Y_1) and (X_2, Y_2) are the extreme points of a line, and 
% d^2 = (Y_2 - Y_1)^2 + (X_2 - X_1)^2
beams = pi/2 - (0:stride:179)'*pi/180;              % abstract beams
beamAngles =  repmat(theta, size(beams,1), 1) + ... % beams on particles                   
                repmat(beams, 1, N); 
c = cos(beamAngles);                                % cosines
s = sin(beamAngles);                                % sines
xmax = maxRange.*c;                                 % X_2 for all beams
ymax = maxRange.*s;                                 % Y_2 for all beams
step = resolution/(maxRange*2);                     % line step (1/(maxRange/(resolution/2)))
increment = (0:step:1-step/2);
nIncrement = length(increment);
increment = repmat(reshape(increment, [1 1 nIncrement]), ...
                length(beams), N);
xmax = repmat(xmax,[1, 1, nIncrement]);
ymax = repmat(ymax,[1, 1, nIncrement]);
x = xmax.*increment + ...                           % x coords per beam (cm)
        repmat(laserPosition(1,:), [size(beams,1), 1, nIncrement]); 
y = ymax.*increment + ...                           % y coords per beam (cm) 
    repmat(laserPosition(2,:), [size(beams,1), 1, nIncrement]); 

% The matrices x and y have the coordinates of distributed sample points 
% along the beams. This coordinates are now used to check occupancy 
% probabilities in the map. 

% Retrieve occupancy values
xmap = floor(x./resolution);                        % x coords in map
ymap = floor(y./resolution);                        % y coords in map
outside = xmap < 1 | xmap > W | ymap < 1 | ymap > H;
x(outside) = xmax(outside);
y(outside) = ymax(outside);
xmap(outside) = 1;
ymap(outside) = 1;

map(map == 2) = -1;

% xmap(xmap<1) = 1; xmap(xmap>W) = W;                 % threshold xmap to map
% ymap(ymap<1) = 1; ymap(ymap>H) = H;                 % threshold ymap to map
occupancy = map(sub2ind(size(map), ymap, xmap));    % all occupancy probs

% Find the index for the hits
[~,hitdepth] = max(occupancy >= hitThresh,[],3);    % first hit per beam
[tmp1,tmp2] = ndgrid(1:size(x,1),1:size(x,2));      % aux var for hitind
hitind = sub2ind(size(x),tmp1,tmp2,hitdepth);       % index of hit cells
hits = cat(3,x(hitind),y(hitind));                 % hits coordinates



postmp = cat(3,repmat(laserPosition(1,:), size(beams,1),1),...
               repmat(laserPosition(2,:), size(beams,1),1));
diff = postmp - hits;
laser = sqrt(sum(diff.^2,3))';
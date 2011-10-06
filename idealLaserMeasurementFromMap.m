% Construct ideal laser measurement from a map
% laser = idealLaserMeasurementFromMap(particle, map, resolution)
%   particle    3x1   - particle [x, y, theta]
%   offset            - laser (forward) offset from the center of the robot
%   map         WxH   - map
%   resolution        - map resolution (in cm)
%   hitThresh         - occupancy threshold for hit detection (e.g., 0.8)
%   maxRange          - maximum laser range
%   laser       1x180 - laser measurement
%
% Inserts the particle in the world (map) and ray casts the 180 laser beams 
% (beams go from 0deg to 179deg). A hit is detected when the ray passes 
% through a cell in the map with occupancy > hitThresh.
% 
% This function is useful to build known laser measurements and test
% approaches to compute the weight of particles.
function laser = idealLaserMeasurementFromMap(particle, offset, map, ...
                                                resolution, hitThresh, ...
                                                    maxRange)

[W, H] = size(map);                                 % map dimensions
theta = particle(3);                                % laser/robot angle
laserPosition = particle(1:2) + ...                 % laser position
                   [cos(theta); sin(theta)]*offset;                     
laser = (maxRange+1)*ones(1, 180);                  % start with fake hits
               
% Check laser is inside map before continuing...
laserCell = floor(laserPosition/resolution);
if (laserCell(1) < 1 || laserCell(1) > W || ...
        laserCell(2) < 1 || laserCell(2) > H)
   error('The laser of the robot falls outside the bounds of the map.');
end

% Construct subscript matrices to check for occupancy values...
slopes = tand(((0:179)*pi/180 + theta - pi/2)*180/pi); % beam slopes
slopes(isinf(slopes)) = 0;                             % fix inf slopes
b = laserPosition(2);                                  % beams' y-intercept
xmax = maxRange./sqrt(slopes.^2+1) + laserPosition(1); % max x coord per beam
x = (0:1/round(maxRange/resolution):1)'*xmax;          % x coords per beam (cm)
y = x*diag(slopes) + b;                                % y coords along beams (cm)

% The matrices x and y have the coordinates of distributed sample points 
% along the beams. This coordinates are now used to check occupancy in
% the map. 

% Retrieve occupancy values
xmap = floor(x/resolution);                           % x coords in map
ymap = floor(y/resolution);                           % y coords in map
xmap(xmap<1) = 1; xmap(xmap>W) = W; 
ymap(ymap<1) = 1; ymap(ymap>H) = H;
occupancy = map(sub2ind(size(map), xmap, ymap));      % all occupancy probs

% Find the index for the hits
nPts = size(occupancy,1);                             % num of pts along beams
nBeams = size(occupancy,2);                           % num of beams
occupancy(occupancy < hitThresh) = inf;               % discard non-occupied
[~,subrow] = min(occupancy);                          % first hit per beam
hitind = sub2ind([nPts,nBeams],subrow,1:nBeams);      % index of hit cells
hitcells = [x(hitind); y(hitind)];                    % hit cells

diff = repmat(laserCell,1,180) - hitcells;
laser = sqrt(sum(diff.^2));
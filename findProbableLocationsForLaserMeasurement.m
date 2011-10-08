% Find the probability of a measurement in the map
% P = findProbableLocationsForLaserMeasurement(laser, map, resolution, nAngles)
%   laser       1x180       - laser measurement
%   map         HxW         - occupancy map
%   resolution              - map resolution
%   nAngles                 - number of angles to consider (>0)
%   P           HxWxnAngles - Probability matrix 
%
% P is a huge matrix containing the probability of the robot's state. The
% orientation angles to consider are equally distributed in [0, 2*pi).
function P = findProbableLocationsForLaserMeasurement(laser, map, ...
                                                      resolution, nAngles)

% compute state orientations
orientationStep = 2*pi/nAngles;
orientations = 0:orientationStep:2*pi-orientationStep/2.0
assert(size(orientations,2) == nAngles);
pause

% find free spots in the map
[i,j] = find(map == 0);
nCells = size(i,1);

particles = [j'*resolution; ...
             i'*resolution; ...
             zeros(1,nCells)];
                  
P = zeros([size(map),nAngles]);

for o=1:nAngles
    fprintf('Working with orientation %d\n', o);
    particles(3,:) = repmat(orientations(o),1,nCells);
    w = computeWeights(particles, map, resolution, laser, 1, 0, inf, 0);
    tmp = zeros(size(map));
    tmp(sub2ind(size(tmp),i,j)) = w;
    P(:,:,o) = tmp;
end



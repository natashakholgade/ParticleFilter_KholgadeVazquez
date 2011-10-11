% Compute particle's weights by ray casting
% W = weightsFromRayCasting(particles, laser, stride, offset, map, resolution, beamSigma)
%   particles       3xN   - particles [x, y, theta]
%   laser           1xL   - laser readings (usually L = 180)
%   stride                - laser array stride
%   offset                - laser (forward) offset from the center of the robot
%   map             HxW   - map with occupancy probabilities
%   resolution            - map resolution (in cm)
%   beamSigma             - beam sigma
%   W               Nx1   - normalized weights for the particles
%
% Computes P(x|z) by ray casting beams and comparing hits in the map with
% laser measurements. The probability for a hit is computed using a normal
% distribution centered at the laser measurement for a beam (with sigma =
% beamSigma). 
function W = weightsFromRayCasting(particles, laser, stride, offset, map, resolution, beamSigma, minT, maxT)

N = size(particles,2);

% hitThreshold = 0.8;
% [idealLaser, ~] = ...
%     idealLaserMeasurementFromMap(particles, stride, offset, map, ...
%                                  resolution, hitThreshold, 8000);

idealLaser = raycast(particles, map, (0:stride:length(laser)-1)*pi/180);
laser = laser(1:stride:length(laser));

% filter beams that bo beyond max and min
insideRange = laser <= maxT & laser >= minT;
laser = laser(1,insideRange);
idealLaser = idealLaser(:,insideRange);

% diffLaser = repmat(laser(1:stride:length(laser)),N,1)-idealLaser;
%diffLaser = (repmat(laser,N,1)-idealLaser).^2;
diffLaser = (repmat(laser,N,1)-idealLaser);

% find probs
probs = normpdf(diffLaser/resolution,0,beamSigma);
%W = exp(sum(log(probs),2));
W = exp(sum(probs,2));
%W = W/sum(W);

                             

                             
                        

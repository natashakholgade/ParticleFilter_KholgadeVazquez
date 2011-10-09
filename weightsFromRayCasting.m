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
function W = weightsFromRayCasting(particles, laser, stride, offset, map, resolution, beamSigma)

N = size(particles,2);

hitThreshold = 0.8;
[idealLaser, ~] = ...
    idealLaserMeasurementFromMap(particles, stride, offset, map, ...
                                 resolution, hitThreshold, 8000);
                             
probs = normpdf(repmat(laser(1:stride:length(laser)),N,1)-idealLaser,0,beamSigma);
W = prod(probs,2)+0.000001;
W = W/sum(W);

                             

                             
                        

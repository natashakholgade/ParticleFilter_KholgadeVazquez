% Computes the normalized weight for all particles
% W = computeWeights(X, M, L)
%   X       3xN   - particles in world coordinates (N = # particles)
%   M       WxH   - map with occupancy probabilities
%   laser   1xL   - laser readings
%   stride        - laser array stride
%   W       Nx1   - particles' weight
%
% NOTE: A particle state consists of 3 variables: [x, y, theta].
%       The angle theta is assumed to come in radians.
function W = computeWeights(particles, map, laser)

N = size(X, 2);                                    % number of particles

% ----------------------------------------------------------------------- %
% Where do the laser beam measurements fall in the world?
% NOTE: The laser on the robot is approximately 25 cm offset forward from 
% the true center of the robot.
% ----------------------------------------------------------------------- %
hits = beamHit(X, L, 1, 25)






% Computes the normalized weight for all particles
% W = computeWeights(X, M, L)
%   particles 3xN   - particles in world coordinates (N = # particles)
%   map       WxH   - map with occupancy probabilities
%   resolution      - map resolution (the space each cell represents in cm)
%   laser     1xL   - laser readings
%   stride          - laser array stride
%   minT            - min allowed laser range
%   maxT            - max allowed laser range
%   method    {0,1} - 0 = simple map-based method; 1 = ray casting method
%   W         Nx1   - particles' weight
%
%   For the map-based method (method = 0), the map could be smoothed 
%   before hand to improve results (this smoothing is not performed by 
%   computeWeights(), since this would increase computation significantly 
%   without a particular good reason - the map can be smoothed once for all 
%   particles at the beginning of the particle filter -).
%
%
% NOTE: A particle state consists of 3 variables: [x, y, theta].
%       The angle theta is assumed to come in radians.
%       Each cell of the map is supposed to be squared, so that it 
%       represents a resolutionxresolution space.
function W = computeWeights(particles, map, resolution, laser, stride, ...
                            minT, maxT, method)

N = size(X, 2);                                    % number of particles

% ----------------------------------------------------------------------- %
% Where do the laser beam measurements fall in the world?
% NOTE: The laser on the robot is approximately 25 cm offset forward from 
% the true center of the robot.
% ----------------------------------------------------------------------- %
offset = 25;                                                % laser offset
hits = beamHitThresholded(particles, laser, minT, maxT, ... % hits
                          stride, offset);
                          
if method == 0                                  % simple map-based method
   
    W = weightsFromMap(hits, map, resolution);
    
elseif method == 1                              % ray casting method
    
    display('TODO! Method has not been implemented yet...');
    
else                                            % undefined method
    error('Undefined weigthing method. Method should be either 0 or 1.')
end


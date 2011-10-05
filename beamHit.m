% Where are the laser hits in the world?
% P = beamPosition(X, L, d)
%   particles       3xN           - particles in the world
%   laser           1xL           - laser readings (in cm)
%   stride                        - laser array stride (> 0)
%   offset                        - laser (forward) offset
%   hits            BxNx2         - laser x,y position (in cm)
% where N = # particles and B = 1 + ((L-1)/stride)
%
% The final position of the beams in the map is returned as a three
% dimensional matrix, where the first dimension corresponds to the B beams 
% considered, the second to the N particles and the third to the x, y 
% coordinates of the laser measurement in the world. For example, the position [x y] 
% of the first beam considered for the third particle can be retrieved as
% P(0, 3, :). Note that P(:,:,1) has all the BxN x coordinates of the 
% measurements, and P(:,:,2) all the y coordinates.
%
% The number of beams to consider from the measurement array is given by
% B = 1 + ((L-1)/stride). A stride of 1 means that all measurements must be
% considered; a stride of 2 means that every other measurement must be
% considered.. A stride greater than 1 is useful when some beams want to be 
% ignored from the measurement array. 
%
% NOTES: A particle state consists of 3 variables: [x, y, theta].
%        The angle theta is assumed to come in radians, and x, y in cm.
%        The laser is assumed to be positioned in the front of the robot, 
%        at approximately d cm from its true center.
function hits = beamHit(particles, laser, stride, offset)

N = size(particles, 2);                            % number of particles

theta = particles(3,:);                            % particle orientation
dispL = [cos(theta)*offset; sin(theta)*offset];    % laser displacement
positionL = particles(1:2,:) + dispL;              % 2xN laser position (world)

beams = (0:stride:179)*pi/180.0 - pi/2;            % beam angles (robot)                        % number of measurements
B = size(laser,2);                                 % number of beams to consider
thetaB = repmat(theta,B,1) + repmat(beams',1,N);   % BxN beam angles (world)

dispB = cat(3,cos(thetaB),sin(thetaB)).*...        % BxNx2 beam x,y displacement
    repmat(laser', [1 N 2]); 

hits = dispB + ...                                 % BxNx2 hits
    repmat(reshape(positionL', 1, N, 2), [180 1 1]);
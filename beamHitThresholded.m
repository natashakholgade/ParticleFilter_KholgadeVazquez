% Thresholded hit location in world coordinates
% P = beamPosition(X, L, d)
%   particles       3xN           - particles in the world
%   laser           1xL           - laser readings (in cm)
%   minT                          - min allowed laser reading 
%   maxT                          - max allowed laser reading
%   stride                        - laser array stride (> 0)
%   offset                        - laser (forward) offset
%   hits            BxNx2         - laser x,y position (in cm)
% where N = # particles and B = 1 + ((L-1)/stride)
%
% If a range measurement is outside [minT, maxT], then NaN is returned for
% the [x,y] hit coordinate. See beamHit() for a more complete explanation of 
% the other parameters.
function hits = beamHitThresholded(particles, laser, minT, maxT, ...
                                    stride, offset)
                                
laser((laser < minT)) = NaN;
laser((laser > maxT)) = NaN;
hits = beamHit(particles, laser, stride, offset);
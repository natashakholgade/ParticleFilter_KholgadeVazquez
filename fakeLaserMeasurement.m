% Custom built laser log
% [laser, hits] = fakeLaserMeasurement
%   x                 - particle horizontal position
%   y                 - particle vertical position
%   theta             - particle orientation (radians)
%   laserlog    1x180 - laser log
%   hits        2x180 - hits coordinates
%   map         HxW   - occupancy map map
%   resolution        - map resolution
%   hitThreshold      - hit threshold (to determine occupied cells)
%   offset            - laser (forward) offset
%
% The laser log includes the position of the robot when measurements where
% taken. Its format is the same as output by loadLogFile.
%
% See idealLaserMeasurementFromMap for the details about how the log is
% built.
function [laserlog, hits, map, resolution, hitThreshold, offset] = ...
    fakeLaserMeasurement(x, y, theta)

[specs,map] = loadmap('data/map/wean.dat');
resolution = single(specs(3));
particle = [x y theta]';
offset = 25;
laserPos = [cos(theta)*offset+x sin(theta)*offset+y theta];
hitThreshold = 0.9; % < 1 and > 0
maxRange = 8000;
[laser, hits] = idealLaserMeasurementFromMap(particle, 1, offset, map, resolution, ...
                                     hitThreshold, maxRange);

laserlog = [particle' laserPos laser 0];
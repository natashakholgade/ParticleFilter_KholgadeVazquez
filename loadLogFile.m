% loadLogFile
% [RobotPose, LaserReadings] = loadLogFile(logFile)
%   logFile               - path to robot log file
%   RobotPose       4xN   - odometry readings
%   LaserReadings   186xM - laser readings
function [RobotPose, LaserReadings] = loadLogFile(logFile)

fid = fopen(logFile);

RobotPose = [];
LaserReadings = [];

theline = fgetl(fid);
while ischar(theline)
    if (theline(1) == 'L')
        laser = textscan(theline(3:end),...
                            repmat(' %f', 1, 187));
        LaserReadings = [LaserReadings; cell2mat(laser)];
    else
        odometry = textscan(theline(3:end),...
                            '%f %f %f %f');
        RobotPose = [RobotPose; cell2mat(odometry)];
    end
    theline = fgetl(fid);
end

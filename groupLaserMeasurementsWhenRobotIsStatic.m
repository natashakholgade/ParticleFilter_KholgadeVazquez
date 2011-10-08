% Group laser measurements when the robot has static motion
% G = groupLaserMeasurementsWhenRobotIsStatic(laserLog)
%   laserLog    Lx187         - laser logs (as output by loadLogFile)
%   G           {N}           - N groups of laser logs
%
% Each element of the cell G, has a series of laser logs that share the
% same robot position.
function G = groupLaserMeasurementsWhenRobotIsStatic(laserLog)

% Get number of laser logs
nLogs = size(laserLog,1);                           

% when does the robot remain static in the world?
diffState = sum(laserLog(1:nLogs-1,1:3) - laserLog(2:nLogs,1:3),2);
noMotion = [true; diffState == 0];

% how many times does this happen?
uniqueStates = unique(laserLog(noMotion,1:3), 'rows');
nUniqueStates = size(uniqueStates,1);

% group laser readings by robot state
G = cell(nUniqueStates,1);
for g=1:nUniqueStates
    G{g} = laserLog(laserLog(:,1:3) == uniqueStates(g),:);
end








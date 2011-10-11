% Build histogram for single beam and static robot

[~,L2] = loadLogFile('data/log/robotdata2.log');
G2 = groupLaserMeasurementsWhenRobotIsStatic(L2)

L = G2{1}(7:186);
L = L(:,180);

histogram = histLaserData(L, 1);

bar(histogram);
xlabel('meters');
ylabel('count');
title('Laser data');
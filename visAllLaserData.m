% Visualize laser-range sensor data from all log files
% (groups range values by color depending on the log they came from)

[~,L1] = loadLogFile('data/log/robotdata1.log');
[~,L2] = loadLogFile('data/log/robotdata2.log');
[~,L3] = loadLogFile('data/log/robotdata3.log');
[~,L4] = loadLogFile('data/log/robotdata4.log');
[~,L5] = loadLogFile('data/log/robotdata5.log');
 
L1 = L1(:,7:186);
L2 = L2(:,7:186);
L3 = L3(:,7:186);
L4 = L4(:,7:186);
L5 = L5(:,7:186);

range1 = [1, prod(size(L1))];
range2 = [1, prod(size(L2))] + range1(2);
range3 = [1, prod(size(L3))] + range2(2);
range4 = [1, prod(size(L4))] + range3(2);
range5 = [1, prod(size(L5))] + range4(2);

hold on;
visLaserDistribution(L1, range1, 'b');
visLaserDistribution(L2, range2, 'g');
visLaserDistribution(L3, range3, 'k');
visLaserDistribution(L4, range4, 'p');
visLaserDistribution(L5, range5, 'm');


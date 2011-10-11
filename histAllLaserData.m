% Build a histogram from all laser measurements

[~,L1] = loadLogFile('data/log/robotdata1.log');
[~,L2] = loadLogFile('data/log/robotdata2.log');
[~,L3] = loadLogFile('data/log/robotdata3.log');
[~,L4] = loadLogFile('data/log/robotdata4.log');
[~,L5] = loadLogFile('data/log/robotdata5.log');

laser = [L1; L2; L3; L4; L5];
binRange = 10;

histogram = histLaserData(laser, binRange);

bar(histogram);
xlabel('meters');
ylabel('count');
title('Laser data');
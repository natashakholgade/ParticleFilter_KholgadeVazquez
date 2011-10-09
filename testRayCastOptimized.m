% Test raycast optimized 
% !g++ -c -I/Application/MATLAB_R2011a.app/extern/include particle.cpp -o particle.o
mex CXX=g++ -lm particle.o vector2D.o raycast.cpp -output raycast

particle1 = [ 4360; 3980; -pi];
particle2 = [ 6440; 5900; 0];

[~,map] = loadmap('data/map/wean.dat');

idealLaser = raycast(particle1, map, (0:179)*pi/180);
% idealLaser = raycast([particle1 particle2], map, 1:180);

% drawLaserReadingOnMap([particles' 0 0 0 idealLaser 0], 1, 25, 10, 1);
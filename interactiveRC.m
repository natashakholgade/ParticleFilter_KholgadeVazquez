% Test raycast optimized 
% !g++ -c -I/Application/MATLAB_R2011a.app/extern/include particle.cpp -o particle.o
mex CXX=g++ -lm particle.o vector2D.o raycast.cpp -output raycast

particle1 = [ 4360; 3980; pi/2];
particle1=[5710,4040,1.2]';
particle2 = [ 6440; 5900; 0];

[~,map] = loadmap('data/map/wean.dat');

% display('Particle 1');
% idealLaser1 = raycast(particle1, map, (0:179)*pi/180);
%idealLaser = raycast(particle2, map, (0:179)*pi/180);
% 
% display('Particles 1&2');
% idealLaser = raycast([particle1 particle2], map, (0:179)*pi/180);

imshow(map); hold on;

done=false;
while ~done
    h=impoly; cc=getPosition(h); x1=cc(1,1); x2=cc(2,1); y1=cc(1,2); y2=cc(2,2);
    theta=atan2(y2-y1,x2-x1);
    particle1=[x1*10;y1*10;theta];
    particle1
stride = 4;
idealLaser = raycast([particle1 particle2], map, (0:stride:179)*pi/180);
fullIdealLaser = zeros(1,180);
fullIdealLaser(1:stride:180) = idealLaser(1,:);
drawLaserReadingOnMap([particle1' 0 0 0 fullIdealLaser 0], stride, 25, map, 10, 0);

end
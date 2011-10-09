% Initialize Particles for Particle Filter
% Created by Heather Knight 10/5/2011
% Function tested with N=200 and map='wean.dat'

function particles = gen_particles(map, N)

%-1 = 2, +1 =0
%[s,map] = loadmap(map);

% Generate possible occupancy map
a=1-map;   %temp img
%a(a<1)=0;   %Hallway-for-sure: retains all pixels that equal 1
a(a<1)=0;   %Hallway-for-sure: retains all pixels that equal 1

%Hallway points
[hy hx] = find(a);  %indices of hallway points
h=size(hx,1);      %total hallway points

% Initialize particles to Hallway
% initIndices=round(h*rand(N,1));
initIndices=mod(round(2*h*rand(N,1)),h)+1;
size(hx(initIndices));
particles=[hx(initIndices) hy(initIndices) 2*pi*rand(N,1)];


% Plot Images
% d=0.04; %distance between images
% s1=subplot(121);
% imshow(a);
% s2=subplot(122);
% imshow(map); hold;
% indx = find(particles(:,1));
% plot(particles(:,1),particles(:,2), 'xr');
% g1=get(s1,'position');
% set(s1,'position',[0 0 0.5 1])
% set(s2,'position',[g1(1)+g1(3)+d 0 0.5 1])

end
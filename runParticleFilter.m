
%map=loadmap('data/map/wean.dat');
%[particles1,weights1]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',1,[0,0,0,0],10,1,1,1,5);
%saveas(gca,'oneparticle_nonoise_nosensormodel.jpg');
%[particles2,weights2]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',1,[0.1,0.01,0.01,0.1],10,1,1,1,5);
%saveas(gca,'oneparticle_noise_nosensormodel.jpg');
%[particles3,weights3]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',200,[0,0,0,0],10,1,1,1,5);
%saveas(gca,'200particle_nonoise_nosensormodel.jpg');
% [particles5,weights5]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',1000,[0.05,0.08,0.08,0.05],10,4,20,8000,5);
[particles5,weights5]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',2000,[0.04,0.04,0.04,0.04],10,2,20,8000,50);


% [particles5,weights5]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',3000,[0.8,0.8,0.9,0.9],10,4,20,8000,50);


%saveas(gca,'200particle_noise_nosensormodel.jpg');

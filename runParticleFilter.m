
%map=loadmap('data/map/wean.dat');
%[particles1,weights1]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',1,[0,0,0,0],10,1,1,1,5);
%saveas(gca,'oneparticle_nonoise_nosensormodel.jpg');
%[particles2,weights2]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',1,[0.1,0.01,0.01,0.1],10,1,1,1,5);
%saveas(gca,'oneparticle_noise_nosensormodel.jpg');
%[particles3,weights3]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',200,[0,0,0,0],10,1,1,1,5);
%saveas(gca,'200particle_nonoise_nosensormodel.jpg');
[particles4,weights4]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',50,[0.1,0.01,0.01,0.1],10,1,1,1,5);
saveas(gca,'200particle_noise_nosensormodel.jpg');

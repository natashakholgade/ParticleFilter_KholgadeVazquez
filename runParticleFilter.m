
%map=loadmap('data/map/wean.dat');
%[particles1,weights1]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',1,[0,0,0,0],10,1,1,1,5);
%saveas(gca,'oneparticle_nonoise_nosensormodel.jpg');
%[particles2,weights2]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',1,[0.1,0.01,0.01,0.1],10,1,1,1,5);
%saveas(gca,'oneparticle_noise_nosensormodel.jpg');
%[particles3,weights3]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',200,[0,0,0,0],10,1,1,1,5);
%saveas(gca,'200particle_nonoise_nosensormodel.jpg');
% [particles5,weights5]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',1000,[0.05,0.08,0.08,0.05],10,4,20,8000,5);


%[particles5,weights5]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',2000,[0.04,0.04,0.04,0.04],10,2,0,8000,50);
% [particles5,weights5]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',3000,[0.04,0.04,0.04,0.04],10,2,0,8000,50);


% [particles5,weights5]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',3000,[0.8,0.8,0.9,0.9],10,4,20,8000,50);


%saveas(gca,'200particle_noise_nosensormodel.jpg');

%[particles1_1,weights1_1]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',200,[0.04,0.04,0.04,0.04],10,2,0,8000,2,'firstlog_fewparticles_highnoise');
% [particles1_2,weights1_2]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',2000,[0.04,0.04,0.04,0.04],10,2,0,8000,1,'firstlog_manyparticles_highnoise');
% [particles1_3,weights1_3]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',2000,[0.01,0.01,0.01,0.01],10,2,0,8000,5,'firstlog_manyparticles_lownoise_skip5');
 [particles1_5,weights1_5]=particleFilter('data/log/robotdata1.log','data/map/wean.dat',1000,[0.01,0.01,0.01,0.01],10,2,0,8000,1,'trial1');
 %[particles2_5,weights2_5]=particleFilter('data/log/robotdata2.log','data/map/wean.dat',400,[0.01,0.01,0.01,0.01],10,2,0,8000,2,'secondlog_fewparticles_lownoise_step2');
% 
% [particles2_1,weights2_1]=particleFilter('data/log/robotdata2.log','data/map/wean.dat',200,[0.04,0.04,0.04,0.04],10,2,0,8000,1,'secondlog_fewparticles_highnoise');
% [particles2_2,weights2_2]=particleFilter('data/log/robotdata2.log','data/map/wean.dat',2000,[0.04,0.04,0.04,0.04],10,2,0,8000,1,'secondlog_manyparticles_highnoise');
% [particles2_3,weights2_3]=particleFilter('data/log/robotdata2.log','data/map/wean.dat',2000,[0.01,0.01,0.01,0.01],10,2,0,8000,5,'secondlog_manyparticles_lownoise_skip5');
% [particles2_4,weights2_4]=particleFilter('data/log/robotdata2.log','data/map/wean.dat',200,[0.04,0.04,0.04,0.04],10,2,0,8000,5,'secondlog_fewparticles_highnoise_skip5');


N_particles=800;
logfile='data/log/robotdata1.log';
mapfile='data/map/wean.dat';
alphas=[.03,.03,.02,.02];
stride=1;
resolution=10;
minT=10;
maxT=8000;
stepsize=1;
dirname='plottedResults';
stdWThreshold=.025;


particleFilter('data/log/robotdata1.log','data/map/wean.dat',N_particles,alphas,resolution,stride,minT,maxT,stepsize,dirname,stdWThreshold);
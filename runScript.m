mapFile = 'data/map/wean.dat';
logFile = 'data/log/robotdata2.log';

N = [200, 500, 800, 1000, 1500, 2000, 4500];
alphas = [0.03,0.03,0.02,0.02;
          0.01,0.01,0.01,0.01;
          0.04,0.04,0.03,0.03;
          0.08,0.08,0.06,0.06];
      
stdW = [0.025, 0.03, 0.035, 0.04, 0.05];

for l=1:40

for i=1:length(N)
    for j=1:size(alphas,1)
        for k=1:length(stdW)
            try
            dirname=sprintf('finalSecondLogs/log2_%02d_%04d_%d_%d',l,N(i),j,k);
            fprintf(dirname);
            particleFilter(logFile,mapFile,N(i),alphas(j,:),10,1,10,8000,1,dirname,stdW(k));
            catch
                fprintf('%s failed!!', dirname);
            end
        end
    end
end

end
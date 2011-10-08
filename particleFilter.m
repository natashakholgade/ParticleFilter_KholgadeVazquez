function [X,W]=particleFilter(logfile,map,N,alphas,res,stride,minT,maxT,resamplestep)

fid=fopen(logfile);

count=0;

X=gen_particles(map,N)'; % initialize the particles
X=X*res;
W=1/N*ones(N,1); % initialize the weights to all 1/(numparticles)

skip=5; 
skipcount=0;

done=false;
while ~done
    s=fgetl(fid); % read in line of data file
    done=~ischar(s(1)); % loop as long as not eof
    if ~done
        skipcount=skipcount+1; % this is just if you want to skip some lines
        if (skipcount==skip)
            if (s(1)=='O')
                u=extractOdometryInfo(s); % get the odometry information
                if exist('uprev','var') % only works if you have the odometry data from the previous step
                    X=motionModel(X,[uprev;u],alphas); % sample according to motion model
                    %subplot(1,2,2);
                    %hold on;
                    scatter(X(1,:)/res,X(2,:)/res,2,'g');
                    drawnow;
                end
                uprev=u;
            elseif (s(1)=='L') 
                %L=extractLaserReadings(s); % if we have laser info, get the laser readings
                %W1=computeWeights(X,map,res,L,stride,minT,maxT,0); % compute weights for this step given the readings
                %W=W1.*W; % update weights by multiplying with weights from this step
            end
            count=count+1; % update the current count
            if mod(count,resamplestep)==0 % every so often, resample
                [X,W]=resample(X',W);
                X=X';
            end
        skipcount=0;
        end
    end
end

fclose(fid);

end

function [O,ts]=extractOdometryInfo(s)

format=[' %f %f %f %f'];
data=sscanf(s(2:end),format);
O=data(1:3); ts=data(end); 

end

function [L,ts]=extractLaserReadings(s)


format=[repmat(' %f',1,6),repmat( '%f',1,180),' %f'];
data=sscanf(s(2:end),format);
pos1=data(1:3); pos2=data(4:6); 
L=data(6+(1:180))';
ts=data(end);

end
function [X,W]=particleFilter(logfile,map,N,alphas,res,stride,minT,maxT,resamplestep)

fid=fopen(logfile);

count=0;

[~,map]=loadmap(map);
X=gen_particles(map,N)'; % initialize the particles
% map=smoothMap(map,1,[3,3]);
X=X*res;
W=1/N*ones(N,1); % initialize the weights to all 1/(numparticles)

skip=1; 
skipcount=0;

sumW = 1;
drawingMap = map.*0.3;

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
                    X=motionModel(X,[uprev;u],alphas,size(map,2)*res,size(map,1)*res); % sample according to motion model
                    %subplot(1,2,2);
                    %hold on;
%                     figure(1);
%                     imshow(map); hold on;
% %                     hold on;
%                     scatter(X(1,:)/res,X(2,:)/res,3,'g'); 
% %                     for n=1:N
% %                         plot([X(1,n)/res, X(1,n)/res+cos(X(3,n))*20], [X(2,n)/res, X(2,n)/res+sin(X(3,n))*20],'g-');
% %                     end
%                     %pause;
%                     drawnow;
%                     hold off;
                    
                end
                uprev=u;
            elseif (s(1)=='L') 
                L=extractLaserReadings(s); % if we have laser info, get the laser readings
                W1=computeWeights(X,map,res,L,stride,minT,maxT,2); % compute weights for this step given the readings
                W=exp(log(W1)+log(W)); % update weights by multiplying with weights from this step
                
%                 %figure(2); plot(W);
%                 %W1
% 
%                 
%                 %W'
                sumW = sum(W);
                W=W./sumW;
            end
             
            stdW = std(W*100)
%             fprintf('sum(W) = %e, std(W) = %e\n', sumW, stdW);
            if (isnan(sumW) || isnan(stdW) )
                fprintf('HELP!');
                display(sumW);
                display(stdW);
            end
            
            imshow(drawingMap); hold on;
            scatter(X(1,:)/res,X(2,:)/res,3,'r'); 
            hold off;
            title(sprintf('Frame %d', count));
            drawnow;
                
            count=count+1; % update the current count
%             if mod(count,resamplestep)==0 % every so often, resample
%             tmp = 1/sum(W.^2)
%             if tmp < 20
            if (stdW > 0.05)
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
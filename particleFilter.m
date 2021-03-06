function particleFilter(logfile,map,N,alphas,res,stride,minT,maxT,skip,dirname,stdWThreshold)

fid=fopen(logfile);

count=0;

[~,map]=loadmap(map);
X=gen_particles(map,N)'; % initialize the particles
% map=smoothMap(map,1,[3,3]);



X(1:2,:)=X(1:2,:)*res;
W=1/N*ones(N,1); % initialize the weights to all 1/(numparticles)

if ~exist('skip','var')
skip=1; 
end

if ~exist(dirname,'dir')
    mkdir(dirname);
end

skipcount=0;

sumW = 1;
drawingMap = map;
drawingMap(map == 2) = 0;
drawingMap = drawingMap.*0.2;


particlesCovariance = cov(X(1:2,:)');

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
             
            stdW = std(W*100);
%             fprintf('sum(W) = %e, std(W) = %e\n', sumW, stdW);
            if (isnan(sumW) || isnan(stdW) )
                fprintf('HELP!');
                display(sumW);
                display(stdW);
            end
        
            
            if mod(count,10)==0 
                imshow(drawingMap); hold on;
                scatter(X(1,:)/res,X(2,:)/res,2.5,'b'); 


                % check for particles' convergence and draw robot
                particlesCovariance = cov(X(1:2,:)'./10);
                if (max(diag(particlesCovariance)) < 1200)

                    Xmean=X*W;
                    hits = beamHit(Xmean, L, stride, 25);
                    % convert hits from Bx1x2 to Bx2
                    hits = squeeze(hits);
                    drawLaserHits(Xmean, 25, hits, 1/res);

                end

                hold off;
                title(sprintf('Frame %d (N = %d, stdW = %e)', count, N, stdW));
                axis([0 800 0 800]);
                drawnow;
                saveas(gca,sprintf('%s/%04d.png',dirname,count));
            
            end
                
            count=count+1; % update the current count
%             if mod(count,resamplestep)==0 % every so often, resample
%             tmp = 1/sum(W.^2)
%             if tmp < 20

            if (stdW > stdWThreshold)
                [X,W]=resample(X',W);
                X=X';
            end
            %if (count==10000 && max(diag(particlesCovariance)) > 1200)
             %   done=true;
            %end
            
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
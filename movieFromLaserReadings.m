% Make movie from laser readings
% movieFromLaserReadings(movieName, laserReadings)
%   movie                   - path of avi file to be saved
%   laserReadings   Nx187   - laser logs (from loadLogFile)
%   minT                    - min allowed laser reading 
%   maxT                    - max allowed laser reading
function movieFromLaserReadings(movie, laserReadings, minT, maxT)

N = size(laserReadings, 1);     % number of measurements
laserOffset = 25;               % laser (forward) offset wrt the robot center
stride = 1;                     % laser stride

% prelocate movie structure
mov(1:N) = struct('cdata', [], 'colormap', []);

% create movie
figure();
axis equal;
set(gca,'nextplot','replacechildren');

% render one frame per measurement
for frame = 1:N
    
    % draw frame
    drawLaserReading(laserReadings(frame,:), minT, maxT, ...
                     stride, laserOffset);
    % save frame
    mov(frame) = getframe(gcf);
    % clear figure
    clf;
    
end

% create avi file
movie2avi(mov, movie, 'compression', 'None');
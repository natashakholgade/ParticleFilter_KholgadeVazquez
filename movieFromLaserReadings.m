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
    
    % get the orientation of the particle and center it at [0, 0]
    particles = [0; 0; laserReadings(frame,3)];  
    % get sensor measurements
    laser = laserReadings(frame, 7:186);
    % get the laser hits
    hits = beamHitThresholded(particles, laser, minT, maxT, ...
                              stride, laserOffset);
    % draw 
    drawLaserHits(particles', laserOffset, hits);
    
    mov(frame) = getframe(gcf);
    clf;
    
end

% create avi file
movie2avi(mov, movie, 'compression', 'None');
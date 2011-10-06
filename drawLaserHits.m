% Draw laser hits in an abstract world
% f = drawLaserHits(particle, hits)
%   particle    3x1    - particle [p_x, p_y, p_theta]'
%   offset             - laser (forward) offset from the center of the robot
%   hits        Bx2    - hits position [hit_x, hit_y]
%   scaling            - unit scaling
%
% The scaling determines the size of the robot and the beams. If you need
% to draw over a map with resolution of 10, use scaling = 1/10. If you are
% drawing on an abstract world where units do not matter, use scaling = 1.
%
% NOTE: NaN hit positions are not drawn.
function drawLaserHits(particle, offset, hits, scaling)

x = particle(1)*scaling;
y = particle(2)*scaling;
offset = offset*scaling;
theta = particle(3);
drawRobot(x, y, theta, offset);

laserPos = [cos(theta)*offset + x; sin(theta)*offset + y];
hold on;
for h=1:size(hits,1)
   if ~isnan(hits(h,1))
    plot([laserPos(1); hits(h,1)*scaling], ...
         [laserPos(2); hits(h,2)*scaling],'r-');
   end
end

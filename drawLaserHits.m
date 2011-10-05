% Draw laser hits in an abstract world
% f = drawLaserHits(particle, hits)
%   particle    3x1    - particle [p_x, p_y, p_theta]'
%   offset             - laser (forward) offset from the center of the robot
%   hits        Bx2    - hits position [hit_x, hit_y]
%
% NOTE: NaN hit positions are not drawn.
function drawLaserHits(particle, offset, hits)

x = particle(1);
y = particle(2);
theta = particle(3);
drawRobot(x, y, theta, offset);

laserPos = [cos(theta)*offset + x; sin(theta)*offset + y];
hold on;
for h=1:size(hits,1)
   if ~isnan(hits(h,1))
    plot([laserPos(1); hits(h,1)], [laserPos(2); hits(h,2)]);
   end
end

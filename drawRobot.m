% Draw robot as a simple circle
% drawRobot(x, y, theta)
%   x       - x coordinate
%   y       - y coordinate
%   theta   - orientation in radians (0 is looking to the right)
%   radius  - robot radius
function drawRobot(x, y, theta, radius)

robot = circle([x y], radius, 180);
hold on; axis equal;
% draw robot
plot(robot(1,:), robot(2,:));
% draw orientation lines
plot([x, cos(theta-pi/4)*radius], [y, sin(theta-pi/4)*radius]);
plot([x, cos(theta+pi/4)*radius], [y, sin(theta+pi/4)*radius]);

% Construct matrix of circular points
% c = circle(center, radius)
%   center  1x2 - [x,y] center position
%   radius      - circle radius
%   n           - number of points of the matrix to be returned
%   c       2xn - matrix of circular points
function c = circle(center, radius, n)
angles = linspace(0,2*pi,n);
[x, y] = pol2cart(angles, radius);
c = [x; y];

% Draw particles on map
% drawParticlesOnMap(map, resolution, particles)
%   map             HxW - occupancy map
%   resolution          - map resolution
%   particles       3xN - particles with x, y, theta
%
% NOTE: The position of the particles should be given in cm and the
% orientation in radians. The resolution of the map is what dictates how to
% transform the position to map cells.
function drawParticlesOnMap(map, resolution, particles)

% draw map
vismap(map); hold on;

% translate particles' position to map cells
particles(1,:) = particles(1,:)./resolution;
particles(2,:) = particles(2,:)./resolution;

% draw particles
scatter(particles(1,:), particles(2,:), 'r');

% Computes the error for weightsForMap and laserHits
%
% Fake laser measurments are generated for a set of particles. Then, each
% measurement is applied to all particles and evaluated using
% weightFromMap. The printed mean hit error (and its std) are ideally 
% matrices with 0's along their diagonals (meaning small error for 
% measurements  applied to their fake particles). The numbers outside the
% diagonal should be big, since they represent the error computed for fake
% particles with wrong measurements.

particles = [ ...
    6440 4360;  ... % x
    5900 3980;  ... % y
    0    -pi/4  ... % theta
    ];
N = size(particles,2);

laserLogs = zeros(N, 187);
laserHits = zeros(180, N, 2);

meanErr = zeros(N);
stdErr = zeros(N);

weights = zeros(N);

% Build fake measurement
for p = 1:N
    
    % build laser log
    [laserLogs(p,:), hits, map, resolution, hitThreshold, offset] = ...
        fakeLaserMeasurement(particles(1,p), particles(2,p), particles(3,p));
    laserHits(:,p,:) = hits';

    % use laser log with all particles
    hits = beamHit(particles, laserLogs(p,7:186), 1, offset);
    % compute hit error
    err = sqrt(sum((hits - laserHits).^2,3));
    meanErr(p,:) = mean(err);
    stdErr(p,:) = std(err);
    
    % compute weights
    weights(p,:) = weightsFromMap(hits, map, resolution);
end

fprintf('Mean hit error: ');
display(meanErr);
fprintf('Std: ');
display(stdErr);

% Compute weight
fprintf('Weights: ', w);
display(weights);

% Plot hits
vismap(map); hold on;
for p = 1:N
    drawLaserReadingOnMap(laserLogs(p,:), 1, offset, map, resolution, 0);
end

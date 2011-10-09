% Compute particles' weights using the (simple) map-based sensor model
% W = weightsFromMap(hits, map)
%   hits            BxNx2 - laser x,y position (in cm)
%   map             HxW   - map with occupancy probabilities
%   resolution            - map resolution (in cm)
%   W               Nx1   - normalized weights for the particles
%
% Computes P(x|z) directly from the occupancy map. 
function W = weightsFromMap(hits, map, resolution)

mapSize = size(map);                        % map size

hits = floor(hits./resolution);             % convert positions to cells
invalidHits = isnan(hits);                  % 1 for invalid hits 
hits(invalidHits) = 1;                      % replace NaN by 1 so sub2ind works

% Fix beams that fall outside map
x = hits(:,:,1);
y = hits(:,:,2);
outside = (x < 1) | (x > mapSize(2)) | (y < 1) | (y > mapSize(1));
x(x < 1) = 1; x(x > mapSize(2)) = mapSize(2);
y(y < 1) = 1; y(y > mapSize(1)) = mapSize(1);
hits(:,:,1) = x; hits(:,:,2) = y;

% Get probabilities from occupancy map
hitProb = map(sub2ind(mapSize, hits(:,:,2), hits(:,:,1)));

% Ignore invalid beams and fix 0s
% (sum a little number to cells with 0 prob so that the weight is not zero 
% due to few measurement/map inconsistencies)
epsilon = 0.0001;
hitProb(outside) = epsilon;
hitProb(invalidHits(:,:,1)) = 1;
hitProb(hitProb == 2) = 0; %epsilon;
hitProb(hitProb < epsilon) = epsilon;

% Compute joint prob from all beams per particle 
%W = exp(prod(hitProb));
%W=prod(exp(hitProb));
%W=prod(hitProb.^(1/200));
%W=prod(hitProb);
W=sum(hitProb);

% Normalize weights
W = W'./sum(W);
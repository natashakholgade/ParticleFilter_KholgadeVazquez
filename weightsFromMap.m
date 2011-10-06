% Compute particles' weights using the (simple) map-based sensor model
% W = weightsFromMap(hits, map)
%   hits            BxNx2 - laser x,y position (in cm)
%   map             WxH   - map with occupancy probabilities
%   resolution            - map resolution (in cm)
%
% Computes P(x|z) directly from the occupancy map.
function W = weightsFromMap(hits, map, resolution)

mapSize = size(map);                        % map size
N = size(hits,2);                           % number of particles
B = size(hits,1);                           % number of beans
W = zeros(N,1);                             % alloc space for weights

hits = floor(hits/resolution);              % convert positions to cells
hitsCell = mat2cell(hits,B,ones(1,N),2);    % group cells by particle

for p=1:N
    hitsXY = squeeze(hitsCell{p});          % x,y cell index
    hitsXY = [hitsXY(~isnan(hitsXY(:,1))), ... % but discard NaN results
              hitsXY(~isnan(hitsXY(:,2)))];
    
    % compute weight by multiplying cells' occupancy prob
    % (sum a little number to all cells, so that w > 0 when one cell has
    % occupancy = 0)
    W(p) = prod(map(sub2ind(mapSize, hitsXY(:,1), hitsXY(:,2))) + 0.00001);
end

% normalize weights
W = W/sum(W);
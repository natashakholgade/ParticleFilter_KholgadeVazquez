% Visualize probable locations for laser measurement
% visualizeProbableLocationsForLaserMeasurement(P)
%   P       HxWxA   - location probability matrix
%   map     HxW     - map
%
% P is output by findProbableLocationsForLaserMeasurement()
function visualizeProbableLocationsForLaserMeasurement(P,map)

P = max(P,[],3);
P = P./max(max(P));
P = cat(3,P,P,P);

tmp = (map > 0.8 & map <= 1)*0.3;
P(:,:,1) = max(tmp, P(:,:,1));

imshow(P); axis xy;
% Normalized Importance Resampling for Particle Filter weights
% Created by Heather Knight 10/5/2011
% Function tested with M=8 particles/weights

function [out_particles out_weights] = resample(particles, weights)
% global M 

M=size(particles,1);    %number of possible entries
particleIndices = zeros(1,M);

% Create M indices using weights to create continuous PDF
weightCpdf = cumsum(weights./sum(weights));

%disp('Beginning resampling...');
%tic

% Generate rand for starting resampling position
u = rand();
particleIndices(1) = find(u < weightCpdf, 1, 'first');

% Iterate resampling position by 1/N with circular buffer
for m = 2:M
    u = u+1/M;
    if(u>1)
        u=u-floor(u);
        particleIndices(m) = find(u < weightCpdf, 1, 'first');
    else
        particleIndices(m) = find(u < weightCpdf, 1, 'first');
    end
end

%toc;
%disp('Resampling complete!');

% Create new particles with stored indices
out_particles = particles(particleIndices, :);

% Reset all weights
out_weights = 1/M*ones(M,1);

end
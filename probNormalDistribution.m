function p=probNormalDistribution(x,b)

% p=probNormalDistribution(x,b)
%
% provides the probability p(x) under the normal distribution with
% squared deviation b. x can be anything (scalar, vector, or matrix)
% b should be either the same size as x or a scalar
% p will have the same size as x

p=1./sqrt(2*pi*b).*exp(-(x.*x)./(2*b));

end
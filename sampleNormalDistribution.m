function x=sampleNormalDistribution(b,thetype)

% x=sampleNormalDistribution(b)
% 
% returns a sample from the zero-centred normal distribution with variance b
% called as is, it uses the formula frm Thrun, Burgard, and Fox
% 
% x=sampleNormalDistribution(b,'MATLAB')
% 
% uses MATLAB's randn function to return a sample from the
% zero-centred normal distribution with variance b

if nargin>1 && thetype(1)=='M'
    x=sqrt(b).*randn(size(b));
else
    x=b/6.*sum(-1+2*rand(12,length(b)));
end

end
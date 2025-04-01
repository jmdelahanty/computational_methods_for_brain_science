function [betaout, stats] = fitSigmoid_QMbb(varrange, means, betaIn)

[ro,col] = size(means); 
if ro <= col
    varrange = varrange'; 
    means    = means'; 
end

% initialization
c = min(means) - 0.1 * max(means);
s = 1.5 * max(means);
d = mean(varrange);
m = 0.25 * (max(means)-min(means)) / ((varrange(end)-varrange(1))/2);
beta0 = [c, s, d, m];

% Prepare statset with 2000 iterations
myOpts = statset('nlinfit');
myOpts.MaxIter = 2000;

% Fitting
[betaout, res, jacobs, covbs, mse] = ...
    nlinfit(varrange, means, @sigmoid, beta0, myOpts);

% Compute stats
nObs = length(means); 
stats.resid = res';
stats.aic   = 2*4 + nObs*( log( sum(stats.resid.^2)/nObs ) );
stats.w     = ones(nObs,1);
end

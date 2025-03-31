function [beta,stats] = fitLinear_QMbb(varrange,means)
%
% 2.4.09, 4,28.09
% shreesh@stanford.edu
%


[r1,c1] = size(varrange);
if r1<=c1, varrange=varrange'; means=means'; end

% initialization
beta0 = [max(means) (max(means) - min(means))/(min(varrange) - max(varrange))];
options = statset('MaxIter',250);

% fitting
[beta,res,J,covb,mse] = nlinfit(varrange,means,@mylinear,beta0,options);

% computing stats
% std =  mean(abs(betas-betaCI)')'/1.96;
% se = std/sqrt(length(means));
nObs = length(means); 

stats.resid = res'; 
stats.aic     = 2*2 + nObs*(log((sum(stats.resid.^2))/nObs));

stats.w     = ones(length(means),1);
% stats.sstot = sum((means'.*stats.w - mean(means'.*stats.w)).^2);
% stats.sse   = sum((stats.resid.*stats.w).^2);
% stats.rsq     = 1-stats.sse/stats.sstot;


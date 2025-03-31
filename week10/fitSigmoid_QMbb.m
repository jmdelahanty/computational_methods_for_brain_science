function [betaout,stats] = fitSigmoid_QMbb(varrange,means,betaIn)

[ro,col] = size(means); 
if ro<=col, varrange=varrange'; means=means'; end

% initialization
c = min(means)-0.1*max(means);
s = 1.5*max(means);
d = mean(varrange);
m =0.25* (max(means)-min(means))/((varrange(end)-varrange(1))/2); % new 11.09.08
beta0 = [c s d m];
N = length(varrange);

%fitting
%[betas(k,:),ress(k,:),jacobs{k},covbs{k},mses(k)] = nlinfit(varrange,means,@sigmoid,beta0);
[betaout,res,jacobs,covbs,mse] = nlinfit(varrange,means,@sigmoid,beta0);

%computing stats
% std =  mean(abs(beta-betaCI)')'/1.96;
% se = std/sqrt(length(means));
nObs = length(means); 

stats.resid = res'; 
stats.aic     = 2*4 + nObs*(log((sum(stats.resid.^2))/nObs));

stats.w     = ones(length(means),1);
% stats.sstot = sum((means'.*stats.w - mean(means'.*stats.w)).^2);
% stats.sse   = sum((stats.resid.*stats.w).^2);
% stats.rsq     = 1-stats.sse/stats.sstot;


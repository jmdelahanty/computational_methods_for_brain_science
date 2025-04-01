%% Problem Set 10: Classification and Optimization
% The AIC value we obtained in the lecture video/slides is different from
% the AIC value produced by the function fitSignmoid_QMbb. Can you explain
% why? To answer this, proceed step by step...

%% 2a.1: Run the provided commands and code to compare AICs.
clear;
clc;

% The provided code looks like this:
load ps10a_data.mat;
[beta, res] = nlinfit(x, means1, @sigmoid, beta01);

% Compute AIC
nObs = length(x);   % Number of data points
k    = 4;           % Number of parameters in the model (given: 4)
RSS  = sum(res.^2); % Residual sum of squares

% AIC formula for Gaussian errors: AIC = 2*k + nObs*log(RSS/nObs)
aic = 2*k + nObs*(log(RSS/nObs));

%  (v) Display the results
fprintf('--- 2a.1 Results ---\n');
fprintf('nlinfit -> Beta estimates: [');
fprintf('%g ', beta);
fprintf(']\n');
fprintf('Residual Sum of Squares (RSS) = %.4f\n', RSS);
fprintf('Number of observations (nObs) = %d\n', nObs);
fprintf('Number of parameters (k)      = %d\n', k);
fprintf('AIC (computed manually)       = %.4f\n\n', aic);

%% 2a.2: fitSigmoid_QMbb(x,means1);
[beta2, stats1] = fitSigmoid_QMbb(x, means1);

% Display the results of this function
fprintf('--- 2a.2 Results ---\n');
fprintf('fitSigmoid_QMbb -> Beta estimates: [');
fprintf('%g ', beta2);
fprintf(']\n');
fprintf('AIC (from stats1.aic) = %.4f\n\n', stats1.aic);

% Print the difference so its nice for the user
aicDifference = aic - stats1.aic;
fprintf('Comparison of AICs:\n');
fprintf('  nlinfit AIC (manual)        : %.4f\n', aic);
fprintf('  fitSigmoid_QMbb AIC (stats1): %.4f\n', stats1.aic);
fprintf('  Difference (manual - QMbb)  : %.4f\n', aicDifference);

%% 2c.1: Increase the iteration limit to 2000 and re-check AIC
opts = statset('nlinfit');
opts.MaxIter = 2000;
[beta_iter, res_iter] = nlinfit(x, means1, @sigmoid, beta01, opts);

% Compute RSS and AIC again
RSS_iter = sum(res_iter.^2);
nObs     = length(x);
k        = 4;  % still 4 parameters
AIC_iter = 2*k + nObs*log(RSS_iter/nObs);

% Display the new results
fprintf('\n--- 2c.1. Results With MaxIter=2000 (Manual nlinfit) ---\n');
fprintf('Beta estimates: [');
fprintf('%g ', beta_iter);
fprintf(']\n');
fprintf('Residual Sum of Squares (RSS) = %.4f\n', RSS_iter);
fprintf('AIC (after increasing iterations) = %.4f\n\n', AIC_iter);

% 2c.2: Use fitSigmoid_QMbb with hardcoded 2000 iterations

% This call will now use the new, higher iteration limit after manually
% changing how many iterations occur within the code.
[beta2_highIter, stats1_highIter] = fitSigmoid_QMbb_2k_iterations(x, ...
    means1);

% Display the results
fprintf('\n--- 2c.2: Results Using fitSigmoid_QMbb (MaxIter=2000) ---\n');
fprintf('Beta estimates from updated fitSigmoid_QMbb: [');
fprintf('%g ', beta2_highIter);
fprintf(']\n');
fprintf('AIC (stats1_highIter.aic) = %.4f\n', stats1_highIter.aic);

% Compare to your manual nlinfit results
aicDifference_iter2 = AIC_iter - stats1_highIter.aic;
fprintf('Difference (nlinfit AIC - updated fitSigmoid_QMbb) = %.4f\n', ...
    aicDifference_iter2);

%% 3a.1: Sigmoidal vs Linear Models
% Use means2 and determine whether the sigmoidal model or the linear model
% is a better choice. Why?

% First, clear the workspace and the terminal:
clear;
clc;

% Now load the data again
load ps10a_data.mat;

% 2. Fit the sigmoidal model to means2
[beta_sig, stats_sig] = fitSigmoid_QMbb(x, means2);

fprintf('Sigmoid Model Results:\n');
fprintf('  Beta estimates: [');
fprintf('%g ', beta_sig);
fprintf(']\n');
fprintf('  AIC (stats_sig.aic) = %.4f\n\n', stats_sig.aic);

% 3. Fit the linear model to means2
[beta_lin, stats_lin] = fitLinear_QMbb(x, means2);

fprintf('Linear Model Results:\n');
fprintf('  Beta estimates: [');
fprintf('%g ', beta_lin);
fprintf(']\n');
fprintf('  AIC (stats_lin.aic) = %.4f\n\n', stats_lin.aic);
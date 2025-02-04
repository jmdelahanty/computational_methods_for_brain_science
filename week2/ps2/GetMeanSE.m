% Syntax is: Function [output1, output2, ...] = fx_name(input)

function [mu, sigma, sem, normality] = GetMeanSE(x)
%GETMEANSE Computes the mean, standard deviation, SEM of the a vector x.
% Finally, it determines whether the vecotr is normally distributed
% INPUT
%   x - A numeric vector
% OUTPUT:
%   mu: The mean of vector x. Mean is a protected name in MATLAB
%   sigma: The standard deviation of x. Std is protected in MATLAB.
%   sem: The standard error of the mean of x
%   normality: A string stating "Normal" if x is normally distributed and
%   "Not Normal" if x is not normally distributed.

% MATLAB has argument validation interestingly!
% Will error out if the input isn't a row vector of type double
arguments (Input)
    x (1,:) double
end

% The outputs will have the following types
arguments (Output)
    mu double
    sigma double
    sem double
    normality string
end

% Compute the mean, std, and SEM
mu = mean(x);
sigma = std(x);
% Formula for the SEM is the standard deviation over the square root of the
% total number of elements in the vector x.
sem = sigma / sqrt(length(x));

% Use a test to see if the vector is normally distributed. We can use
% Lilliefors Test AKA The Goodness of Fit Test.
% H=1: Not Normal
% H=0: Cannot reject normality at 5% level!
if lillietest(x) == 0
    normality = "Normal"; % string
else
    normality = "Not Normal";
end

end
%% Problem 2: Outliers
% Write a function RemoveOutliers.m that will determine the outliers in a
% distribution and return the "cleaned" version of the distribution without
% the outliers. 

% 2a: How does the MATLAB function boxplot define outliers? Hint: help
% boxplot, see under 'whisker'.
% This is answered in the problem set pdf.

% 2b: Given a distribution (a vector of data), write a function that uses
% the same principle as above to identify the outliers. The input to the
% function should be the data.
function cleanedData = RemoveOutliers(data)
    % RemoveOutliers takes a data vector, computes the first and third
    % quartiles of the data, find the interquartile range (IQR), and
    % removes any points that fall outside:
    % point > q3 + 1.5(q3 - q1)
    % point < q1 - 1.5(q3 - q1)
    % Inputs:
    %   data - vector of numerical values
    % Outputs:
    %   cleanedData - Data vector without detected outliers

    % Calculate the first and third quantiles of the data vector:
    q1 = quantile(data, 0.25);
    q3 = quantile(data, 0.75);

    % Calculate the IQR
    iqr = Q3 - Q1;

    % Define the upper and lower bounds of our outliers
    lowerBound = q1 - 1.5*iqr;
    upperBound = q3 + 1.5*iqr;

    % Apply a filter for data that is above/below our computed bounds
    % We get a logical array of boolean values that is applied against our
    % input vector where only points where the condition is evaluated as
    % true are kept and then returned.
    cleanedData = data(data >= lowerBound & data <= upperBound);
end

% 2c: Include as a second input to the function, 'k', which can be used to
% flexibly change the definition of outliers. In other words, k would
% replace 1.5 inside your function.
% We will update our function from 2b for this:
function cleanedData = RemoveOutliers(data, k)
    % RemoveOutliers takes a data vector, and multiplier k, computes the
    % first and third quartiles of the data, find the interquartile range
    % (IQR), and removes any points that fall outside:
    % point > q3 + k(q3 - q1)
    % point < q1 - k(q3 - q1)
    % Inputs:
    %   data - vector of numerical values Required
    %   k    - Multiplier for the IQR set. Required
    % Outputs:
    %   cleanedData - Data vector without detected outliers

    % Calculate the first and third quantiles of the data vector:
    q1 = quantile(data, 0.25);
    q3 = quantile(data, 0.75);

    % Calculate the IQR
    iqr = Q3 - Q1;

    % Define the upper and lower bounds of our outliers
    lowerBound = q1 - k*iqr;
    upperBound = q3 + k*iqr;

    % Apply a filter for data that is above/below our computed bounds
    % We get a logical array of boolean values that is applied against our
    % input vector where only points where the condition is evaluated as
    % true are kept and then returned.
    cleanedData = data(data >= lowerBound & data <= upperBound);
end


% 2d: Make the function even easier to use by setting it up so that if the
% user does not provide the second input corresponding to k then the
% program automatically uses k=1.5 as the default value.
% We will update our function from 2c for this:
function cleanedData = RemoveOutliers(data, k)
    % RemoveOutliers takes a data vector, and optionally multiplier k,
    % computes the first and third quartiles of the data, find the
    % interquartile range (IQR), and removes any points that fall outside:
    % point > q3 + k(q3 - q1)
    % point < q1 - k(q3 - q1)
    % Inputs:
    %   data - vector of numerical values Required
    %   k    - Multiplier for the IQR set. Optional, default = 1.5
    % Outputs:
    %   cleanedData - Data vector without detected outliers
    
    % Check if a value of k is provided using nargin, number of input
    % arguments. If not, set k to default 1.5
    if nargin < 2
        k = 1.5;
    end


    % Calculate the first and third quantiles of the data vector:
    q1 = quantile(data, 0.25);
    q3 = quantile(data, 0.75);

    % Calculate the IQR
    iqr = Q3 - Q1;

    % Define the upper and lower bounds of our outliers
    lowerBound = q1 - k*iqr;
    upperBound = q3 + k*iqr;

    % Apply a filter for data that is above/below our computed bounds
    % We get a logical array of boolean values that is applied against our
    % input vector where only points where the condition is evaluated as
    % true are kept and then returned.
    cleanedData = data(data >= lowerBound & data <= upperBound);
end
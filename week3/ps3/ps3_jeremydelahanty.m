%% Problem 1: Random Number Vector Generation
% Generate a vector with 30 random numbers drawn from a normal distribution
% with a mean of 3.2 and a variance of 16. Hint: help randn

% First, set a seed for your random number with default so results are
% reproducible

rng("default")

% The randn function can be used for sampling floating-point numbers from a
% normal distribution. Specifically, it will draw from a normal
% distribution with mean 0 and variance of 1. If we have a variable, x,
% that has a mean mu_x and variance sigma-squared_x, the random variable y
% can be calculated as y = ax + b. 

% First, establish what our mean value, a, is from the problem set
mu = 3.2;

% Next, establish the standard deviation b. Since we start out with the
% variance, we can use the sqrt function to get our appropriate b value 4
sigma = sqrt(16);

% Now we can use element wise multiplication against an array of random
% numbers with the appropriate size of 30 defined in the problem set.
y = sigma .* randn(30, 1) + mu;

% We can check that our stats are near to what we expect.
stats = [mean(y) std(y) var(y)];

% We see that we're relatively far off with this default number generator
% because we're not sampling very many values! If we were to sample many
% more times, we would become closer to our true values of sigma and mu.

%% Problem 2: Deriving Variance
% Derive what Var(aX) is. Hint: Replace X with aX on both sides of the
% formula and expand things out.

% This is completed in the word document.

%% Problem 3: Boxplot
% Load the dataset and produce a boxplot of the data to have it match
% (mostly) the shown figure.
% a. Set the color of boxes to red
% b. Plot the median as a dot instead of as a line
% c. Change the outlier symbol to 'x'
% d. Set the xticklables to be Subject 1/2/3
% e. What does the interquartile range of a distribution mean (briefly and
% intuitiively)? Show how you would calculate it for a dataset like a
% vector, x, containing 10 reaction times?

% Clear the workspace
clear;

% Next, load the dataset
load('ps3_3_boxplot.mat')

% Look at the data so we know what we're working with
whos

% We have a set of three columns (patients) with 100 values each. First,
% make a figure
fig3a = figure('Name', 'ps3_3a_jeremydelahanty');

% Now use the builtin boxplot command to plot our data
box3a = boxplot(x);

% 3a: Set the color of the boxes to red
% We can use the set function on box to define properties of the graph
set(box3a, 'Color', 'r')

% 3b: Plot the median as a dot instead of as a line
% We can create a new figure for this plot
fig3b = figure('Name', 'ps3_3b_jeremydelahanty');

% Let's now set multiple components within our plot through the boxplot
% command itself instead of trying to set individual pieces.
box3b = boxplot(x, ...
    'Colors', 'r', ... % set the color of our plots to red
    'MedianStyle', 'line', ... % Use the line, not target, as median
    'Notch', 'on'); % Setup the notch as seen in the problem set figure

% It doesn't appear possible to set the median target properties that are
% found via the get method such as MedianInner, MedianOuter. Instead, find
% the median tag object and set its marker, color, and style to none.
% Later, we'll just plot the median values as red open circles
% (annoyingly...)
medianHandle = findobj(gca, 'Tag', 'Median');
set(medianHandle, 'Marker', ...
    'none', ...
    'MarkerFaceColor', ...
    'none', ...
    'LineStyle', ...
    'none')

% Now, place dots at each median location so we recreate the exact figure
% presentation
medianValues = median(x);

% Use hold on to draw over the currently shown figure
hold on

% Now plot the markers themselves on the graph
plot(1:3, medianValues, 'ro', ... % on boxes 1 through 3, plot red circles
    'MarkerSize', 8, ...          % with open faces at the median values
    'LineWidth', 1, ...           % on the graph
    'MarkerFaceColor', 'none')

% We're done drawing on the graph, so turn hold off.
hold off

% 3c: Plot the outlier symbol as an 'x'
% This is done through simply setting the boxplot value of 'Symbol'. We'll
% just recreate 3b with this added.
fig3c = figure('Name', 'ps3_3c_jeremydelahanty');

box3c = boxplot(x, ...
    'Colors', 'r', ...
    'MedianStyle', 'line', ...
    'Symbol', 'rx', ...
    'Notch', 'on');

medianHandle = findobj(gca, 'Tag', 'Median');
set(medianHandle, 'Marker', ...
    'none', ...
    'MarkerFaceColor', ...
    'none', ...
    'LineStyle', ...
    'none')

hold on

plot(1:3, medianValues, 'ro', ...
    'MarkerSize', 8, ...
    'LineWidth', 1, ...
    'MarkerFaceColor', 'none')

hold off

% 3d: Set the xtick labels to be 'Subject1', 'Subject 2', 'Subject 3'
% We'll recreate 3c with this added. We will also add the title, axis
% labels, font and tick sizes, etc...
fig3d = figure('Name', 'ps3_3d_jeremydelahanty');

box3d = boxplot(x, ...
    'Colors', 'r', ...
    'MedianStyle', 'line', ...
    'Symbol', 'rx', ...
    'Notch', 'on');

medianHandle = findobj(gca, 'Tag', 'Median');
set(medianHandle, 'Marker', ...
    'none', ...
    'MarkerFaceColor', ...
    'none', ...
    'LineStyle', ...
    'none')

hold on

plot(1:3, medianValues, 'ro', ...
    'MarkerSize', 8, ...
    'LineWidth', 1, ...
    'MarkerFaceColor', 'none')

hold off

% Set x-axis labels and their properties
set(gca, 'XTickLabel', {'Subject 1', 'Subject 2', 'Subject 3'})
set(gca, 'FontSize', 10)  % Set tick label font size to 10

% Format Axis labels
xh = xlabel('Subjects');
set(xh, 'FontSize', 15)

yh = ylabel('Data');
set(yh, 'FontSize', 15)

% Add a Title
th = title('Subject Data Boxplots');
set(th, 'FontSize', 18)

% 3e: What does the IQR of a distribution mean briefly/intuitively? Show
% how you would calculate it for a dataset like a vector x containing 10
% reaction times. Write your answer down as comments below the code for
% 3a-3f. Answer in equations and sentences.

% To understand the IQR, it is helpful to first explain what a percentile
% represents. It simply represents the point in a dataset where the
% percentile value of the datapoints are below that value. The IQR
% can be helpful for helping describe a datasets measure of center and how
% dispersed or "spread out" the data is from that center. Specifically, the
% IQR measures the spread of the middle 50% of the dataset. It is
% calculatted as:

% IQR = Q3 - Q1 where...
% Q3: Third Quartile, or 75th percentile.
% Q1: First Quartile, or 25th percentile.

% Finally, the use of the IQR is useful for mitigating the influence of
% extreme values like outliers. With outliers excluded, a small IQR
% indicates that the data is clustered around the median while a large IQR
% indicates that the data is more spread out!

% An example set of MATLAB code for determining this with the example
% values is the following:
% x = [0.25, 0.30, 0.35, 0.40, 0.45, 0.50, 0.55, 0.60, 0.65, 0.70];
% Q1 = quantile(x, 0.25);
% Q3 = quantile(x, 0.75);
% IQR_value = Q3 - Q1;

%% Problem 4: Random Variable Definitions in Statistics
% Given two random variables X and Y, what are the mathematical/statistical
% definitions for:
% a. Uncorrelatedness
% b. Independence
% c. Orthogonality
% d. Do uncorrelated and zero mean random variables mean they are
%    independent? Explain briefly...
% e. Does uncorrelated mean orthogonal? T/F. Explain briefly...

% This is all written in the problem set document.
%% Problem 1: PCA on a Dataset
% The problem description is quite long, but in summary we have spikes from
% a brain region called brain region Y that has been recorded in response
% to a set of stimulus 'mixtures' between stimuli A and B. The goal is to
% see how Y encodes each stimuli through the use of PCA.

% In 1a.i, we describe that reducing the neural dimension is the correct
% choice because we want to see how region Y is encoding the different
% stimuli and not specifically how distinctly each stimuli mixture is
% encoded. To do that, we will perform PCA by reducing against the neural
% dimension of 58 neurons.

% First, load the data:
load("ps6_Data4PCA.mat");

% Inspect our dataset:
whos data

% We see we have our 58x8 matrix of 58 neurons with 8 mixtures response
% patterns. MATLAB Centers on columns by default, in this case our
% responses to the different mixtures, so we need to use a transposed
% representation of the data to perform centering and use PCA on our
% neurons. Doing this 
dataTransposed = transpose(data);

%% 1a.iii
% With our data transposed, we can use the PCA function that's built into
% MATLAB. From the help documentation, we see that PCA returns:
%   coeff: The PCs that describe how much each neuron contributes to the
%       principal component
%   score: Principal component score that describes how different mixtures
%       are projected onto our PCs
%   latent: These are the eigenvalues of each PC that represent how much of
%       the variance is actually captured.
%   tsquared: Hotelling's T-squared statistic which describes how far each
%       mixture's neural response is from the center of all responses
%   explained: How much variance is explained by each PC
%   mu: The mean of the original data before centering
% We can create this output array for our PCA results to be stored in:
[coeff, score, latent, tsquared, explained, mu] = pca(dataTransposed);

%% 1a.iv
% We now need to determine how many of our PCs explain the majority of the
% variance using the cumsum function as desribed in the hint of the problem
% set. We want to do this upon the 'explained' value of our array that PCA
% returned to us.
cumulativeVariance = cumsum(explained);

% Lets now plot this so we have a nice visual representation of how each PC
% captures the variance
figure;
plot(cumulativeVariance, 'o-');
xlabel('Number of Principal Components (PCs)')
ylabel('Cumulative Variance Explained (%)')
title('Cumulative Variance Explained vs Number of PCs')
grid on;

%% 1a.v
% We are instructed to use d=3 for this plot and we want to plot our
% datapoints in a new transformed PC coordinate space. We are instructed to
% make sure that our plot looks like a 3D scatter plot in the problem set
% and to use one color for responses that are "A-heavy" and another for
% responses that are "B-heavy".

% First, lets separate out the A and B "heavy" parts of our dataset. We can
% just create an array that indexes the correct segments of our dataset
% with A heavy being mixtures with >50% A presented and B heavy being
% mixtures with >50% B presented.
% Remember, the percentages described in the problem set reflect how much
% of A is represented in the mixtures
aHeavy = [5 6 7 8]; % Mixtures of 55%, 70%, 85%, 100%
bHeavy = [1 2 3 4]; % Mixtures of 0%, 15%, 30%, 45%

% Now make a new figure for this graph
figure;
hold on;
scatter3(score(aHeavy,1),... 
    score(aHeavy,2),...
    score(aHeavy, 3), ...
    100, 'r', 'filled')
scatter3(score(bHeavy, 1), ...
    score(bHeavy, 2), ... 
    score(bHeavy, 3), ...
    100, 'b', 'filled')
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
title('Neural Responses in PCA Space to A and B Heavy Mixtures')
legend({'A-heavy (55%-100%)', 'B-heavy (0%-45%)'}, 'Location', 'best');
grid on;
view(3)

%% 1a.vii
% If we were to plot a 4-dimensional PC dataset as described in the
% problemset, we would need to plot our PC curves against the stimulus
% mixtures for reasons described in the problemset PDF.

% First, we want to extract the scores from the first 4 principal
% components. We want to transpose the data so we are plotting our mixtures
% on the x axis.
pc4Scores = transpose(score(:, 1:4));

% Create a vector for the stimulus ratios we are plotting against
stimulusRatios = [0, 15, 30, 45, 55, 70, 85, 100];

% Now make the plot of our PCs against stimulus mixtures!
figure;
hold on;
plot(stimulusRatios, pc4Scores(1,:),...
    '-o', 'LineWidth', 2, 'DisplayName', 'PC1');
plot(stimulusRatios, pc4Scores(2,:),...
    '-s', 'LineWidth', 2, 'DisplayName', 'PC2');
plot(stimulusRatios, pc4Scores(3,:),...
    '-^', 'LineWidth', 2, 'DisplayName', 'PC3');
plot(stimulusRatios, pc4Scores(4,:),...
    '-d', 'LineWidth', 2, 'DisplayName', 'PC4');
xlabel('Stimulus Mixture (% A)');
ylabel('PC Projection');
title('Neural Responses Projected onto First 4 PCs');
legend;
grid on;

%% Clear the workspace so we can do the procedure again but for part b!
clear;
close all;

%% 1b.iii
% Now, we will perform the same procedure for our above dataset but doing
% it without transposing the data (or, to put it more confusingly, do it
% with the transpose of our transposed data. The original data)

% First, load the data:
load("ps6_Data4PCA.mat");

% We can create this output array for our PCA results to be stored in:
[coeff, score, latent, tsquared, explained, mu] = pca(data);

%% 1b.iv
% Lets plot the cumulative sum to see how well our variance is explained
% across PCs
cumulativeVariance = cumsum(explained);

% Make a nice plot...
figure;
plot(cumulativeVariance, 'o-');
xlabel('Number of Principal Components (PCs)')
ylabel('Cumulative Variance Explained (%)')
title('Cumulative Variance Explained vs Number of PCs')
grid on;

%% 1b.v
% We will just use 3 dimensions as we did before and plot the data in the
% same way...
% Remember, the percentages described in the problem set reflect how much
% of A is represented in the mixtures
aHeavy = [5 6 7 8]; % Mixtures of 55%, 70%, 85%, 100%
bHeavy = [1 2 3 4]; % Mixtures of 0%, 15%, 30%, 45%

% Now make a new figure for this graph
figure;
hold on;
scatter3(score(aHeavy,1),... 
    score(aHeavy,2),...
    score(aHeavy, 3), ...
    100, 'r', 'filled')
scatter3(score(bHeavy, 1), ...
    score(bHeavy, 2), ... 
    score(bHeavy, 3), ...
    100, 'b', 'filled')
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
title('Neural Responses in PCA Space to A and B Heavy Mixtures')
legend({'A-heavy (55%-100%)', 'B-heavy (0%-45%)'}, 'Location', 'best');
grid on;
view(3)

%% 1b.vii
% We're looking at PCs of the 8 stimulus mixtures so we need to look at
% how each stimulus mixture projects onto these PCs

% Create a vector for the stimulus ratios
stimulusRatios = [0, 15, 30, 45, 55, 70, 85, 100];

% Since we did PCA on the 58×8 matrix, our score matrix is 58×8! We'll just
% index against the coefficients directly.

figure;
hold on;
for i = 1:4
    plot(stimulusRatios, coeff(i,:), '-o', 'LineWidth', 2, 'DisplayName', ['PC' num2str(i)]);
end

% Labels and formatting
xlabel('Stimulus Mixture (% A)');
ylabel('PC Coefficient Value');
title('PC Coefficients Across Stimulus Mixtures');
legend;
grid on;
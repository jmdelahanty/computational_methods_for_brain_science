%% Problem 3: LLE and Dimensionality Reduction
% On the given dataset, perform dimensionality reduction (by manifold
% learning) using LLE.

%% 3a: Ploting the original data
% Plotting the original data in 3-D space using the specified commands (the
% plot should look like an S-curve).

% The problem set states to first load dataset a
load ps8_LLE_datasetA.mat;

% The problem set then states to create a figure with a 3,3,1 subplot
% Make a figure
figure;
% In this figure, use the subplot command to create a grid of subplots in
% the figure. This command will states to create a 3x3 grid of subplots and
% then place this subplot in position 1.
subplot(3,3,1);
scatter3(X(1,:), X(2,:), X(3,:), 20, colorMat)

%% 3b: Apply LLE (using k=20) to reduce the data to a 2-D space
% Apply LLE (using k=20) to reduce the data to a 2-D space (d=2) and plot
% the resulting lower-dimensionald ata in the next "subplot). Use lle.m and
% use scatter3.

% The lle.m function is within our directory, so it's natively available
% for our problem set!
reducedData = lle(X, 20, 2);

% Create the subplot on the figure in the second position
subplot(3,3,2);

% We created a reduced dimension dataset of just 2 dimensions with LLE.
% Now, we can just plot each set of values against one another in a 2D
% Plot!
scatter(reducedData(1,:), reducedData(2,:), 20, colorMat, 'filled');
xlabel('LLE Dim 1'); ylabel('LLE Dim 2');
title('LLE (k=20)');

%% 3c: Apply LLE again with different K values
% Repeat with k=4,6,8,12,16,50,200 and then plot the resulting lower
% dimensional data in each case in successive subplots.
kValues = [4, 6, 8, 12, 16, 50, 200];

% We can simply make a for loop through each of our kValues and then add
% them to the subplot positions. If we add 2 to our ith values, we'll
% account for the figures we've already created!

% For each k value we want to test
for i = 1:length(kValues)
    reducedData = lle(X, kValues(i), 2); % run LLE
    subplot(3,3,i+2); % add that run's data to the subplot through scatter
    scatter(reducedData(1,:), reducedData(2,:), 20, colorMat, 'filled');
    xlabel('LLE Dim 1'); ylabel('LLE Dim 2');
    title(sprintf('LLE (k=%d)', kValues(i)));
end

%% 3e: Repeat steps a-d for ps8_LLE_datasetB.mat.
% This is a more densely sampled version of datasetA

% First, clean the environment:
close all;
clear;

% Now, load the dataset:
load ps8_LLE_datasetB.mat;

% Make a figure
figure;
% Make some subplots and a scatterplot of the data
subplot(3,3,1);
scatter3(X(1,:), X(2,:), X(3,:), 20, colorMat)

% b: Apply LLE (using k=20) to reduce the data to a 2-D space
% Apply LLE (using k=20) to reduce the data to a 2-D space (d=2) and plot
% the resulting lower-dimensionald ata in the next "subplot). Use lle.m and
% use scatter3.

% Apply LLE
reducedData = lle(X, 20, 2);

% Create the subplot on the figure in the second position
subplot(3,3,2);
scatter(reducedData(1,:), reducedData(2,:), 20, colorMat, 'filled');
xlabel('LLE Dim 1'); ylabel('LLE Dim 2');
title('LLE (k=20)');

% c: Apply LLE again with different K values
% Repeat with k=4,6,8,12,16,50,200 and then plot the resulting lower
% dimensional data in each case in successive subplots.
kValues = [4, 6, 8, 12, 16, 50, 200];

% For each k value we want to test
for i = 1:length(kValues)
    reducedData = lle(X, kValues(i), 2); % run LLE
    subplot(3,3,i+2); % add that run's data to the subplot through scatter
    scatter(reducedData(1,:), reducedData(2,:), 20, colorMat, 'filled');
    xlabel('LLE Dim 1'); ylabel('LLE Dim 2');
    title(sprintf('LLE (k=%d)', kValues(i)));
end

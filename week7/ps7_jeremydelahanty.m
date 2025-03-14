%% Problem 2: Performing ICA on our dataset
% We are given a dataset called ps7_newData4ICA.mat where the matrix X is a
% 3x361 matrix with measurements at 261 timepoints from 3 "microphones"
% placed in a room with 3 indepenendent people ("sources") who were having
% a convseration.

%% 2a: Use the ICA package included as a folder pca_ica alongside the
% problem set.

%% 2b: Using this package, perform ICA. First use the fastICA.m function
% paste your code into the PDF.

% First, load up the data
load("ps7_newData4ICA.mat")

% Inspect it with whos
whos

% From the help documentation, fast ICA takes in Z (an dxn matrix with n
% samples of some d-dimensional data), r as the number of independent
% components to compute, and optionally lets you specify which kind of
% non-Gaussianity to maximize with a default of kurtosis.

% First, we need to perform mean centering on the dataset:
centeredX = X - mean(X, 2);

% Since we have 3 sources, we know that we want to set our value of r, the
% number of independent components, to 3
r = 3;

% Now, we apply the FastICA function on our centered data with r=3
% components and we'll ask it to print out what its doing:
[ICAComponents, W, T, mu] = fastICA(centeredX, r, 'kurtosis', 1);


%% 2c) Make a figure with 3x3 subplots that show in the top row signals
% from each original source, in the middle row the signal from each
% microphone, and in the last row each of the three independent components.
% Plot them with the vector t on the x-axes and put the figure in your PDF
% submission.

% First, make the figure:
figure;

% Top row: Original source signals (S)
for i = 1:3
    subplot(3,3,i);
    plot(t, S(i, :)); % Plot the entirety of each row on our graph
    title(['Original Source ', num2str(i)]);
    xlabel('Time');
    ylabel('Amplitude');
end

% Middle row: Microphone recordings (X)
for i = 1:3
    subplot(3,3,i+3);
    plot(t, X(i, :)); % Plot the extracted microphone signals
    title(['Microphone Signal ', num2str(i)]);
    xlabel('Time');
    ylabel('Amplitude');
end

% Bottom row: Extracted independent components (ICA)
for i = 1:3
    subplot(3,3,i+6);
    plot(t, ICAComponents(i, :)); % Plot the ICA values
    title(['Independent Component ', num2str(i)]);
    xlabel('Time');
    ylabel('Amplitude');
end

%% Problem 3: ICA Continued
% Jack Reacher, the twin brother of Jane Reacher from PS 6, wants to know
% what ICA reveals about the neural data in that problem set.

%% 3a) Perform ICA on the same neural dataset you used for PCA in last
% week's problem set, ps6_Data4PCA.mat

% We'll use similar code from last week...
% Clear the workspace
clear; 
close all;

% Load the dataset
load("ps6_Data4PCA.mat");

% Inspect the data so we know what we're working with
whos data

% Center the data
centeredData = data - mean(data, 2); % Subtract mean across neurons

% Choose the number of independent components (we'll pick 8 because we have
% 8 conditions
r = 8;

% Perform ICA
[ICAComponents, W, T, mu] = fastICA(centeredData, r, 'kurtosis', 1);

% Create stimulus condition labels of % stimulus A in mixture
stimulusRatios = [0, 15, 30, 45, 55, 70, 85, 100];

% Plot all 8 independent components as lines in a 2D graph...
figure;
hold on;
for i = 1:r
    plot(stimulusRatios, ICAComponents(i, :), '-o', 'LineWidth', 2, 'DisplayName', ['IC' num2str(i)]);
end

% Make the graph pretty...
xlabel('Stimulus Mixture (% A)');
ylabel('ICA Activation');
title('Independent Components Across Stimulus Mixtures');
legend;
grid on;

% This yields a crazy graph that I definitely can't interpret! We can also
% try to see if there's anything useful in a coarser description between
% heavy A and heavy B stimulus presentations...

% Define Heavy A and Heavy B stimulus indices
aHeavy = [5 6 7 8]; % Stimuli: 55%, 70%, 85%, 100%
bHeavy = [1 2 3 4]; % Stimuli: 0%, 15%, 30%, 45%

% Extract the corresponding ICA activations
ICs_HeavyA = ICAComponents(:, aHeavy);
ICs_HeavyB = ICAComponents(:, bHeavy);

% Create stimulus condition labels for plotting
stimulusRatios_A = [55, 70, 85, 100];
stimulusRatios_B = [0, 15, 30, 45];

% Plot Heavy A
figure;
hold on;
for i = 1:3 % Only plotting first 3 ICs for clarity
    plot(stimulusRatios_A, ICs_HeavyA(i, :), '-o', 'LineWidth', 2, 'DisplayName', ['IC' num2str(i)]);
end
xlabel('Stimulus Mixture (% A)');
ylabel('ICA Activation');
title('Independent Components for Heavy A Mixtures');
legend;
grid on;

% Plot Heavy B
figure;
hold on;
for i = 1:3
    plot(stimulusRatios_B, ICs_HeavyB(i, :), '-o', 'LineWidth', 2, 'DisplayName', ['IC' num2str(i)]);
end
xlabel('Stimulus Mixture (% A)');
ylabel('ICA Activation');
title('Independent Components for Heavy B Mixtures');
legend;
grid on;

%% 3c) Now lets perform dimensionality-reduced ICA with 2 and 3 components
% as suggested in the problem set.
r = 2;
[ICAComponents2, W2, T2, mu2] = fastICA(centeredData, r, 'kurtosis', 1);

% Plot the 2 independent components
figure;
hold on;
for i = 1:r
    plot(stimulusRatios, ICAComponents2(i, :), '-o', 'LineWidth', 2, 'DisplayName', ['IC' num2str(i)]);
end
xlabel('Stimulus Mixture (% A)');
ylabel('ICA Activation');
title('2 Independent Components Across Stimulus Mixtures');
legend;
grid on;

% Define Heavy A and Heavy B stimulus indices for visualization
aHeavy = [5 6 7 8]; % Stimuli: 55%, 70%, 85%, 100%
bHeavy = [1 2 3 4]; % Stimuli: 0%, 15%, 30%, 45%

% Create color coding for stimulus types
colors = [repmat([0 0 1], length(bHeavy), 1); repmat([1 0 0], length(aHeavy), 1)]; % Blue = B-heavy, Red = A-heavy

% Plot 2 ICs with color coding
figure;
hold on;
for i = 1:r
    scatter(stimulusRatios, ICAComponents2(i, :), 100, colors, 'filled');
    plot(stimulusRatios, ICAComponents2(i, :), '-k', 'LineWidth', 1);
end
xlabel('Stimulus Mixture (% A)');
ylabel('ICA Activation');
title('2 Independent Components with Color-Coded Stimulus Types');
legend({'B-heavy (0%-45%)', 'A-heavy (55%-100%)'}, 'Location', 'best');
grid on;

% Now with 3 components
r = 3;
[ICAComponents3, W3, T3, mu3] = fastICA(centeredData, r, 'kurtosis', 1);

% Plot the 3 independent components
figure;
hold on;
for i = 1:r
    plot(stimulusRatios, ICAComponents3(i, :), '-o', 'LineWidth', 2, 'DisplayName', ['IC' num2str(i)]);
end
xlabel('Stimulus Mixture (% A)');
ylabel('ICA Activation');
title('3 Independent Components Across Stimulus Mixtures');
legend;
grid on;

% Plot 3 ICs with color coding
figure;
hold on;
for i = 1:r
    scatter(stimulusRatios, ICAComponents3(i, :), 100, colors, 'filled');
    plot(stimulusRatios, ICAComponents3(i, :), '-k', 'LineWidth', 1);
end
xlabel('Stimulus Mixture (% A)');
ylabel('ICA Activation');
title('3 Independent Components with Color-Coded Stimulus Types');
legend({'B-heavy (0%-45%)', 'A-heavy (55%-100%)'}, 'Location', 'best');
grid on;

% Create 2D scatter plot of ICs to visualize clustering
figure;
scatter(ICAComponents2(1, :), ICAComponents2(2, :), 100, colors, 'filled');
xlabel('IC1');
ylabel('IC2');
title('Stimulus Representations in IC1-IC2 Space');
grid on;
% Add text labels for each point
for i = 1:length(stimulusRatios)
    text(ICAComponents2(1, i), ICAComponents2(2, i), [' ' num2str(stimulusRatios(i)) '%'], 'FontSize', 8);
end
legend({'B-heavy (0%-45%)', 'A-heavy (55%-100%)'}, 'Location', 'best');

% If using 3 ICs, create a 3D scatter plot
if r >= 3
    figure;
    scatter3(ICAComponents3(1, :), ICAComponents3(2, :), ICAComponents3(3, :), 100, colors, 'filled');
    xlabel('IC1');
    ylabel('IC2');
    zlabel('IC3');
    title('Stimulus Representations in IC1-IC2-IC3 Space');
    grid on;
    % Add text labels for each point
    for i = 1:length(stimulusRatios)
        text(ICAComponents3(1, i), ICAComponents3(2, i), ICAComponents3(3, i), [' ' num2str(stimulusRatios(i)) '%'], 'FontSize', 8);
    end
    legend({'B-heavy (0%-45%)', 'A-heavy (55%-100%)'}, 'Location', 'best');
    view(3);
end
%% Problem 1: 3D Plotting
% Dataset: ps2_2_3D.mat
% Patients numbered 1, 2, and 3 are administered two drugs 'a' and 'b'.
% Their responses to the drugs are measured over seven time points in terms
% of three variables: (i) blood pressure, (ii) reaction time, and (iii)
% performance on the cognitive task (all normalized in some way). Load the
% associated mat file and you will find six matrices named accordingly. For
% instance, a1 is the response of patient 1 to drug 'a' and so on. Each row
% in a1 contains the response at given time point and the coluns correspond
% to the three variables.

% A. In one figure, plot (in 3D) the responses of all the patients to the
% two drugs as a function of time and see how the two drugs have different
% temporal effects on the patients. Make sure to use two different colors
% for the responses of the patients to the two drugs. Mark all the data
% points for drug 'a' using circles and for drug 'b' using squares.

% First, load the dataset
load ps2_2_3D.mat

% Display the variables in the workspace through whos just to see it
whos

% We see our three patients assigned to the two different drugs in a set of
% 6 matrices in a 7 row x 3 column shape. We can think of each row
% containing a 3D datapoint of (x,y,z) for our axes of blod pressure,
% reaction time, and overall performance in the task. So we'll have 7
% datapoints in a 3d space for each patient with each drug!

% Now, create a figure:
figure("Name", "ps2_1a")
hold on; % This ensures our plots are on the same figure!
grid on; % This will make sure the xyz gridlines are visible

% We can make this easier to write and maintain by making arrays of our
% matrices that we can plot against later. So first, put each set of data
% into its own array
drugaData = {a1, a2, a3};
drugbData = {b1, b2, b3};

% Now, since we know the total number of patients for each group, we can
% make a variable that we use in a for loop to plot over each array!
numPatients = 3;

% This for loop will plot, in the same figure (remember, hold on!) for
% drug a:
%   all the values for each patient (p)
%   with circles connected by lines
%   in the color red
for p = 1:numPatients
    plot3(drugaData{p}(:,1), drugaData{p}(:,2), drugaData{p}(:,3), ...
          'o-', ...
          'Color', 'r', ...
          'MarkerFaceColor','r');
% And then do the same thing for b! Except:
%   with square points connected by lines
%   in the color blue
    plot3(drugbData{p}(:,1), drugbData{p}(:,2), drugbData{p}(:,3), ...
          's-', ...
          'Color', 'b', ...
          'MarkerFaceColor','b');
end

% Now we need to add labels to our graph! We can do that with the simple x,
% y, and z label functions as well as the title and legend functions. The
% fontsize of each label must be 15 as per the problem set description. The
% fontsize of our title must be 18. The font size of our x, y, and z tick
% labels must be 10.
set(gca, 'Color', 'white', ...  % make the background of our figure white
    'GridColor', [[0.5, 0.5, 0.5]]) % make grey gridlines for the plot
ax = gca; % Get the currently manipulated axis
x = xlabel('Blood Pressure (normalized)');
ax.XAxis.FontSize = 10; % first set ticks + label to 10
ax.XLabel.FontSize = 15; % then alter just the label to be 15!
y = ylabel('Reaction Time (normalized)');
ax.YAxis.FontSize = 10;
ax.YLabel.FontSize = 15;
z = zlabel('Cognitive Performance (normalized)');
ax.ZAxis.FontSize = 10;
ax.ZLabel.FontSize = 15;
t = title('Responses of Patients to Drug a and Drug b over Time');
set(t, 'fontsize', 18)
legend({'Drug a','Drug b'}, 'Location','best');
% Lastly, set the text as specified in the problemset for part B
% 1B
text(0.05, 0.95, ...
     'Red -> Effect of drug 1, Blue -> Effect of drug 2', ...
     'Units', 'normalized', ...       % interpret x,y as [0..1] of axes
     'FontSize', 12, ...              % set text font size
     'Color', 'w', ...                % text color
     'Interpreter', 'none');          % to show symbols exactly as typed

% If you don't force MATLAB to use a 3D perspective, it won't show you
% all the data! Use view(3) to force a 3D perspective.
view(3);

% Bonus Problem
% Data corresponding to different time points are to be represented using
% symbols of increasing size, with early time points represented using
% small symbols or markers and later data points represented using large
% symbols

% The hint for the bonus problem tells us to use scatter3 instead of plot3.
% If we look online, this is because scatter lets you have different size
% scaling for each datapoint!

% We know that we have 7 timepoints, so we can make an array for the sizes
% of each marker that will be used in plotting later.
timePoints = 7;

% Start with a minimum marker size of 10
minimumMarkerSize = 10;

% Set a maximum marker size of 70
maximumMarkerSize = 70;

% Make the array! We can use linspace for this because we can just have
% increments of 10 added evenly up to 70.
markerSizes = linspace(minimumMarkerSize, maximumMarkerSize, timePoints);

figure("Name", "ps2_1a_bonus");
hold on;
grid on;

% We can loop again over our timepoints and get a different marker
% size depending on which time point we are in!

% For each patient...
for p = 1:numPatients
    % Loop over each time point for a different marker size
    for t = 1:timePoints
            % Draw Drug a's data point as a red circle and use size
            scatter3(drugaData{p}(t,1), ...
                drugaData{p}(t,2), ...
                drugaData{p}(t,3), ...
                markerSizes(t), "r", "filled", "o")
            % Draw Drug b's data points as a blue square and use size
            scatter3(drugbData{p}(t,1), ...
                drugbData{p}(t,2), ...
                drugbData{p}(t,3), ...
                markerSizes(t), "b", "filled", "s")
    end
end

% Use the problem set's definitions for formatting
set(gca, 'Color', 'white', ...  % make the background of our figure white
    'GridColor', [[0.5, 0.5, 0.5]]) % make grey gridlines for the plot
ax = gca; % Get the currently manipulated axis
x = xlabel('Blood Pressure (normalized)');
ax.XAxis.FontSize = 10; % first set ticks + label to 10
ax.XLabel.FontSize = 15; % then alter just the label to be 15!
y = ylabel('Reaction Time (normalized)');
ax.YAxis.FontSize = 10;
ax.YLabel.FontSize = 15;
z = zlabel('Cognitive Performance (normalized)');
ax.ZAxis.FontSize = 10;
ax.ZLabel.FontSize = 15;
t = title('Responses of Patients to Drug a and Drug b over Time');
set(t, 'fontsize', 18)
legend({'Drug a','Drug b'}, 'Location','best');
% Lastly, set the text as specified in the problemset for part B
% 1B
text(0.05, 0.95, ...
     'Red -> Effect of drug 1, Blue -> Effect of drug 2', ...
     'Units', 'normalized', ...       % interpret x,y as [0..1] of axes
     'FontSize', 12, ...              % set text font size
     'Color', 'w', ...                % text color
     'Interpreter', 'none');          % to show symbols exactly as typed

% If you don't force MATLAB to use a 3D perspective, it won't show you
% all the data! Use view(3) to force a 3D perspective.
view(3);


%% Problem 2: Errorband
% Dataset: ps2_3_errb.mat
% Recall the idea of "errorband" discussed in class (visualizing a series
% of error bars as a shaded area that is translucent). In the associated
% dataset, you are given the average bold signal from a voxel as a function
% of time. You are also given the s.e.m. of the signal. Plot the average as
% a function of time with the SEM shown as an error band. Hint: Use the
% fill command. Also use the alpha(value) command, where value is between
% 0 and 1.

% First, clear the workspace from our previous problem
clear

% Now, load up the dataset
load ps2_3_errb.mat

% Inspect the dataset with whos
whos

% We see that we have 12 timepoints with a signal and standard error of the
% mean as two separate arrays. From lecture, we learned that we can use
% subplots, fill, and set the values of each SEM for our data as follows:

% First, make a figure with hold on
figure("Name", "ps2_2");

% Plot the mean signal. The x vector should be time while the y value
% should be the average signal (signal)
plot(timePoints, signal, 'k-', 'LineWidth', 2)
hold on;
grid on;

% Now create arrays for our upper and lower bounds of the plot
signalPlus = signal + sErrorMean;
signalMinus = signal - sErrorMean;

% First, plot the error bands with a fill that has the top and bottom error
% bands
h = fill([timePoints fliplr(timePoints)], ...
    [signalPlus fliplr(signalMinus)], ...
    'r');
set(h, 'EdgeColor', 'none');
alpha(0.3);

% Now make our axis labels, ticks, title, etc according to the problem set
% definitions
set(gca, 'Color', 'white', ...  % make the background of our figure white
    'GridColor', [[0.5, 0.5, 0.5]]) % make grey gridlines for the plot
ax = gca; % Get the currently manipulated axis
xlabel('Time Points');
xlim([1, 13])
ax.XAxis.FontSize = 10; % first set ticks + label to 10
ax.XLabel.FontSize = 15; % then alter just the label to be 15!
ylabel('Average BOLD Signal');
ax.YAxis.FontSize = 10;
ax.YLabel.FontSize = 15;
t = title('Patient Average BOLD Signal from Voxel');
set(t, 'fontsize', 18)

%% Problem 3: Surface Plot
% Dataset: Generated below
% Create a variable x that varies from 1 to 25 in steps of 1. Create y so
% that y varies from 0.02 to 0.09 in steps of 0.01. Create a surface plot
% of z such that z = exp(-yx).

% Clear the last problem's workspace
clear

% First, define x from 1 to 25 with a step size of one.
x = 1:1:25; % The syntax here is: Start:Step:End (Inclusive)

% Now define y from 0.02 to 0.09 with a step of 0.01
y = 0.02:0.01:0.09;

% Now, we need to create a mesh grid of points of our x and y values
[X, Y] = meshgrid(x, y);

% Next, create Z with element-wise multiplication with the .* operator
Z = exp(-Y .* X); % exp is how you create exponentials

% Now make the surface plot!
figure();
surf(X, Y, Z);

% Finally, add the axes labels, tick marker customization, title, etc...
set(gca, 'Color', 'white', ...  % make the background of our figure white
    'GridColor', [[0.5, 0.5, 0.5]]) % make grey gridlines for the plot
ax = gca; % Get the currently manipulated axis
xlabel('X Array');
ax.XAxis.FontSize = 10; % first set ticks + label to 10
ax.XLabel.FontSize = 15; % then alter just the label to be 15!
ylabel('Y Array');
ax.YAxis.FontSize = 10;
ax.YLabel.FontSize = 15;
zlabel('Z = exp(-YX)');
ax.ZAxis.FontSize = 10;
ax.ZLabel.FontSize = 15;
t = title('Mesh Plot of Z = exp(-YX)');
set(t, 'fontsize', 18)

%% Problem 4: Writing a Function
% Write a function GetMeanSE.m that takes as input any vector X, computes
% the mean, standard deviation, and standard error of the mean of the
% vector, determine if x is normally distributed or not, and returns 4
% outputs:
% mean, std, sem, text "normal" if normal, and "not normal" if not!

% The implementation is within the file GetMeanSE.m submitted in the
% problem set.

%% Problem 5: Figuring out what Sum is up to
% x is a 3D matrix. Say, x = rand(3,5,2); Try typing sum(x). What does it
% do? Can you describe the principle MATLAB i susing to produce the answer?

% Clear the workspace
clear

% Create x with 3 rows, 5 columns, 2 slices
x = rand(3, 5, 2);

% Perform the sum of x
sum(x)

% The help function tells us that the sum function returns the sum of
% elements of a matrix A along the first array dimension whose size does
% not equal one. Our first dimension of rows is 3! This means that MATLAB
% will sum down the rows! So we end up with a result of a:
% 1x5x2 matrix!
% Its a sum of the rows for each column and there are two slices!
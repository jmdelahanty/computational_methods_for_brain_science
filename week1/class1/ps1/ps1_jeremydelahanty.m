%% Problem 1: Accessing elements of a matrix
% Dataset: ps1_q1.mat
% This problem focuses on loading data and accessing different elements
% of a given dataset. We are in the same directory as our data, so
% defining a path explicity is not necessary. We can just supply the
% filename.

% Load the data using the simple load command
load ps1_q1.mat

% Display the variables in the workspace loaded from ps1_q1.mat via whos
whos

% In the command window, you should see something like this:
% Name:     Size:       Bytes       Class       Attributes
% x         3x4x4       384         double      

% 1A: What is x and its dimension?
% We can see that x is a group of matrices stored as an array. Each
% array has a size of 3 rows and 4 columns (3x4). There are a total of
% 4 matrices that make up this array. The array takes up 384 bytes of
% memory on the computer and it is a double precision datatype, meaning
% each number consists of 64 bit precision floating point numbers.

% 1B: Access all row elements in column 2 and "slice" 3. Describe
% the format of the output ("it looks like a ...").
% This can be achieved through the simple indexing we learned in lecture.
% Since we have an array, we can index it with parentheses.
oneb_answer = x( ...
    :, ... % Select all rows
    2, ... % Second column
    3 ... % Third slice
    ) % Don't use a semicolon and suppress the output

% This essentially looks like a column vector!

% 1C: Access all column elements in row 3 and "slice" 2. Describe the
% format of the output.
% This can be achieved using the same kind of parentheses indexing as
% in 1b
onec_answer = x( ...
    3, ... % Select the third row
    :, ... % All columns
    2 ... % Second slice
    )

% This looks like a row vector!

% 1D: Access the elements in all the 'slices' in row 1 and column 4 and
% assign them to a new variable y. Describe the format of the out put
% Again, lets use the parentheses indexing as described before.
y = x( ...
    1, ... % Select the first row
    4, ... % Fourth column
    : ... % All "slices"
    )

% Here we are accessing only a single element of each slice and will
% therefore see a 1x1x4 array displayed one by one!

% 1E: Type the following on the command line. Compare the output to y and
% describe how elements from y are being reshaped inot the output.
squeeze(y)

% We can see that it is as though each element has been "squeezed" into a
% column vector.

% 1F: Type help squeeze on the command line. Based on this, describe what
% squeeze does in general.
% You see that squeeze is defined as the following:
% Remove dimensions of length 1. It returns an array with the same elements
% as the input array A, but with dimensions of length 1 removed.

%% Problem 2: Reshaping matrices
% Dataset: ps1_q2.mat
clear; % removes all variables and
load ps1_q2.mat % loads the next dataset

% 2A: What is x1 and its dimension
% We can use whos so the variables are displayed in the terminal.
whos

% This will show us that x1 is a 1x6 double precision floating point row
% vector that takes up a total of 48 bytes of memory.


% 2B: Type y1=reshape(x1, 3, 2). Describe what this does to x1.
y1 = reshape(x1, 3, 2)

% This changed the dimensions of the array so our row vector is now a 3x2
% matrix!

% 2C: Compare the elements of y1 and x1. Describe the manner in which
% elements from x1 are picked up and placed in y1. There is a specific
% relationship!
% x1 = [1, 44, 7, 3, 99, 21]
% y1 = [1, 3; 44, 99; 7, 21]
% From the reshape help, we see that the function takes in some input array
% A and the output size is defined through the values 3, 2 defining the 3x2
% matrix that is created. It is creating a column vector by selecting the
% first 3 elements of the row vector. Once filled, it moves onto the last
% three elements of the row vector to create the second column thus
% yielding the 3x2 array!

% 2D: Type y3=reshape(x2,2,10). Describe the manner in which elements
% from x2 are picked up and placed in y3. Are you seeing a pattern in the
% way MATLAB reshapes one matrix to another? Can you describe this
% principle that MATLAB seems to be using?
y3 = reshape(x2, 2, 10)

% As described in 2C, it takes the output row size (in this case 2) items
% in the array and iterates through the original matrix column size number
% of times. It possibly has to reshape the original matrix into a row
% vector first to accommodate this type of iteration.

% 2E: Type y4=reshape(x2, 3, 6). Describe what happened and come up with
% the condition that needs to be satisfied for reshape to work.
y4 = reshape(x2, 3, 6)

% We receive an error message! It states that the number of elements must
% not change. This effectively means that the number of elements in the
% newly reshaped array must equal the number of elements in the original
% array. Perhaps another condition is that the reshaped array's dimensions
% must be some form of factor of the original array's size/number of
% elements.

%% Problem 3: Doing other things to a matrix
% Dataset: ps1_q3.mat
clear;
load ps1_q3.mat

% 3A: Type x (and hit enter). Then, type y1=flip1r(x). Describe how y1 is
% related to x.
x
y1 = fliplr(x)

% y1 is a flipped copy of x over a vertical axis. From the help
% documentation, the function returns the original array with its columns
% flipped about the vertical axis.

% 3B: Type y2=flipud(x). Describe how y2 is related to x.
x
y2 = flipud(x)

% y2 is a flipped copy of x over a horizontal axis. From the help
% documentation, the function returns the original array with its rows
% flipped about a horizontal axis.

% 3C: Type y3 = shiftdim(x2, 1). How is y3 related to x2, (or) what does
% this usage of "shiftdim" do to x2?
x2
y3 = shiftdim(x2, 1)

% We see that y3 has a different shape than x2. Specifically, the y3 array
% is a reshaped array that has taken the "row" dimension and translated it
% into a "slice" dimension! In other words, the original row dimension has
% become the slice dimension, the original column dimension has become the
% row dimension, and the row dimension has become the slice dimension!

% 3D: Type x3 (and hit enter). Now, without using MATLAB, can you write out
% what y4 = shiftdim(x3, 2) is? Again, DO NOT USE MATLAB FOR THIS. You need
% to work this out by hand.
x3

% This is done on the submitted .pdf.

% 3E: Without using MATLAB, tell us what the size of y4 is (rows x columns
% x slices)

% This is done on the submitted .pdf

% 3F: Without using MATLAB, tell us what the size of y4 is (rows x columns
% x slices).

% This is done on the submitted .pdf

%% Problem 4: Threshold Crossing
% Dataset: ps2_1_thr.mat
clear;
load ps1_q4_thr.mat

% We can use the hints as a framework for solving this problem.

% 4A: Load the file
% This has already been done at the start of this block! We load the
% threshold data with the simple load command.

% 4B: Use the find command
% The find command takes in some array or matrix and evaluates it against a
% condition supplied to the function. In our case, we want to determine the
% timepoint (along the x axis) where the number of active voxels (y) is
% larger than 250. Since find gives us the indices where our condition is
% non-zero (or true essentially), we can use find against the voxel dataset
% and then use the first element that is found that satisfies the condition
% to map which timepoint it corresponds to!

% Define a condition
condition = 250; % defined in the problemset
pfc_voxels_activated_over_condition = ... 
    find(activeVoxels > condition, ... % Condition to evaluate the array
    1, ... % We need just the first time, so only find one instance!
    "first" ... % Specifically search for this first value!
    );

% 4C: Use the function 'disp' to print the first time instant at which 250
% or more voxels are active. Use num2str to convert the value returned by
% indexing timePoints by the index found from the find function. Finally,
% display all these things in the terminal!
disp( ...
    ['Time Point of first > 250 voxel activation: ', ...
    num2str(timePoints(pfc_voxels_activated_over_condition)), ...
    ' minutes'])

% 4D: Plot the data in blue circles, join them with a black line, and draw
% a red horizontal line at the threshold of 250. Make sure to label the
% graph with a title and axes.
% Create a normal figure window
figure('WindowStyle', 'normal');

% Set both figure and axes background to white
% gcf: get current figure
% gca: get current axis
set(gcf, 'Color', 'white'); % Set figure background to white
set(gca, 'Color', 'white'); % Set axes background to white

% Plot with blue circles connected by black line
% Ensure hold is on before plotting because without it, you'll overwrite
% each plot with each successive plot command!
hold on;
plot(timePoints, ...
    activeVoxels, ...
    'k-'); % black connecting line
plot(timePoints, ...
    activeVoxels, ...
    'bo', ...
    'MarkerFaceColor', ...
    'b'); % blue filled circles

% Add horizontal threshold line from the condition
yline(condition, 'r-'); % red horizontal line at y=250

% Add labels
xlabel('Time (minutes)');
ylabel('Number of Active Voxels');

% Improve title visibility
title('Active Voxels Over Time', ...
    'FontSize', 14, ...          % Increase font size
    'Color', 'k', ...            % Set font color to black
    'FontWeight', 'bold');       % Make font bold

% Finally, plot the axes at the very "top" layer of the figure!
set(gca, 'XColor', 'k', ...
    'YColor', 'k'); % Set axes color to black for visibility

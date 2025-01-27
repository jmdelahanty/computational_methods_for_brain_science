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

% We can visualize it temporarily for the user by making a simple figure!
ps1_q1a_visualization = figure; % Declare the figure variable
imshow( ...
    'array-3d-viz.vercel.app.png', ... % Show this particular image
    'InitialMagnification', ...        % Show at normal magnification
    100 ...
    )
title('x Array Visualization') % Give it a useful title
pause(3) % pause the code for 3 seconds so the user can see it
close(ps1_q1a_visualization) % close the figure
clear ps1_q1a_visualization % clear the variable from memory

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
% format of the output
% This can be achieved using the same kind of parentheses indexing as
% in 1b
onec_answer = x( ...
    3, ... % Select the third row
    :, ... % All columns
    2 % Second slice
  )

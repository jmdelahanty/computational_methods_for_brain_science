%% Problem Set 9: Comparing Classification Algorithms
% You are given 3 .mat files containing data. Each file contains one
% training dataset and two testing datasets. The data are organized as
% points (x) in 2D features pace and scalar class labels y (1 or 2). With
% each of the three .mat files, do the following:
% A. Visualize the Data
% B. Perform LDA
% C. Use Random Forests
% D. Comment how well I think I would have done in predicting class lables.

%% Dataset 1, Part A: Visualizing the Data
% Plot in a subplot (2,2,1) x-training from the training datasest in the 2D
% plane. Use circles (markersize=3) to plot xtraining. Use red circles for
% points belonging to class 1 and green circles for points belonging to
% class 2.

% First, we load the data into the workspace:
load data_1.mat;

% Inspect it with whos
whos

% Now plot the raw data
% Make a figure
figure('Name', 'Dataset 1');

% Now, make a subplot
subplot(2,2,1);

% Turn on hold so we can plot multiple things
hold on;

% Plot the training data with smaller circles.

% First we need the indexes of each set by getting a true/false boolean
% array of values
train_idx_class1 = (ytraining == 1);
train_idx_class2 = (ytraining == 2);

% Now plot the training data according to the problemset:
% markersize = 3 for both
% circles for xtraining
% red circles for class 1, green circles for class 2
plot(xtraining(train_idx_class1, 1), xtraining(train_idx_class1, 2), ...
     'ro', 'MarkerSize', 3, 'DisplayName','Train: Class1');
plot(xtraining(train_idx_class2, 1), xtraining(train_idx_class2, 2), ...
     'go', 'MarkerSize', 3, 'DisplayName','Train: Class2');

% Now we need the indexes for the testing1 dataset:
test1_idx_class1 = (ytesting1 == 1);
test1_idx_class2 = (ytesting1 == 2);

% Plot these on the same subplot with bigger circles, same colors
plot(xtesting1(test1_idx_class1, 1), xtesting1(test1_idx_class1, 2), ...
    'ro', 'MarkerSize', 15, 'DisplayName', 'Test1: Class1');
plot(xtesting1(test1_idx_class2, 1), xtesting1(test1_idx_class2, 2), ...
     'go', 'MarkerSize', 15, 'DisplayName','Test1: Class2');

% Do the same thing for the test2 dataset:
test2_idx_class1 = (ytesting2 == 1);
test2_idx_class2 = (ytesting2 == 2);

% Now plot them using squares with markersize=15
plot(xtesting2(test2_idx_class1, 1), xtesting2(test2_idx_class1, 2), ...
     'rs', 'MarkerSize', 15, 'DisplayName','Test2: Class1');
plot(xtesting2(test2_idx_class2, 1), xtesting2(test2_idx_class2, 2), ...
     'gs', 'MarkerSize', 15, 'DisplayName','Test2: Class2');

% Label and Format
title('Train and Test Datasets',...
      'FontSize',12,...
      'Units','normalized',...
      'Position',[0.5,1.04,0]); 
xlabel('Feature 1','FontSize',10);
ylabel('Feature 2','FontSize',10);
axis equal;   % so the scale is the same on X & Y
legend show;  % show a legend for quick reference
hold off;

% Dataset 1, Part B: LDA
% i: Apply LDA to the training dataset and "learn: the classification
% boundary. In subplot(2,2,2), plot xtraining again as circles with
% markersize=3 but now the colors should correspond to the "learned" class
% labels (red for 1, green for 2). Compare this plot with the previous one
% and comment on how well LDA has done on this training dataset. Compute
% the accuracy (% correct) on the training dataset and report it.

% First, continue with our first figure in the second subplot
subplot(2,2,2);

% Turn hold on again so we can plot multiple things
hold on;

% Perform the training procedure. We put in our x and y training values to
% get W, a matrix of coefficients that define how each class's linear core
% is computed. We have 2 classes with 2 features and a bias term. This
% gives us 2 rows and 3 columns, so we get a 2x3 matrix!
W = LDA(xtraining, ytraining);

% Now we need to compute linear scores for our training data.
% We get a column of ones that's the size of our training dataset. This
% "augmented" matrix lets us perform an easy matrix multiplication!
XtrainAug = [ones(size(xtraining,1),1), xtraining];

% We now perform multiplication of our augmented matrix with the weights
% that are learned! We get one score per class...
Ltrain = XtrainAug * W';

% We now have our prediction on the training set, so we need to see which
% of the two classes received a higher score for each point!

% We don't really care about what each value had the max value for each
% point specifically. We just need the index of that point and what it was
% classified as.
[~, idxMaxTrain] = max(Ltrain, [], 2);    % yields 1 or 2

% We can now have our script specify the number of classes by the unique
% values found within our dataset so we don't have to hard code them. This
% acts as a map back to our original categories in the dataset!
uClasses = unique(ytraining);

% This explicitly gives us the predicted label for each row by using the
% indexes of the max training values against the unique classes
ypred_train_lda = uClasses(idxMaxTrain);

% If we want to determine the accuracy, as % correct, we need to compare
% whether the predicted labels match the training labels. We can create a
% logical comparison with == of our equally sized vectors to see if they
% match. We can then take the mean of this value which essentially adds up
% whether the label was correct or not (True for yes, which equals 1 and
% False for no, which equals zero) and divide by the total number of
% elements. We then multiply that by 100 to get a percentage correct!
acc_train_lda = mean(ypred_train_lda == ytraining)*100;

% Now if we want to test the data, we need to do the same procedure as
% before when we tested against the training data.

% First, augment the data by; ones 
Xtest1Aug = [ones(size(xtesting1,1),1), xtesting1];

% Multiply the augmented matrix by the learned LDA weights W
Ltest1 = Xtest1Aug * W';

% Get the maximum scores between each class to set which point the algorithm
% classified as what label and then map them back to our original dataset.
[~, idxMaxTest1] = max(Ltest1, [], 2);
ypred_test1_lda = uClasses(idxMaxTest1);

% Compute the accuracy of our test dataset
acc_test1_lda = mean(ypred_test1_lda == ytesting1)*100;

% Repeat this procedure for the second test set!
Xtest2Aug = [ones(size(xtesting2,1),1), xtesting2];
Ltest2 = Xtest2Aug * W';
[~, idxMaxTest2] = max(Ltest2, [], 2);
ypred_test2_lda = uClasses(idxMaxTest2);
acc_test2_lda = mean(ypred_test2_lda == ytesting2)*100;

% We can print the results in the terminal for the user to see, but they
% are reproduced in the problem set PDF
fprintf('\nLDA ACCURACY:\n');
fprintf('  Train:  %.2f%%\n', acc_train_lda);
fprintf('  Test1:  %.2f%%\n', acc_test1_lda);
fprintf('  Test2:  %.2f%%\n', acc_test2_lda);

% Finally, we need to plot the Predicted Labels
% The problem set states we need to color points by the *predicted* label. 
% - Training data: small dots, markersize=3
% - Testing1 data: circles 
% - Testing2 data: squares 
% Red = predicted class 1, Green = predicted class 2

% Training predictions plot
train_idx_pred1 = (ypred_train_lda == 1);
train_idx_pred2 = (ypred_train_lda == 2);
plot(xtraining(train_idx_pred1,1), xtraining(train_idx_pred1,2), ...
     'r.', 'MarkerSize',3, 'DisplayName','Train Pred=1');
plot(xtraining(train_idx_pred2,1), xtraining(train_idx_pred2,2), ...
     'g.', 'MarkerSize',3, 'DisplayName','Train Pred=2');

% Testing1 predictions plot
test1_idx_pred1 = (ypred_test1_lda == 1);
test1_idx_pred2 = (ypred_test1_lda == 2);
plot(xtesting1(test1_idx_pred1,1), xtesting1(test1_idx_pred1,2), ...
     'ro', 'MarkerSize',15, 'DisplayName','Test1 Pred=1');
plot(xtesting1(test1_idx_pred2,1), xtesting1(test1_idx_pred2,2), ...
     'go', 'MarkerSize',15, 'DisplayName','Test1 Pred=2');

% Testing2 predictions plot
test2_idx_pred1 = (ypred_test2_lda == 1);
test2_idx_pred2 = (ypred_test2_lda == 2);
plot(xtesting2(test2_idx_pred1,1), xtesting2(test2_idx_pred1,2), ...
     'rs', 'MarkerSize',15, 'DisplayName','Test2 Pred=1');
plot(xtesting2(test2_idx_pred2,1), xtesting2(test2_idx_pred2,2), ...
     'gs', 'MarkerSize',15, 'DisplayName','Test2 Pred=2');

% Finally, add a title, labels, and a legend
title('LDA',...
      'FontSize',12,...
      'Units','normalized',...
      'Position',[0.5,1.04,0]); 
xlabel('Feature 1', 'FontSize',10);
ylabel('Feature 2', 'FontSize',10);
legend show;
axis equal;  % so the x & y scale match
hold off;

% Dataset 1, Part C: Random Forests
% Apply RF to the same training dataset and learn the classification
% boundary. In subplot (2,2,3) plot xtraining as circles (markersize=3),
% using colors that correspond to learned class labels (red-1/green2).
% Comment on how well RF has done on the is training dataset. What is the
% accuracy (% correct)?

% Continue with the subplot
subplot(2,2,3);

% Now, we have to train our random forest:
% Number of trees (ntree), allegedly something like 500 is a common
% starting value?
ntree = 500;

% mtry is the number of features tried at each split:
% Often set to floor(sqrt(#features)) for classification.
mtry = 2;

% Train the Random forest model:
model_rf = classRF_train(xtraining, ytraining, ntree, mtry);

% Now, we can predict classification using our trained model.
ypred_train_rf = classRF_predict(xtraining, model_rf);

% Calculate the accuracy on training:
acc_train_rf = mean(ypred_train_rf == ytraining) * 100;

% Predict on the test1 dataset
ypred_test1_rf = classRF_predict(xtesting1, model_rf);

% Compute the accuracy on test1
acc_test1_rf = mean(ypred_test1_rf == ytesting1)*100;

% Predict on test 2 dataset:
ypred_test2_rf = classRF_predict(xtesting2, model_rf);

% Compute the accuracy on test2
acc_test2_rf = mean(ypred_test2_rf == ytesting2)*100;

% We can print the results in the terminal for the user to see, but they
% are reproduced in the problem set PDF
fprintf('\nRF ACCURACY:\n');
fprintf('  Train: %.2f%%\n', acc_train_rf);
fprintf('  Test1: %.2f%%\n', acc_test1_rf);
fprintf('  Test2: %.2f%%\n', acc_test2_rf);

subplot(2,2,3);
hold on;

% A) Training predictions
train_idx_pred1 = (ypred_train_rf == 1);
train_idx_pred2 = (ypred_train_rf == 2);
plot(xtraining(train_idx_pred1,1), xtraining(train_idx_pred1,2), ...
     'r.', 'MarkerSize',3);
plot(xtraining(train_idx_pred2,1), xtraining(train_idx_pred2,2), ...
     'g.', 'MarkerSize',3);

% B) Testing1 predictions
test1_idx_pred1 = (ypred_test1_rf == 1);
test1_idx_pred2 = (ypred_test1_rf == 2);
plot(xtesting1(test1_idx_pred1,1), xtesting1(test1_idx_pred1,2), ...
     'ro', 'MarkerSize',15);
plot(xtesting1(test1_idx_pred2,1), xtesting1(test1_idx_pred2,2), ...
     'go', 'MarkerSize',15);

% C) Testing2 predictions
test2_idx_pred1 = (ypred_test2_rf == 1);
test2_idx_pred2 = (ypred_test2_rf == 2);
plot(xtesting2(test2_idx_pred1,1), xtesting2(test2_idx_pred1,2), ...
     'rs', 'MarkerSize',15);
plot(xtesting2(test2_idx_pred2,1), xtesting2(test2_idx_pred2,2), ...
     'gs', 'MarkerSize',15);

title('Random Forest',...
      'FontSize',12,...
      'Units','normalized',...
      'Position',[0.5,1.04,0]);
xlabel('Feature 1');
ylabel('Feature 2');
axis equal;
legend('Train Pred=1','Train Pred=2','Test1 Pred=1', ...
    'Test1 Pred=2','Test2 Pred=1','Test2 Pred=2');
hold off;

%% Dataset 2, Part A: Visualizing the Data
% Note for grader: Doing this without just making functions is pretty
% inefficient and I recognize that. It's a lot of lines of code for no
% well justified reason. However, I don't want to split this up into
% multiple files as specified in the problem set instructions and don't
% want to just say "I did this same kind of thing for each dataset".

% Plot in a subplot (2,2,1) x-training from the training datasest in the 2D
% plane. Use circles (markersize=3) to plot xtraining. Use red circles for
% points belonging to class 1 and green circles for points belonging to
% class 2.

% Clear the workspace, terminal, and figures
close all;
clear;
clc;


% Load the data into the workspace:
load data_2.mat;

% Inspect it with whos
whos

% Now plot the raw data
% Make a figure
figure('Name', 'Dataset 2');

% Now, make a subplot
subplot(2,2,1);

% Turn on hold so we can plot multiple things
hold on;

% Plot the training data with smaller circles.

% First we need the indexes of each set by getting a true/false boolean
% array of values
train_idx_class1 = (ytraining == 1);
train_idx_class2 = (ytraining == 2);

% Now plot the training data according to the problemset:
% markersize = 3 for both
% circles for xtraining
% red circles for class 1, green circles for class 2
plot(xtraining(train_idx_class1, 1), xtraining(train_idx_class1, 2), ...
     'ro', 'MarkerSize', 3, 'DisplayName','Train: Class1');
plot(xtraining(train_idx_class2, 1), xtraining(train_idx_class2, 2), ...
     'go', 'MarkerSize', 3, 'DisplayName','Train: Class2');

% Now we need the indexes for the testing1 dataset:
test1_idx_class1 = (ytesting1 == 1);
test1_idx_class2 = (ytesting1 == 2);

% Plot these on the same subplot with bigger circles, same colors
plot(xtesting1(test1_idx_class1, 1), xtesting1(test1_idx_class1, 2), ...
    'ro', 'MarkerSize', 15, 'DisplayName', 'Test1: Class1');
plot(xtesting1(test1_idx_class2, 1), xtesting1(test1_idx_class2, 2), ...
     'go', 'MarkerSize', 15, 'DisplayName','Test1: Class2');

% Do the same thing for the test2 dataset:
test2_idx_class1 = (ytesting2 == 1);
test2_idx_class2 = (ytesting2 == 2);

% Now plot them using squares with markersize=15
plot(xtesting2(test2_idx_class1, 1), xtesting2(test2_idx_class1, 2), ...
     'rs', 'MarkerSize', 15, 'DisplayName','Test2: Class1');
plot(xtesting2(test2_idx_class2, 1), xtesting2(test2_idx_class2, 2), ...
     'gs', 'MarkerSize', 15, 'DisplayName','Test2: Class2');

% Label and Format
title('Train and Test Datasets',...
      'FontSize',12,...
      'Units','normalized',...
      'Position',[0.5,1.04,0]); 
xlabel('Feature 1','FontSize',10);
ylabel('Feature 2','FontSize',10);
axis equal;   % so the scale is the same on X & Y
legend show;  % show a legend for quick reference
hold off;

% Dataset 2, Part B: LDA
% i: Apply LDA to the training dataset and "learn: the classification
% boundary. In subplot(2,2,2), plot xtraining again as circles with
% markersize=3 but now the colors should correspond to the "learned" class
% labels (red for 1, green for 2). Compare this plot with the previous one
% and comment on how well LDA has done on this training dataset. Compute
% the accuracy (% correct) on the training dataset and report it.

% First, continue with our first figure in the second subplot
subplot(2,2,2);

% Turn hold on again so we can plot multiple things
hold on;

% Perform the training procedure. We put in our x and y training values to
% get W, a matrix of coefficients that define how each class's linear core
% is computed. We have 2 classes with 2 features and a bias term. This
% gives us 2 rows and 3 columns, so we get a 2x3 matrix!
W = LDA(xtraining, ytraining);

% Now we need to compute linear scores for our training data.
% We get a column of ones that's the size of our training dataset. This
% "augmented" matrix lets us perform an easy matrix multiplication!
XtrainAug = [ones(size(xtraining,1),1), xtraining];

% We now perform multiplication of our augmented matrix with the weights
% that are learned! We get one score per class...
Ltrain = XtrainAug * W';

% We now have our prediction on the training set, so we need to see which
% of the two classes received a higher score for each point!

% We don't really care about what each value had the max value for each
% point specifically. We just need the index of that point and what it was
% classified as.
[~, idxMaxTrain] = max(Ltrain, [], 2);    % yields 1 or 2

% We can now have our script specify the number of classes by the unique
% values found within our dataset so we don't have to hard code them. This
% acts as a map back to our original categories in the dataset!
uClasses = unique(ytraining);

% This explicitly gives us the predicted label for each row by using the
% indexes of the max training values against the unique classes
ypred_train_lda = uClasses(idxMaxTrain);

% If we want to determine the accuracy, as % correct, we need to compare
% whether the predicted labels match the training labels. We can create a
% logical comparison with == of our equally sized vectors to see if they
% match. We can then take the mean of this value which essentially adds up
% whether the label was correct or not (True for yes, which equals 1 and
% False for no, which equals zero) and divide by the total number of
% elements. We then multiply that by 100 to get a percentage correct!
acc_train_lda = mean(ypred_train_lda == ytraining)*100;

% Now if we want to test the data, we need to do the same procedure as
% before when we tested against the training data.

% First, augment the data by; ones 
Xtest1Aug = [ones(size(xtesting1,1),1), xtesting1];

% Multiply the augmented matrix by the learned LDA weights W
Ltest1 = Xtest1Aug * W';

% Get the maximum scores between each class to set which point the algorithm
% classified as what label and then map them back to our original dataset.
[~, idxMaxTest1] = max(Ltest1, [], 2);
ypred_test1_lda = uClasses(idxMaxTest1);

% Compute the accuracy of our test dataset
acc_test1_lda = mean(ypred_test1_lda == ytesting1)*100;

% Repeat this procedure for the second test set!
Xtest2Aug = [ones(size(xtesting2,1),1), xtesting2];
Ltest2 = Xtest2Aug * W';
[~, idxMaxTest2] = max(Ltest2, [], 2);
ypred_test2_lda = uClasses(idxMaxTest2);
acc_test2_lda = mean(ypred_test2_lda == ytesting2)*100;

% We can print the results in the terminal for the user to see, but they
% are reproduced in the problem set PDF
fprintf('\nLDA ACCURACY:\n');
fprintf('  Train:  %.2f%%\n', acc_train_lda);
fprintf('  Test1:  %.2f%%\n', acc_test1_lda);
fprintf('  Test2:  %.2f%%\n', acc_test2_lda);

% Finally, we need to plot the Predicted Labels
% The problem set states we need to color points by the *predicted* label. 
% - Training data: small dots, markersize=3
% - Testing1 data: circles 
% - Testing2 data: squares 
% Red = predicted class 1, Green = predicted class 2

% Training predictions plot
train_idx_pred1 = (ypred_train_lda == 1);
train_idx_pred2 = (ypred_train_lda == 2);
plot(xtraining(train_idx_pred1,1), xtraining(train_idx_pred1,2), ...
     'r.', 'MarkerSize',3, 'DisplayName','Train Pred=1');
plot(xtraining(train_idx_pred2,1), xtraining(train_idx_pred2,2), ...
     'g.', 'MarkerSize',3, 'DisplayName','Train Pred=2');

% Testing1 predictions plot
test1_idx_pred1 = (ypred_test1_lda == 1);
test1_idx_pred2 = (ypred_test1_lda == 2);
plot(xtesting1(test1_idx_pred1,1), xtesting1(test1_idx_pred1,2), ...
     'ro', 'MarkerSize',15, 'DisplayName','Test1 Pred=1');
plot(xtesting1(test1_idx_pred2,1), xtesting1(test1_idx_pred2,2), ...
     'go', 'MarkerSize',15, 'DisplayName','Test1 Pred=2');

% Testing2 predictions plot
test2_idx_pred1 = (ypred_test2_lda == 1);
test2_idx_pred2 = (ypred_test2_lda == 2);
plot(xtesting2(test2_idx_pred1,1), xtesting2(test2_idx_pred1,2), ...
     'rs', 'MarkerSize',15, 'DisplayName','Test2 Pred=1');
plot(xtesting2(test2_idx_pred2,1), xtesting2(test2_idx_pred2,2), ...
     'gs', 'MarkerSize',15, 'DisplayName','Test2 Pred=2');

% Finally, add a title, labels, and a legend
title('LDA',...
      'FontSize',12,...
      'Units','normalized',...
      'Position',[0.5,1.04,0]); 
xlabel('Feature 1', 'FontSize',10);
ylabel('Feature 2', 'FontSize',10);
legend show;
axis equal;  % so the x & y scale match
hold off;

% Dataset 2, Part C: Random Forests
% Apply RF to the same training dataset and learn the classification
% boundary. In subplot (2,2,3) plot xtraining as circles (markersize=3),
% using colors that correspond to learned class labels (red-1/green2).
% Comment on how well RF has done on the is training dataset. What is the
% accuracy (% correct)?

% Continue with the subplot
subplot(2,2,3);

% Now, we have to train our random forest:
% Number of trees (ntree), allegedly something like 500 is a common
% starting value?
ntree = 500;

% mtry is the number of features tried at each split:
% Often set to floor(sqrt(#features)) for classification.
mtry = 2;

% Train the Random forest model:
model_rf = classRF_train(xtraining, ytraining, ntree, mtry);

% Now, we can predict classification using our trained model.
ypred_train_rf = classRF_predict(xtraining, model_rf);

% Calculate the accuracy on training:
acc_train_rf = mean(ypred_train_rf == ytraining) * 100;

% Predict on the test1 dataset
ypred_test1_rf = classRF_predict(xtesting1, model_rf);

% Compute the accuracy on test1
acc_test1_rf = mean(ypred_test1_rf == ytesting1)*100;

% Predict on test 2 dataset:
ypred_test2_rf = classRF_predict(xtesting2, model_rf);

% Compute the accuracy on test2
acc_test2_rf = mean(ypred_test2_rf == ytesting2)*100;

% We can print the results in the terminal for the user to see, but they
% are reproduced in the problem set PDF
fprintf('\nRF ACCURACY:\n');
fprintf('  Train: %.2f%%\n', acc_train_rf);
fprintf('  Test1: %.2f%%\n', acc_test1_rf);
fprintf('  Test2: %.2f%%\n', acc_test2_rf);

subplot(2,2,3);
hold on;

% A) Training predictions
train_idx_pred1 = (ypred_train_rf == 1);
train_idx_pred2 = (ypred_train_rf == 2);
plot(xtraining(train_idx_pred1,1), xtraining(train_idx_pred1,2), ...
     'r.', 'MarkerSize',3);
plot(xtraining(train_idx_pred2,1), xtraining(train_idx_pred2,2), ...
     'g.', 'MarkerSize',3);

% B) Testing1 predictions
test1_idx_pred1 = (ypred_test1_rf == 1);
test1_idx_pred2 = (ypred_test1_rf == 2);
plot(xtesting1(test1_idx_pred1,1), xtesting1(test1_idx_pred1,2), ...
     'ro', 'MarkerSize',15);
plot(xtesting1(test1_idx_pred2,1), xtesting1(test1_idx_pred2,2), ...
     'go', 'MarkerSize',15);

% C) Testing2 predictions
test2_idx_pred1 = (ypred_test2_rf == 1);
test2_idx_pred2 = (ypred_test2_rf == 2);
plot(xtesting2(test2_idx_pred1,1), xtesting2(test2_idx_pred1,2), ...
     'rs', 'MarkerSize',15);
plot(xtesting2(test2_idx_pred2,1), xtesting2(test2_idx_pred2,2), ...
     'gs', 'MarkerSize',15);

title('Random Forest',...
      'FontSize',12,...
      'Units','normalized',...
      'Position',[0.5,1.04,0]);
xlabel('Feature 1'); ylabel('Feature 2');
axis equal;
legend('Train Pred=1','Train Pred=2','Test1 Pred=1', ...
    'Test1 Pred=2','Test2 Pred=1','Test2 Pred=2');
hold off;

%% Dataset 3, Part A: Visualizing the Data
% Plot in a subplot (2,2,1) x-training from the training datasest in the 2D
% plane. Use circles (markersize=3) to plot xtraining. Use red circles for
% points belonging to class 1 and green circles for points belonging to
% class 2.

% Clear the workspace, terminal, and figures
close all;
clear;
clc;


% Load the data into the workspace:
load data_3.mat;

% Inspect it with whos
whos

% Now plot the raw data
% Make a figure
figure('Name', 'Dataset 3');

% Now, make a subplot
subplot(2,2,1);

% Turn on hold so we can plot multiple things
hold on;

% Plot the training data with smaller circles.

% First we need the indexes of each set by getting a true/false boolean
% array of values
train_idx_class1 = (ytraining == 1);
train_idx_class2 = (ytraining == 2);

% Now plot the training data according to the problemset:
% markersize = 3 for both
% circles for xtraining
% red circles for class 1, green circles for class 2
plot(xtraining(train_idx_class1, 1), xtraining(train_idx_class1, 2), ...
     'ro', 'MarkerSize', 3, 'DisplayName','Train: Class1');
plot(xtraining(train_idx_class2, 1), xtraining(train_idx_class2, 2), ...
     'go', 'MarkerSize', 3, 'DisplayName','Train: Class2');

% Now we need the indexes for the testing1 dataset:
test1_idx_class1 = (ytesting1 == 1);
test1_idx_class2 = (ytesting1 == 2);

% Plot these on the same subplot with bigger circles, same colors
plot(xtesting1(test1_idx_class1, 1), xtesting1(test1_idx_class1, 2), ...
    'ro', 'MarkerSize', 15, 'DisplayName', 'Test1: Class1');
plot(xtesting1(test1_idx_class2, 1), xtesting1(test1_idx_class2, 2), ...
     'go', 'MarkerSize', 15, 'DisplayName','Test1: Class2');

% Do the same thing for the test2 dataset:
test2_idx_class1 = (ytesting2 == 1);
test2_idx_class2 = (ytesting2 == 2);

% Now plot them using squares with markersize=15
plot(xtesting2(test2_idx_class1, 1), xtesting2(test2_idx_class1, 2), ...
     'rs', 'MarkerSize', 15, 'DisplayName','Test2: Class1');
plot(xtesting2(test2_idx_class2, 1), xtesting2(test2_idx_class2, 2), ...
     'gs', 'MarkerSize', 15, 'DisplayName','Test2: Class2');

% Label and Format
title('Train and Test Datasets',...
      'FontSize',12,...
      'Units','normalized',...
      'Position',[0.5,1.04,0]); 
xlabel('Feature 1','FontSize',10);
ylabel('Feature 2','FontSize',10);
axis equal;   % so the scale is the same on X & Y
legend show;  % show a legend for quick reference
hold off;

% Dataset 3, Part B: LDA
% i: Apply LDA to the training dataset and "learn: the classification
% boundary. In subplot(2,2,2), plot xtraining again as circles with
% markersize=3 but now the colors should correspond to the "learned" class
% labels (red for 1, green for 2). Compare this plot with the previous one
% and comment on how well LDA has done on this training dataset. Compute
% the accuracy (% correct) on the training dataset and report it.

% First, continue with our first figure in the second subplot
subplot(2,2,2);

% Turn hold on again so we can plot multiple things
hold on;

% Perform the training procedure. We put in our x and y training values to
% get W, a matrix of coefficients that define how each class's linear core
% is computed. We have 2 classes with 2 features and a bias term. This
% gives us 2 rows and 3 columns, so we get a 2x3 matrix!
W = LDA(xtraining, ytraining);

% Now we need to compute linear scores for our training data.
% We get a column of ones that's the size of our training dataset. This
% "augmented" matrix lets us perform an easy matrix multiplication!
XtrainAug = [ones(size(xtraining,1),1), xtraining];

% We now perform multiplication of our augmented matrix with the weights
% that are learned! We get one score per class...
Ltrain = XtrainAug * W';

% We now have our prediction on the training set, so we need to see which
% of the two classes received a higher score for each point!

% We don't really care about what each value had the max value for each
% point specifically. We just need the index of that point and what it was
% classified as.
[~, idxMaxTrain] = max(Ltrain, [], 2);    % yields 1 or 2

% We can now have our script specify the number of classes by the unique
% values found within our dataset so we don't have to hard code them. This
% acts as a map back to our original categories in the dataset!
uClasses = unique(ytraining);

% This explicitly gives us the predicted label for each row by using the
% indexes of the max training values against the unique classes
ypred_train_lda = uClasses(idxMaxTrain);

% If we want to determine the accuracy, as % correct, we need to compare
% whether the predicted labels match the training labels. We can create a
% logical comparison with == of our equally sized vectors to see if they
% match. We can then take the mean of this value which essentially adds up
% whether the label was correct or not (True for yes, which equals 1 and
% False for no, which equals zero) and divide by the total number of
% elements. We then multiply that by 100 to get a percentage correct!
acc_train_lda = mean(ypred_train_lda == ytraining)*100;

% Now if we want to test the data, we need to do the same procedure as
% before when we tested against the training data.

% First, augment the data by; ones 
Xtest1Aug = [ones(size(xtesting1,1),1), xtesting1];

% Multiply the augmented matrix by the learned LDA weights W
Ltest1 = Xtest1Aug * W';

% Get the maximum scores between each class to set which point the algorithm
% classified as what label and then map them back to our original dataset.
[~, idxMaxTest1] = max(Ltest1, [], 2);
ypred_test1_lda = uClasses(idxMaxTest1);

% Compute the accuracy of our test dataset
acc_test1_lda = mean(ypred_test1_lda == ytesting1)*100;

% Repeat this procedure for the second test set!
Xtest2Aug = [ones(size(xtesting2,1),1), xtesting2];
Ltest2 = Xtest2Aug * W';
[~, idxMaxTest2] = max(Ltest2, [], 2);
ypred_test2_lda = uClasses(idxMaxTest2);
acc_test2_lda = mean(ypred_test2_lda == ytesting2)*100;

% We can print the results in the terminal for the user to see, but they
% are reproduced in the problem set PDF
fprintf('\nLDA ACCURACY:\n');
fprintf('  Train:  %.2f%%\n', acc_train_lda);
fprintf('  Test1:  %.2f%%\n', acc_test1_lda);
fprintf('  Test2:  %.2f%%\n', acc_test2_lda);

% Finally, we need to plot the Predicted Labels
% The problem set states we need to color points by the *predicted* label. 
% - Training data: small dots, markersize=3
% - Testing1 data: circles 
% - Testing2 data: squares 
% Red = predicted class 1, Green = predicted class 2

% Training predictions plot
train_idx_pred1 = (ypred_train_lda == 1);
train_idx_pred2 = (ypred_train_lda == 2);
plot(xtraining(train_idx_pred1,1), xtraining(train_idx_pred1,2), ...
     'r.', 'MarkerSize',3, 'DisplayName','Train Pred=1');
plot(xtraining(train_idx_pred2,1), xtraining(train_idx_pred2,2), ...
     'g.', 'MarkerSize',3, 'DisplayName','Train Pred=2');

% Testing1 predictions plot
test1_idx_pred1 = (ypred_test1_lda == 1);
test1_idx_pred2 = (ypred_test1_lda == 2);
plot(xtesting1(test1_idx_pred1,1), xtesting1(test1_idx_pred1,2), ...
     'ro', 'MarkerSize',15, 'DisplayName','Test1 Pred=1');
plot(xtesting1(test1_idx_pred2,1), xtesting1(test1_idx_pred2,2), ...
     'go', 'MarkerSize',15, 'DisplayName','Test1 Pred=2');

% Testing2 predictions plot
test2_idx_pred1 = (ypred_test2_lda == 1);
test2_idx_pred2 = (ypred_test2_lda == 2);
plot(xtesting2(test2_idx_pred1,1), xtesting2(test2_idx_pred1,2), ...
     'rs', 'MarkerSize',15, 'DisplayName','Test2 Pred=1');
plot(xtesting2(test2_idx_pred2,1), xtesting2(test2_idx_pred2,2), ...
     'gs', 'MarkerSize',15, 'DisplayName','Test2 Pred=2');

% Finally, add a title, labels, and a legend
title('LDA',...
      'FontSize',12,...
      'Units','normalized',...
      'Position',[0.5,1.04,0]); 
xlabel('Feature 1', 'FontSize',10);
ylabel('Feature 2', 'FontSize',10);
legend show;
axis equal;  % so the x & y scale match
hold off;

% Dataset 3, Part C: Random Forests
% Apply RF to the same training dataset and learn the classification
% boundary. In subplot (2,2,3) plot xtraining as circles (markersize=3),
% using colors that correspond to learned class labels (red-1/green2).
% Comment on how well RF has done on the is training dataset. What is the
% accuracy (% correct)?

% Continue with the subplot
subplot(2,2,3);

% Now, we have to train our random forest:
% Number of trees (ntree), allegedly something like 500 is a common
% starting value?
ntree = 500;

% mtry is the number of features tried at each split:
% Often set to floor(sqrt(#features)) for classification.
mtry = 2;

% Train the Random forest model:
model_rf = classRF_train(xtraining, ytraining, ntree, mtry);

% Now, we can predict classification using our trained model.
ypred_train_rf = classRF_predict(xtraining, model_rf);

% Calculate the accuracy on training:
acc_train_rf = mean(ypred_train_rf == ytraining) * 100;

% Predict on the test1 dataset
ypred_test1_rf = classRF_predict(xtesting1, model_rf);

% Compute the accuracy on test1
acc_test1_rf = mean(ypred_test1_rf == ytesting1)*100;

% Predict on test 2 dataset:
ypred_test2_rf = classRF_predict(xtesting2, model_rf);

% Compute the accuracy on test2
acc_test2_rf = mean(ypred_test2_rf == ytesting2)*100;

% We can print the results in the terminal for the user to see, but they
% are reproduced in the problem set PDF
fprintf('\nRF ACCURACY:\n');
fprintf('  Train: %.2f%%\n', acc_train_rf);
fprintf('  Test1: %.2f%%\n', acc_test1_rf);
fprintf('  Test2: %.2f%%\n', acc_test2_rf);

subplot(2,2,3);
hold on; grid on;

% A) Training predictions
train_idx_pred1 = (ypred_train_rf == 1);
train_idx_pred2 = (ypred_train_rf == 2);
plot(xtraining(train_idx_pred1,1), xtraining(train_idx_pred1,2), ...
     'r.', 'MarkerSize',3);
plot(xtraining(train_idx_pred2,1), xtraining(train_idx_pred2,2), ...
     'g.', 'MarkerSize',3);

% B) Testing1 predictions
test1_idx_pred1 = (ypred_test1_rf == 1);
test1_idx_pred2 = (ypred_test1_rf == 2);
plot(xtesting1(test1_idx_pred1,1), xtesting1(test1_idx_pred1,2), ...
     'ro', 'MarkerSize',15);
plot(xtesting1(test1_idx_pred2,1), xtesting1(test1_idx_pred2,2), ...
     'go', 'MarkerSize',15);

% C) Testing2 predictions
test2_idx_pred1 = (ypred_test2_rf == 1);
test2_idx_pred2 = (ypred_test2_rf == 2);
plot(xtesting2(test2_idx_pred1,1), xtesting2(test2_idx_pred1,2), ...
     'rs', 'MarkerSize',15);
plot(xtesting2(test2_idx_pred2,1), xtesting2(test2_idx_pred2,2), ...
     'gs', 'MarkerSize',15);

title('Random Forest',...
      'FontSize',12,...
      'Units','normalized',...
      'Position',[0.5,1.04,0]);
xlabel('Feature 1'); ylabel('Feature 2');
axis equal;
legend('Train Pred=1','Train Pred=2','Test1 Pred=1','Test1 Pred=2', ...
    'Test2 Pred=1','Test2 Pred=2');
hold off;
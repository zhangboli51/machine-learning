%% =========================================%%
%
%          there are two way to predict 
%          1st gradient descent 
%          2rd  normal equations.
%% =======================================%%


%% using gradient descent
% predict mean earning 
%read data
clear all; close all; clc

data = xlsread('FinalData.csv');
trainingData = data (2:1000,:);
testingData = data(1001:1531,:);
%traning data
TranSat = trainingData(1:999,25);
Tranage = trainingData(1:999,4);
TranFaminc = trainingData(1:999,10);
TranMdfaminc = trainingData(1:999,11);
Tranfamind = trainingData(1:999,12);

TranMnearning = trainingData(1:999,50);
TranMedearning = trainingData(1:999,51);
TranPct10 = trainingData(1:999,52);
TranPct25 = trainingData(1:999,53);
TranPct75 = trainingData(1:999,54);
TranPctstd = trainingData(1:999,55);
x =[TranSat,Tranage,TranFaminc,TranMdfaminc,Tranfamind,TranMedearning]
y = TranMnearning
m = length(y);
% testing data 
testingSat = testingData(1:531,25);
testingage = testingData(1:531,4);
testingFaminc = testingData(1:531,10);
testingMdfaminc = testingData(1:531,11);
testingfamind = testingData(1:531,12);
testingMedearning = testingData(1:531,51);
testingMnearning = testingData(1:531,50);
% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[x mu sigma] = featureNormalize(x);
% Add intercept term to X
x = [ones(m, 1) x];

fprintf('Running gradient descent ...\n');
%  alpha value
alpha = 0.000000003;
num_iters = 10000;

% Init Theta and Run Gradient Descent 
theta = zeros(7, 1);
[theta, J_history] = gradientDescentMulti(x, y, theta, alpha, num_iters);

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 3);
xlabel('Number of iterations');
ylabel('predict mean earning ');
title ( 'earning rating that we should have expected')

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');
%prediction 
A=zeros(531,1)
x_predict = [A testingSat testingage testingFaminc testingMdfaminc testingfamind testingMedearning];
% prediction
for i=2:6
    x_predict(i) = (x_predict(i) - mu(i-1)) / sigma(i-1);
end
earning = x_predict * theta;
fprintf(['Predicted earning rate' ...
         '(using gradient descent):\n $%f\n'], earning);
     fprintf('Program paused. Press enter to continue.\n');
    aa= abs(earning - testingMnearning)
    bb= aa./testingMnearning
    mean(bb)
    
   mean((earning - testingMnearning).^2 )
% pause;
%%  prediction by using normal equations.
% mean earning 

%read data
clear all; close all; clc

data = xlsread('FinalData.csv');
trainingData = data (2:1000,:);
testingData = data(1001:1531,:);
% traning data
TranSat = trainingData(1:999,25);
Tranage = trainingData(1:999,4);
TranFaminc = trainingData(1:999,10);
TranMdfaminc = trainingData(1:999,11);
Tranfamind = trainingData(1:999,12);

TranMnearning = trainingData(1:999,50);
TranMedearning = trainingData(1:999,51);
TranPct10 = trainingData(1:999,52);
TranPct25 = trainingData(1:999,53);
TranPct75 = trainingData(1:999,54);
TranPctstd = trainingData(1:999,55);
%
x =[TranSat,Tranage,TranFaminc,TranMdfaminc,Tranfamind,TranMedearning]
y = TranMnearning
m = length(y);

% testing data 
testingSat = testingData(1:531,25);
testingage = testingData(1:531,4);
testingFaminc = testingData(1:531,10);
testingMdfaminc = testingData(1:531,11);
testingfamind = testingData(1:531,12);
testingMedearning = testingData(1:531,51);
testingPct10 = testingData(1:531,52);
tesingPct25 = testingData(1:531,53);
testingPct75 = testingData(1:531,54);
testingPctstd = testingData(1:531,55);


x = [ones(m, 1) x];
fprintf('Solving with normal equations...\n');
theta = normalEqn(x, y);
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');

A=ones(531,1)
x_predict = [A testingSat testingage testingFaminc testingMdfaminc testingfamind testingMedearning];

earning = x_predict * theta;
% Q1 mean earning 
fprintf(['Predicted  ' ...
         '(using normal equations):\n $%f\n'], earning); 
         aa= abs(earning - testingMedearning)
    bb= aa./testingMnearning
    mean(bb)
%% predict Median earnings
x =[TranSat,Tranage,TranFaminc,TranMdfaminc,Tranfamind,TranMnearning]
y = TranMedearning
m = length(y);
x = [ones(m, 1) x];
fprintf('Solving with normal equations...\n');
theta = normalEqn(x, y);
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');

A=ones(531,1)
x_predict = [A testingSat testingage testingFaminc testingMdfaminc testingfamind testingMedearning];

earning = x_predict * theta;

fprintf(['Predicted Median earnings ' ...
         '(using normal equations):\n $%f\n'], earning); 
%% predict 10th percentile of earnings
x =[TranSat,Tranage,TranFaminc,TranMdfaminc,Tranfamind,TranMnearning]
y = TranPct10
m = length(y);
x = [ones(m, 1) x];
fprintf('Solving with normal equations...\n');
theta = normalEqn(x, y);
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');

A=ones(531,1)
x_predict = [A testingSat testingage testingFaminc testingMdfaminc testingfamind testingMedearning];

earning = x_predict * theta;

fprintf(['Predicted 10th percentile of earnings ' ...
         '(using normal equations):\n $%f\n'], earning); 
%% predict 25th percentile of earnings
     x =[TranSat,Tranage,TranFaminc,TranMdfaminc,Tranfamind,TranMnearning]
y = TranPct25
m = length(y);
x = [ones(m, 1) x];
fprintf('Solving with normal equations...\n');
theta = normalEqn(x, y);
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');

A=ones(531,1)
x_predict = [A testingSat testingage testingFaminc testingMdfaminc testingfamind testingMedearning];

earning = x_predict * theta;

fprintf(['Predicted 25th percentile of earnings ' ...
         '(using normal equations):\n $%f\n'], earning); 
%% predict 75th percentile of earnings
     x =[TranSat,Tranage,TranFaminc,TranMdfaminc,Tranfamind,TranMnearning]
y = TranPct25
m = length(y);
x = [ones(m, 1) x];
fprintf('Solving with normal equations...\n');
theta = normalEqn(x, y);
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');

A=ones(531,1)
x_predict = [A testingSat testingage testingFaminc testingMdfaminc testingfamind testingMedearning];

earning = x_predict * theta;

fprintf(['Predicted 75th percentile of earnings ' ...
         '(using normal equations):\n $%f\n'], earning); 
%% predict STD percentile of earnings
% if you want to add more training data and testing data 
clear all; close all; clc

data = xlsread('FinalData.csv');
trainingData = data (2:1000,:);
testingData = data(1001:1531,:);
Tranage = trainingData(1:999,4);
testingSat = testingData(1:531,25);
TranFaminc = trainingData(1:999,10);
TranMnearning = trainingData(1:999,50);
TranMdfaminc = trainingData(1:999,11);
Tranfamind = trainingData(1:999,12);
TranSat = trainingData(1:999,25);
TranPct10 = trainingData(1:999,52);
TranPct25 = trainingData(1:999,53);
TranPct75 = trainingData(1:999,54);
TranPctstd = trainingData(1:999,55);
testingSat = testingData(1:531,25);
testingage = testingData(1:531,4);
testingFaminc = testingData(1:531,10);
testingMdfaminc = testingData(1:531,11);
testingfamind = testingData(1:531,12);
testingMedearning = testingData(1:531,51);
testingMnearning = testingData(1:531,50);
testingPct10 = testingData(1:531,52);
tesingPct25 = testingData(1:531,53);
testingPct75 = testingData(1:531,54);
testingPctstd = testingData(1:531,55);

x =[TranSat,Tranage,TranFaminc,TranMdfaminc,Tranfamind,TranMnearning,TranPct10,TranPct25,TranPct75]
y = TranPctstd
m = length(y);
x = [ones(m, 1) x];
fprintf('Solving with normal equations...\n');
theta = normalEqn(x, y);
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');

A=ones(531,1)
x_predict = [A testingSat testingage testingFaminc testingMdfaminc testingfamind testingMedearning,testingPct10,tesingPct25,testingPct75];

earning = x_predict * theta;

fprintf(['Predicted Standard deviation of earnings  ' ...
         '(using normal equations):\n $%f\n'], earning); 
    aa= abs(earning - testingPctstd)
    bb= aa./testingPctstd
    mean(bb)

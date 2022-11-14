tic; clear; close all; clc; addpath(genpath(pwd));   
load aggregation 
k = 10; tau = 0.6; c = 7;
Result = LGD(X,k,tau,c);
ACC = acc(Y, Result);


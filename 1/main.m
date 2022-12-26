tic; clear; close all; clc; addpath(genpath(pwd));   
load flame 
k = 10; tau = 0.6; c = 2;
Result = LGD(X,k,tau,c);
ACC = acc(Y, Result);


tic; clear; close all; clc; addpath(genpath(pwd));   
load aggregation 
k = 30; eps = 0;
[Distance,matV,matID] = SortDistance(X,X); 
kNN = SparseGraph(Distance,matID,k); 
[D,T,r] = DivideData(kNN,matV,k,eps);
Result = Cluster(kNN,D,T,r); 
FM  = fmeasure(Y, Result);


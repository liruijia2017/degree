tic; clear; close all; clc; addpath(genpath(pwd));   
load aggregation 
k = 10; tau = 0.6; c = 7; 
D = EuclideanD(X,X);
[~,D_ID] = sort(D,2); 
[~,~,W] = SparseGraph(D,D_ID,k); 
[LD,MLDP] = LocalDensity(W); 
[SC,SM,DDC] = ChainSet(X,MLDP,LD,W); 
[BPS,CP] = BorderPoint(SC,MLDP,LD,tau);  
[PartLabel,subClusterID] = InitialSubCluster(W,SM,DDC,MLDP,BPS);  
Result = FinalCluster(D,DDC,PartLabel,SM,subClusterID,MLDP,c);
ACC = acc(Y, Result);








tic; clear; close all; clc; addpath(genpath(pwd));   
load aggregation 
N = round(sqrt(length(Y))); tau = 0.6; i = 2; c = 7;
[LabelGroup,ExistGroup,centers,radius,numG] = Group(X,i*N); 
[DisGroup,LD,SD,WkNN] = Denseness(X,LabelGroup,ExistGroup,centers,radius,numG,10); 
GroupID = LabelnonOutlierGroup(c,LD,SD,WkNN,tau,numG);
GroupID = LabelOutlierGroup(GroupID,LD,SD,DisGroup);
Label = LabelData(GroupID,LabelGroup,ExistGroup); 
ACC = acc(Y, Label');


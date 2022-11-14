function labels = LGD(X,k,tau,c)

% Written by Ruijia Li (ruijia2017@163.com), Lab of GRC & AI, 1 July 2018.

%% Input
% X: data matrix (numSamp x dimSamp, dimSamp is the dimension)
% k: the number of the neighbors in kNN graph
% tau: the threshold
% Figure: show the figure? 0 or 1
% c: the number of the clusters. 

%% Output
% labels: clustering labels

%% If the number of clusters is not entered,
% we need to enter it during the clustering process.
if nargin < 4
    c = 0;
end;

numSamp= size(X,1);

% the square of the Euclidean distance of the pairwise points of the data
D = EuclideanD2(X,X);

%% build kNNGraph
W = kNNGraph(D,numSamp,k);

%% detect core points and border points
[CorePoints,BorderPoints,LocalGapDensity] = DetectPionts(numSamp,tau,W);

%% delete the cross-cluster edges
W_new = TheNewGraph(W,BorderPoints,CorePoints);

%% count the components of the graph with the weight W_new
[Components,~] = Net_Branches(W_new);

%% choose the number of clusters if need be

if c == 0
    c = numClusters(Components,BorderPoints);
end;

%% label subcluster
TempLabels = LabelSubclusters(numSamp,Components,CorePoints,c);

%% assign each unlabeled point to the extant subcluster
labels = AssignUnlabeledPoints(numSamp,LocalGapDensity,W,TempLabels,D);

end

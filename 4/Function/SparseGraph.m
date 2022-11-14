function kNN = SparseGraph(Distance,matID,k)
%% Input
% X: data matrix (numSamp x dimSamp, dimSamp is the dimension)
% k: k nearest neighbors;
%% Output
% WMkNN: weighted adjacency matrix of the mutual k-NN graph
n = size(Distance,1);
kNN = zeros(n);
for i = 1:n
    id = matID(i,2:k+1);
    kNN(i,id) = Distance(i,id);
end








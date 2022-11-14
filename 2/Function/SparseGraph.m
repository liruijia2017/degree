function [WDkNN,WkNN,WMkNN] = SparseGraph(D,D_ID,k)
n = size(D_ID,1);
%% Three Sparse Graphs
WDkNN = zeros(n);
for i = 1:n
    id = D_ID(i,2:k+1);
    WDkNN(i,id) = D(i,id);
end
WkNN = max(WDkNN,WDkNN'); 
WMkNN = min(WDkNN,WDkNN');

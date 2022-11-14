function [WDkNN,WkNN,WMkNN] = SparseGraph(D,Ind,k)
n = size(Ind,1);
%% Three Sparse Graphs
WDkNN = zeros(n);
for i = 1:n
    id = Ind(i,2:k+1);
    WDkNN(i,id) = D(i,id);
end
WkNN = max(WDkNN,WDkNN'); 
WMkNN = min(WDkNN,WDkNN');

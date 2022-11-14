function [SC,SM,DensityDecayChain] = ChainSet(X,MLDP,LD,W)
n = size(X,1); m = length(MLDP);

%% Density Decay Chain
matLD1 = repmat(LD',[n,1]);
matLD2 = matLD1';
DensityDecayChain = matLD1 < matLD2;
DensityDecayChain = DensityDecayChain .* double(W ~= 0);

%% Point set from the same starting point chain 
SC = cell(1,m); SM = zeros(n,m);
for i = 1:m
    SC{1,i} = MLDP(i);
    NewPoint = SC{1,i};
    while ~isempty(NewPoint) 
        LatentSubG = DensityDecayChain(NewPoint,:);
        TempSubCluster = find(max(LatentSubG,[],1) == 1);
        NewPoint = setdiff(TempSubCluster,SC{1,i});
        SC{1,i} = [SC{1,i},NewPoint];
    end  
   SM(SC{1,i},i) = 1;
end

  

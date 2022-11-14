function GroupID = LabelnonOutlierGroup(c,LD,SD,WkNN,tau,numG)
N = length(numG); e = 0.00000001;
%% Norm LD
MaxV = repmat(max(LD,[],2),[1,N]);
NLD = LD ./ MaxV;
NLD(MaxV == 0) = 0;

SDkNN = repmat(SD',[N,1]) .* double(WkNN ~=0 );
SubCluster = cell(1,N);
[MaxValue,TempMaxID] = max(SD);
i = 0;
SDTemp = SD;

TempMaxValue = MaxValue;
GroupID = zeros(N,1);
%while MaxValue > TempMaxValue*tau && i < c
while i < c
    TempMaxValue = MaxValue;
    i = i+1;
    SubCluster{1,i} = TempMaxID;
    SD(SubCluster{1,i},1) = 0;
    Len = length(SubCluster{1,i}); 
    LenTemp = 0;
    while Len ~= LenTemp 
        LenTemp = Len;
        TranSubG = SubCluster{1,i};
        NSubG = SDkNN(TranSubG,:);
        SDSubG = SDTemp(SubCluster{1,i},1);
        MaxV = repmat(SDSubG,[1,N]);
        LatentSubG1 = min(MaxV,NSubG) ./ (max(MaxV,NSubG)+e);
        TempSubCluster1 = find(max(LatentSubG1,[],1) > tau);
        LatentSubG2 = NLD(TranSubG,:);
        TempSubCluster2 = find(max(LatentSubG2,[],1) > tau);
        TempSubCluster = intersect(TempSubCluster1,TempSubCluster2);
        SubCluster{1,i} = union(SubCluster{1,i},TempSubCluster);
        Len = length(SubCluster{1,i}); 
        %Labels = LabelData(SubCluster,labels); FigureClusterNoise(X,Labels);
    end
    GroupID(SubCluster{1,i}) = i;
    
    SD(SubCluster{1,i},1) = 0;
    NLD(SubCluster{1,i},:) = 0;
    NLD(:,SubCluster{1,i}) = 0;
    [MaxValue,TempMaxID] = max(SD);
    %Labels = LabelData(SubCluster,labels); FigureClusterNoise(X,Labels);
end
  

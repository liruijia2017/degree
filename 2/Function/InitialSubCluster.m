function [PartLabel,subClusterID] = InitialSubCluster(W,SM,DDC,MLDP,BorderPoint)
NewW = W; m = length(MLDP); n = size(W,1); E = 1000000;
%% The core points connecting the border points (UnstableCorePoint)
NewW(:,BorderPoint) = 0;
NewW(BorderPoint,:) = 0;
TempW = W - NewW;
C = max(TempW);
C = find(C==0);
CorePoint = setdiff((1:size(W,1)),BorderPoint);
UnstableCorePoint = setdiff(CorePoint, C);

%% The threshold of unreachable density (Threshold)
N = length(UnstableCorePoint); Threshold = ones(1,n) * E;
for i = 1:N
    Xi = UnstableCorePoint(1,i);
    Cut_ID = TempW(Xi,:);
    Threshold(1,Xi) = min(nonzeros(Cut_ID));
end
ThresholdMat = repmat(Threshold,[n,1]);
ThresholdMat = max(ThresholdMat,ThresholdMat');

One = sum(SM(CorePoint,:),2);
Only = CorePoint(One == 1);
ThresholdMat(Only,Only) = E;
DDCandW  = (1-DDC)*E + W;
%% Initial subclusters with respect to the $m$ starting points.
DDC(:,BorderPoint) = 0; DDC(BorderPoint,:) = 0;
ISC = cell(1,m); 
for i = 1:m
    ISC{1,i} = MLDP(i);
    NewPoint = MLDP(i); 
    while ~isempty(NewPoint)      
        LatentSubG = DDC(NewPoint,:);
        TempSubCluster = find(max(LatentSubG,[],1) == 1);
        ThresholdNewPoint = ThresholdMat(NewPoint,TempSubCluster);
        WeightNewPoint = DDCandW(NewPoint,TempSubCluster);
        Condition =  double(WeightNewPoint < ThresholdNewPoint);
        ID = max(Condition,[],1) == 1;
        NewPointTemp = TempSubCluster(ID);    
        NewPoint = setdiff(NewPointTemp,ISC{1,i});
        ISC{1,i} = [ISC{1,i},NewPoint];
    end  
end

%% Initial SubClusters
MatC = zeros(m);
for i = 1:m
    for j = i+1:m
        L0 = length(unique([ISC{1,i},ISC{1,j}]));
        L1 = length(ISC{1,i});
        L2 = length(ISC{1,j});
        L = L0 - L1 - L2;
        if L
           MatC(i,j) = 1; 
        end
    end
end
MatC = max(MatC,MatC');   
[Component,~] = Net_Branches(MatC);

%% Label the initial subclusters
N = size(Component,1); PartLabel = zeros(n,1); subClusterID = zeros(1,m);
for i = 1:N
    TempC = nonzeros(Component(i,:));
    L = length(TempC);
    for j = 1:L
        subCluster = ISC{1,TempC(j,1)};
        PartLabel(subCluster,1) = i;
    end
    subClusterID(TempC) = i;
end





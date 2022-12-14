function Label = FinalCluster(D,DDC,PartLabel,SM,subClusterID,MLDP,c)
N = max(PartLabel);
%%
if nargin == 6
    c = N;
end;

%% Label the remaining points
UnLabelPoint = find(PartLabel==0);
li = length(UnLabelPoint);
while li
    TDDC = DDC';
    TDDC(:,UnLabelPoint) = 0;
    m = length(UnLabelPoint);
    for i = 1:m
        Xi = UnLabelPoint(i);
        XiChain = find(TDDC(Xi,:)==1);
        if  ~isempty(XiChain)
            XiD = D(Xi,XiChain);
            [~,ID] = min(XiD);
            FollowID = XiChain(ID);
            PartLabel(Xi) = PartLabel(FollowID);
        end
    end
    UnLabelPoint = find(PartLabel==0);
    li = length(UnLabelPoint);
end

%% Find the nearest MLDP for the unlabel SC
numPoints = zeros(1,N);
if c < N
   for i = 1:N
    numPoints(1,i) = sum(PartLabel==i);
   end
   [~, numPointsID] = sort(numPoints,'descend');
   
   PartLabelTemp = PartLabel; LabelSM = SM; J = zeros(c,N-c);
   TempNumPoints = (c+1:N);
   for i = 1:c
       TempID = subClusterID==numPointsID(i);
       for j = 1:N-c
           jPartLabel = PartLabelTemp==numPointsID(j+c);
           jLabelSM = LabelSM(jPartLabel,:);
           jSum = sum(jLabelSM,1);
           J(i,j) = jSum * (TempID)';
       end
   end
   maxJ = max(max(J)); NewsubClusterID = subClusterID;
   while maxJ~=0  
       [rowM,TempColM] = find(J==maxJ);
       row = rowM(1);
       TempCol = TempColM(1);
       Col = TempNumPoints(TempCol);
       TempNumPoints(TempCol) = [];
       J(:,TempCol) = [];
       ColPartLabel = find(PartLabelTemp==numPointsID(Col));
       PartLabel(ColPartLabel) = numPointsID(row);
       ColLabelSM = LabelSM(ColPartLabel,:);
       ColSum = sum(ColLabelSM,1);
       M = zeros(1,length(TempNumPoints));
       for m = 1:length(TempNumPoints)
          mm = TempNumPoints(m);
          TempID = subClusterID==numPointsID(mm); 
          M(m) = ColSum * (TempID)'; 
       end 
       J(row,:) = J(row,:)+M; 
       maxJ = max(max(J)); 
       NewID = subClusterID == numPointsID(Col);
       NewsubClusterID(NewID) = numPointsID(row);
   end  
   
   if ~isempty(TempNumPoints) 
       for p = 1:length(TempNumPoints)
           pp = TempNumPoints(p);
           iPartLabel = PartLabelTemp==numPointsID(pp);
           MLDP_i = subClusterID==numPointsID(pp);
           ListD = zeros(1,c);
           for g = 1:c
              MLDP_j = NewsubClusterID==numPointsID(g);
              MLDP_D = D(MLDP(MLDP_i),MLDP(MLDP_j));
              [Min_V,~] = min(min(MLDP_D));
              ListD(g) = Min_V;
           end
           [~,ID] = min(ListD); 
           PartLabel(iPartLabel) = numPointsID(ID); 
       end
   end
       
       
end 

%% Organize labels
ID = unique(nonzeros(PartLabel));
cc = min(length(ID),c);
for i = 1:cc
    PartLabel(PartLabel==ID(i)) = i;
end
Label = PartLabel;
    

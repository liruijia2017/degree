function Label = JDC(X,N,k,tau)
%% Group
[LabelGroup,centers,radius,numG] = Group(X,N); 

%% Junction density
[DisGroup,LD,SD,WkNN] = Denseness(X,LabelGroup,centers,radius,numG,k); 

%% Cluster nonOutlierGroup
GroupID = LabelnonOutlierGroup(LD,SD,WkNN,tau,numG);

%% Cluster outlierGroup
GroupID = LabelOutlierGroup(GroupID,LD,SD,DisGroup);

%% Cluster data
Label = LabelData(GroupID,LabelGroup); FigureClusterNoise(X,Label,[])


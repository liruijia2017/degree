function [LabelGroup,ExistGroup,centers,radius,numG] = Group(X,N)
[numSamp,Dim]=size(X); %rand('seed',Seed);
centers=X(randperm(numSamp,N),:);
for i = 1:5
    distMatrix=EuclideanDXY(centers,X);  
    [~, LabelGroup]=min(distMatrix);
    ExistGroup = unique(LabelGroup);
    N = length(ExistGroup);
    centersTemp = zeros(N,Dim);
    numG = zeros(N,1);
    for j=1:N
        subX=X(LabelGroup==ExistGroup(j),:);    
        numG(j,:) = size(subX,1);
        centersTemp2 = mean(subX,1); 
        Dtemp=EuclideanDXY(centersTemp2,subX); 
        [~,id] = min(Dtemp);
        centersTemp(j,:) = subX(id,:); 
    end
    centers = centersTemp;
end
radius = zeros(N,1); 
for i=1:N
    subX=X(LabelGroup==ExistGroup(i),:);
    Dtemp=EuclideanDXY(centers(i,:),subX); 
    radius(i,:) = max(Dtemp);
end


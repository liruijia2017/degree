function [WLink,D] = kNNGraph(radius,centers,k)
numR=size(centers,1); WkNN = zeros(numR);
D = EuclideanD(centers,centers);
[~,DRepID] = sort(D);
for i = 1:numR
    WkNN(i, DRepID(2:k+1,i)) = D(i,DRepID(2:k+1,i));
end
% WkNN = min(WkNN,WkNN');
TempD = D;
RepRadius1 = repmat(radius,[1,numR]);
RepRadius2 = RepRadius1';
MinRepRadius = min(RepRadius1,RepRadius2);
RepRadius = RepRadius1+RepRadius2+MinRepRadius;
TempD(TempD>RepRadius) = 0;
WLink = min(TempD,WkNN);






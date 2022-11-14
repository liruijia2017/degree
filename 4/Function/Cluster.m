function Label = Cluster(kNN,D,T,r)
N = size(D,1); n = size(kNN,1); 
%% The transitive distance
Threshold = r(D);
ThresholdMat = repmat(Threshold,[1,N]);
ThresholdMat = min(ThresholdMat,ThresholdMat');

%% Mining clusters in transitive points
remainingD = (1:N); 
kNND = kNN;
kNND(T,:) = [];
kNND(:,T) = [];
kNND(kNND==0) = max(r)+1;

c = 0; IC = cell(1,N); 
while ~isempty(remainingD)  
    c = c+1;
    [~,ID] = min(r(remainingD));
    IC{1,c} = remainingD(ID); 
    NewPoint = IC{1,c}; 
    while ~isempty(NewPoint)   
        ThresholdNewPoint = ThresholdMat(NewPoint,:);
        Threshold = max(ThresholdNewPoint,[],1);
        temp = min(kNND(NewPoint,:),[],1);
        candidate = find(temp < Threshold);
        NewPoint = setdiff(candidate,IC{1,c});
        IC{1,c} = [IC{1,c},NewPoint];
    end
    remainingD = setdiff(remainingD,IC{1,c});
end

%% Label the initial clusters
Label = zeros(n,1); 
for i = 1:c
    Label(D(IC{1,i},1)) = i;
end

%% Label the remaining points
kNNDT = kNN(D,T);
kNNDT(kNNDT==0) = max(r)+1;
len = length(T);
if ~isempty(D)  
    for i = 1:len
        temp = kNNDT(:,i)';
        ca = temp < Threshold;
        candidate = find(ca~=0);
        if ~isempty(candidate)   
            [~,id] = min(temp(candidate));
            labeled=D(candidate(id));
            Label(T(i))=Label(labeled);
        end
    end
end




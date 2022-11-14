function GroupID = LabelOutlierGroup(GroupID,LD,SD,D)
unLabeledPoints = find(GroupID == 0); % find the unlabeled Group
LabeledPoints = find(GroupID ~= 0);   % find the labeled Group

S = SuccessivePoint(LD,SD,unLabeledPoints); 

Chain = S(unLabeledPoints);
last = zeros(1,length(Chain));
while any(Chain ~= last)
    last = Chain;
    Chain = S(Chain);
end

% find the the representative point 
R_Uniq = unique(Chain);
R_Uniq_Lab = GroupID(R_Uniq);
ID_S_Uniq = R_Uniq_Lab == 0;          
R_itself = R_Uniq(ID_S_Uniq);       

DR_T = D(R_itself,LabeledPoints);  % the nearest labeled points 
[~,ID_Nearest] = sort(DR_T,2);

% assign the unlabeled points to subclusters
LabelR_itself = [];
if size(ID_Nearest,2) ~= 0
    LabelR_itself = [R_itself',GroupID(LabeledPoints(ID_Nearest(:,1)))];
end
for i = 1:size(LabelR_itself,1)
    GroupID(LabelR_itself(i,1)) = LabelR_itself(i,2);
end

% tidy up the label
LabelOne = [LabeledPoints,GroupID(LabeledPoints)];
LabelTwo = [unLabeledPoints,GroupID(Chain)];
LabelAll = [LabelOne;LabelTwo];

LabelAll = sortrows(LabelAll,1);
GroupID = LabelAll(:,2);
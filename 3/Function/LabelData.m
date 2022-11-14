function Labels = LabelData(GroupID,LabelGroup,ExistGroup)
n = size(LabelGroup,2);
Labels = zeros(1,n);
numC = max(GroupID);
for i = 1:numC
    C = find(GroupID==i);
    numsubC = length(C);
    for j = 1:numsubC
        tempj = C(j);
        CTemp = LabelGroup==ExistGroup(tempj);
        Labels(CTemp) = i;
    end
end

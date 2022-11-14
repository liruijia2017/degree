function [BPS,CP] = BorderPoint(SC,MLDP,LD,tau)
m = length(SC); 
%% Border Point Set and Core Points
MLD = LD(MLDP);
CP = cell(1,m); BPS = [];
for i = 1:m
    Border = SC{1,i};
    Border(LD(Border) > tau * MLD(i)) = [];
    CP{1,i} = setdiff(SC{1,i},Border);
    BPS = [BPS,Border];
end
BPS = unique(BPS);

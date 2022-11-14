function [LD,MLDP] = LocalDensity(W)
n = size(W,1); e = 0.000001; 
%% Local density
NonWID = (W ~= 0);
numLink = sum(NonWID,2);
weightLink = sum(W,2); 
TempLD = numLink ./ (weightLink+e);
LD = numLink .* TempLD;

%% Maximum Local Density Point
matLD = repmat(LD',[n,1]);
matLDNowW = matLD .* NonWID;
MaxLD = max(matLDNowW,[],2);
MLDP = find(LD >= MaxLD);








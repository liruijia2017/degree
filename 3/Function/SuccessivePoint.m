function S = SuccessivePoint(LD,SD,unLabeledPoints)
n = length(SD);
S = (1:n);
L_N = length(unLabeledPoints);

for i = 1:L_N
    
    % find the successive point of each unlabeled point
    i_N = unLabeledPoints(i);
    [W_V,W_ID] = sort(LD(i_N,:),'descend');
    W_ID_Non = W_V ~= 0;
    W_min = W_ID(W_ID_Non);
    LinkValue = SD(W_min)';
    high_ID = find(LinkValue > SD(i_N), 1, 'first');
    
    if(~isempty(high_ID))
        S(1,i_N) = W_min(1,high_ID);
    else
        S(1,i_N) = i_N;
    end
end

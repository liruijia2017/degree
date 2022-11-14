function [Distance,matV,matID] = SortDistance(a,b)
% a,b: two matrices; each row is a data
% d:   distance matrix of a and b
a = a'; b = b';

if (size(a,1) == 1)
    a = [a; zeros(1,size(a,2))];
    b = [b; zeros(1,size(b,2))];
end

aa=sum(a.*a); bb=sum(b.*b); ab=a'*b;
Distance = repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab;

Distance = real(Distance);
Distance = sqrt(Distance);
Distance = max(Distance,0);
Distance = Distance.*(1-eye(size(Distance))); % force 0 on the diagonal
[matV,matID] = sort(Distance,2); 


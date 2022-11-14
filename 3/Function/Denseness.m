function [DisGroup,LD,SD,WkNN]= Denseness(X,LabelGroup,ExistGroup,centers,radius,numG,k)
numR = length(numG); 
SD = zeros(numR,1); Mean = zeros(numR,1);
[WkNN,DisGroup] = kNNGraph(radius,centers,k); %FigurekNN(X,centers,WkNN,numG)
MaxWkNN = max(WkNN,WkNN'); TrueW = (WkNN~=0); LD = zeros(numR); 
%% LD
for i = 1:numR
    for j = i:numR
        if i==j && numG(i,1) > 1
           Xi = X(LabelGroup==ExistGroup(i),:);
           DTemp = EuclideanD(Xi,Xi);
           Vaule = sum(sum(DTemp));
           Num = numG(i,1)*numG(i,1);
           Mean(i,1) = Vaule/Num;
           SD(i,1) = 2*numG(i,1)/(Mean(i,1)); 
        end
        
        if  MaxWkNN(i,j)
            DTemp = EuclideanDXY(X(LabelGroup==ExistGroup(i),:),X(LabelGroup==ExistGroup(j),:));
            R1 = radius(i,1);
            R2 = radius(j,1);
            R = min(R1,R2);
            [row,~] = find(DTemp <= R);
            [~,col] = find(DTemp <= R);
            row = unique(row);
            col = unique(col);
            Vaule = sum(sum(DTemp(row,col))); 
            NumLink = length(row)*length(col);
            MeanTemp = Vaule/(NumLink); 
            Num = length(row)+length(col);           
            if TrueW(i,j)
               if MeanTemp~=0 && NumLink~=0; LD(i,j) = (Num)/(MeanTemp); end
            end
            
            if TrueW(j,i)
               if MeanTemp~=0 && NumLink~=0; LD(j,i) = (Num)/(MeanTemp); end                              
            end
        end
    end
end



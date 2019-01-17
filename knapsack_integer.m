function [best amount] = knapsack_integer(weights,values,W)
weights = weights(:)';
values = values(:)';
maxa = floor(W./weights);


A = zeros(W+1,length(weights)+1);

% Backtrack
for i = length(weights):-1:1
    for Y = 1:W
        temp = zeros(maxa(i),1)';
        for k = 1:maxa(i)
            if weights(i)*k > Y
                temp(k) = 0;
            else
                temp(k) = values(i)*k + A(Y-(weights(i)*k)+1,i+1);
            end
        end
        A(Y+1,i) = max([A(Y+1,i+1), temp]);
    end
end

best = A(end,1);

% Go forward
amount = zeros(1,length(weights));
a = best;
j = 1; 
Y = W;

while a > 0
    while A(Y+1,j+1) == a
           j = j + 1;
    end
    temp = zeros(maxa(j),1)';
    for k = 1:maxa(j)
        if weights(j)*k > Y
             temp(k) = 0;
        else
             temp(k) = values(j)*k + A(Y-(weights(j)*k)+1,j+1);
        end
    end
    amount(j) = find(temp == max(temp));
    Y = Y - weights(j)*amount(j);
    j = j + 1;
    a = A(Y+1,j);
end
end




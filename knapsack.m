function [best amount] = knapsack(weights,values,W)

weights = weights(:)';
values = values(:)';

A = zeros(W+1,length(weights)+1);

% Backtrack
for i = length(weights):-1:1
    for Y = 1:W
        if weights(i) > Y
            A(Y+1,i) = A(Y+1,i+1);
        else A(Y+1,i) = max( A(Y+1,i+1),... 
            values(i) + A(Y-weights(i)+1,i+1));
        end
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
    amount(j) = 1;
    Y = Y - weights(j);
    j = j + 1;
    a = A(Y+1,j);
end

end

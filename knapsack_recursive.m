W = 20;                       % Knapsack capacity
w = [2, 3, 4, 5, 9, 7, 8, 10]; % Array of item weights
v = [5, 8, 10, 12, 6, 14, 7, 9]; % Array of item values

n = length(v);

[V, selected] = knapsack(v, w, W, n);
disp(V);
disp(selected);
selected*w'
selected*v'
x = vpa(binaryToDecimal(selected))
function [V, selected] = knapsack(v, w, W, n)
    if n == 0
        V = 0;
        selected = zeros(1, length(w));
    elseif w(n) > W
        [V, selected] = knapsack(v, w, W, n-1);
    else
        [V1, selected1] = knapsack(v, w, W - w(n), n-1);
        [V2, selected2] = knapsack(v, w, W, n-1);
        
        if v(n) + V1 > V2
            V = v(n) + V1;
            selected = selected1;
            selected(n) = 1;
        else
            V = V2;
            selected = selected2;
        end
    end
end

function decimalNumber = binaryToDecimal(binaryArray)
    n = numel(binaryArray);
    decimalNumber = 0;
    
    for i = 1:n
        decimalNumber = decimalNumber + binaryArray(i) * 2^(n-i);
    end
end
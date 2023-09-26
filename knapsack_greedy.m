% Knapsack Monodimensional Problem - Greedy Solution (Martello and Toth Algorithm)
clc
clear
close
tic
% Input data
% weights = [7, 0, 30, 22, 80, 94, 11, 81, 70, 64, 59, 18, 0, 36, 3, 8, 15, 42, 9, 0, 42, 47, 52, 32, 26, 48, 55, 6, 29, 84, 2, 4, 18, 56, 7, 29, 93, 44, 71, 3, 86, 66, 31, 65, 0, 79, 20, 65, 52, 13];  % Array of item weights
% values = [360, 83, 59, 130, 431, 67, 230, 52, 93, 125, 670, 892, 600, 38, 48, 147, 78, 256, 63, 17, 120, 164, 432, 35, 92, 110, 22, 42, 50, 323, 514, 28, 87, 73, 78, 15, 26,78, 210, 36, 85, 189, 274, 43, 33, 10, 19, 389, 276, 312]; % Array of item values
% capacity = 850; % Knapsack capacity

weights = [2, 3, 4, 5, 9, 7, 8, 10];
values = [5, 8, 10, 12, 6, 14, 7, 9];
capacity = 20;


% Compute value-to-weight ratio
valuePerWeight = values ./ weights;

% Sort items in descending order based on value-to-weight ratio
[sortedRatio, itemIndices] = sort(valuePerWeight, 'descend');

% Initialize variables
selectedItems = zeros(size(weights));
totalValue = 0;
currentWeight = 0;

% Greedy selection of items
for i = 1:length(weights)
    currentItemIndex = itemIndices(i);
    if (currentWeight + weights(currentItemIndex)) <= capacity
        selectedItems(currentItemIndex) = 1;
        totalValue = totalValue + values(currentItemIndex);
        currentWeight = currentWeight + weights(currentItemIndex);
    end
end

% Display results
disp('Selected items:');
disp(selectedItems);
disp('Total value:');
disp(totalValue);
toc
weig = weights*selectedItems';
x = vpa(binaryToDecimal(selectedItems));


function decimalNumber = binaryToDecimal(binaryArray)
    n = numel(binaryArray);
    decimalNumber = 0;
    
    for i = 1:n
        decimalNumber = decimalNumber + binaryArray(i) * 2^(n-i);
    end
end
clear
clc

% Input parameters
rectangles = [10 20; 300 300; 30 40; 50 60]; % dimensions of rectangles
binWidth = 100; % width of the bin
binHeight = 200; % height of the bin

% Initialize the bin
bin = zeros(binHeight, binWidth);

% Sort the rectangles by area (largest first)
[~, idx] = sort(prod(rectangles, 2), 'descend');
rectangles = rectangles(idx, :);

% Pack the rectangles
positions = zeros(size(rectangles));
i = 1;
while i <= size(rectangles, 1)
    [x, y] = findEmptySpace(bin, rectangles(i, 1), rectangles(i, 2));
    if isempty(x) % if no empty space found, remove rectangle from the list
        rectangles(i, :) = [];
    else % otherwise, place the rectangle in the bin and move to the next rectangle
        positions(i, :) = [x, y];
        bin(y:y+rectangles(i, 2)-1, x:x+rectangles(i, 1)-1) = i;
        i = i + 1;
    end
end

% Plot the result
figure;
hold on;
for i = 1:size(rectangles, 1)
    color = rand(1, 3); % generate a random RGB color
    rectangle('Position', [positions(i, 1), positions(i, 2), rectangles(i, 1), rectangles(i, 2)], 'FaceColor', color);
    text(positions(i,1)+rectangles(i,1)/2, positions(i,2)+rectangles(i,2)/2, num2str(idx(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
end
rectangle('Position', [0, 0, binWidth, binHeight], 'EdgeColor', 'k', 'LineWidth', 2);
axis([0 binWidth 0 binHeight]);
axis equal;

% Print the result
occupiedArea = sum(bin(:) > 0);
fprintf('Occupied area: %d pixels (%.2f%% of bin area)\n', occupiedArea, occupiedArea/(binWidth*binHeight)*100);

% Print the list of rectangles that have been placed in the bin
fprintf('Dimensions of rectangles:\n');
for i = 1:size(rectangles, 1)
    fprintf('Rectangle %d: %d x %d\n', idx(i), rectangles(i, 1), rectangles(i, 2));
end

% Helper function to find empty space in the bin
function [x, y] = findEmptySpace(bin, w, h)
    [row, col] = find(~bin);
    dist = (row + h - 1) <= size(bin, 1) & (col + w - 1) <= size(bin, 2);
    row = row(dist);
    col = col(dist);
    dist = zeros(size(row));
    for i = 1:length(row)
        dist(i) = min(min(bin(row(i):(row(i)+h-1), col(i):(col(i)+w-1))));
    end
    [~, idx] = max(dist);
    if isempty(idx) % if no empty space found, return empty values
        x = [];
        y = [];
    else % otherwise, return the coordinates of the empty space
        x = col(idx);
        y = row(idx);
    end
end
tic
clc
clear
close

% W=850;                 % Peso massimo 
% w=[7, 0, 30, 22, 80, 94, 11, 81, 70, 64, 59, 18, 0, 36, 3, 8, 15, 42, 9, 0, 42, 47, 52, 32, 26, 48, 55, 6, 29, 84, 2, 4, 18, 56, 7, 29, 93, 44, 71, 3, 86, 66, 31,65, 0, 79, 20, 65, 52, 13];          % Peso degli item
% v=[360, 83, 59, 130, 431, 67, 230, 52, 93, 125, 670, 892, 600, 38, 48, 147,78, 256, 63, 17, 120, 164, 432, 35, 92, 110, 22, 42, 50, 323, 514, 28, 87, 73, 78, 15,26,78, 210, 36, 85, 189, 274, 43, 33, 10, 19, 389, 276, 312];      % Valori degli item
W = 20;
w = [2, 3, 4, 5, 9, 7, 8, 10];
v = [5, 8, 10, 12, 6, 14, 7, 9];



obj=[w' v'];
obj2=sortrows(obj,1);
w=obj2(:,1)';
v=obj2(:,2)';
n=length(v);          % Numero di elementi da smistare 
V=zeros(n+1,W+1);     % Inizializzo la matrice dei valori
set=zeros(n+1,W+1);   % Inizializzo la matrice che indica gli elementi scelti

for i=2:n+1                      % Mantiene traccia delle iterazioni
    for j=0:W                    % Mantiene traccia del peso 
        
        if j+1-w(i-1)>=1 && v(i-1)+V(i-1,j+1-w(i-1)) >= V(i-1,j+1)
            V(i,j+1)=v(i-1)+V(i-1,j+1-w(i-1));
            set(i,j+1)=1;    % L'elemento i fa parte dell'insieme
        else
            V(i,j+1)=V(i-1,j+1);
            set(i,j+1)=0;    % L'elemento i viene scartato
        end

    end
end

P=W+1;
final=0;
for k=n+1:-1:2
    if set(k,P)==1
        final(end+1)=k-1;
        P=P-w(k-1);
    end
end

% p=obj2([final(2:end)],:);
% for i=1:length(final)-1
%     find(p(i,:)==)
%disp(final(2:end))
disp(final(2:end))
x = indicesToBinaryVector(final(2:end), length(w));
disp(x');
weig = w*x;
val = v*x;
toc

out = vpa(binaryToDecimal(x));

function output = indicesToBinaryVector(indices, vectorSize)
    output = zeros(vectorSize, 1); % Initialize the output vector with zeros
    output(indices) = 1; % Set the values at specified indices to ones
end

function decimalNumber = binaryToDecimal(binaryArray)
    n = numel(binaryArray);
    decimalNumber = 0;
    
    for i = 1:n
        decimalNumber = decimalNumber + binaryArray(i) * 2^(n-i);
    end
end







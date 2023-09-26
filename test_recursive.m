
clc
clear
close
tic
% W=850;               % Peso massimo 
% w=[7, 0, 30, 22, 80, 94, 11, 81, 70, 64, 59, 18, 0, 36, 3, 8, 15, 42, 9, 0, 42, 47, 52, 32, 26, 48, 55, 6, 29, 84, 2, 4, 18, 56, 7, 29, 93, 44, 71, 3, 86, 66, 31, 65, 0, 79, 20, 65, 52, 13];         % Peso degli item
% v=[360, 83, 59, 130, 431, 67, 230, 52, 93, 125, 670, 892, 600, 38, 48, 147, 78, 256, 63, 17, 120, 164, 432, 35, 92, 110, 22, 42, 50, 323, 514, 28, 87, 73, 78, 15, 26,78, 210, 36, 85, 189, 274, 43, 33, 10, 19, 389, 276, 312];    % Valori degli item

W = 20;
w = [2, 3, 4, 5, 9, 7, 8, 10];
v = [5, 8, 10, 12, 6, 14, 7, 9];

n=length(v);        % Numero di elementi da smistare 
%set=zeros(n+1,W+1); 

V=knapsack(v,w,W,n);
disp(V)
toc
function V = knapsack(v,w,W,n)

if n==0
    V=0;
elseif w(n)>W
      V=knapsack(v,w,W,n-1);
else
        V=max(v(n)+knapsack(v,w,W-w(n),n-1) , knapsack(v,w,W,n-1));
end

end



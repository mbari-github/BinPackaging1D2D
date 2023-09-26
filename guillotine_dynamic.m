clc 
close 
clear
%% Rettangoli
% widr=[70,400,100,60,70,200,100]';
% heir=[70,300,60,100,70,150,60]';
% valr=[4,2,8,6,9,5,1]';
% widb=500;
% heib=500;
%Commenta la parte qui sotto e decommenta sopra se non vuoi utilizzare il .txt
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A=load("data.txt");
widr=A(3:end,1);
heir=A(3:end,2);
valr=A(3:end,3);
widb=A(2,1); 
heib=A(2,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=length(widr);
rects=[zeros(n,1),zeros(n,1),widr,heir,widr.*heir];

%% Prima procedura dinamica per width
m=length(widr);          % Numero di elementi da smistare 
c=zeros(1,widb+1);     % Inizializzo la matrice dei valori

for i=1:m
    for j=widr(i):widb+1
        if c(j)<c(j-widr(i)+1)+widr(i)
            c(j)=c(j-widr(i)+1)+widr(i);
        end
    end
end
P1=unique(c);

%% Seconda procedura dinamica per height
m=length(heir);          % Numero di elementi da smistare 
c=zeros(1,heib+1);     % Inizializzo la matrice dei valori

for i=1:m
    for j=heir(i):heib+1
        if c(j)<c(j-heir(i)+1)+heir(i)
            c(j)=c(j-heir(i)+1)+heir(i);
        end
    end
end
P2=unique(c);
 
%% Terza procedura dinamica (2kp solution)

P1=[P1(P1<=widb-min(P1(2:end))),widb];     %nuovo vettore width ammissibili
P2=[P2(P2<=heib-min(P2(2:end))),heib];     %nuovo vettore height ammissibili

% Inizializzazione della matrice
V=zeros(length(P1),length(P2));
item=zeros(length(P1),length(P2));
position=zeros(length(P1),length(P2));
guillotine=strings(length(P1),length(P2));
for i=1:length(P1)
    for j=1:length(P2)
        v=0;
        for c=1:n
            if rects(c,3)<=P1(i) && rects(c,4)<=P2(j)
                v=max([v,rects(c,5)]);
            end
        end
        V(i,j)=v;
        k=0;
        for c=1:n
            if rects(c,3)<=P1(i) && rects(c,4)<=P2(j) && rects(c,5)==V(i,j)
                d=c;
                k=max([k,d]);
            end
        end
        item(i,j)=k;
        guillotine(i,j)=NaN;
    end
end

% Secondo step dell'algoritmo 
for i=2:length(P1)
    for j=2:length(P2)
        k=1:i;
        m=max(k(P1(k)<=floor(P1(i)/2)));
        for x=1:m
            k=1:length(P1);
            t=max(k(P1(k)<=P1(i)-P1(x)));
            if V(i,j)<V(x,j)+V(t,j)
                V(i,j)=V(x,j)+V(t,j);
                position(i,j)=P1(x);
                guillotine(i,j)="V";
            end
        end
        k=1:j;
        M=max(k(P2(k)<=floor(P2(j)/2)));
        for y=1:M
            k=1:length(P2);
            T=max(k(P2(k)<=P2(j)-P2(y)));
            if V(i,j)<V(i,y)+V(i,T)
                V(i,j)=V(i,y)+V(i,T);
                position(i,j)=P2(y);
                guillotine(i,j)="H";
            end
        end
    end
end
% Plot the bin
figure;
hold on;
axis equal;
axis([0 widb 0 heib]);
rectangle('Position', [0, 0, widb, heib], 'FaceColor', [0.5 0.5 0.5]);

% Plot the rectangles
for i = 1:length(P1)
    for j = 1:length(P2)
        if item(i,j) ~= 0
            x = position(i,j);
            y = sum(P2(1:j-1)) + 1;
            w = widr(item(i,j));
            h = heir(item(i,j));
            color = rand(1, 3);

            rectangle('Position', [x, y, w, h], 'FaceColor', color);
            rectangle('Position', [x, y, w, h], 'EdgeColor', 'k', 'LineWidth', 1);
        end
    end
end

hold off;
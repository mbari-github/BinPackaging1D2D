%% Col1= coord x basso sx/ Col2= coord y basso sx/ Col3= width/ Col 4=height  
% widr=[200,400,100,60,70,200,300, 0]';
% heir=[300,300,60,100,70,150,300, 0]';
widr=[200,200]';
heir=[300, 100]';
arear=widr.*heir;
n=length(widr);
rects=[zeros(n,1),zeros(n,1),widr,heir,arear];
c=size(rects,2);
packed=zeros(n,c);
n_packed=1;

%% Creazione dei bin
widb=500;
heib=500;
bins=[widb,heib];
areab=bins(1,1)*bins(1,2);

%% Inizializzazione dell'algoritmo
p=6*n;
F=zeros(n,p);
index=1;
F(1,1:6)=[0,0,widb,heib,areab,index];
for i=1:n
    c=1;
    for j=5:6:p
        if F(i,j) ~=0
            fit=F(i,j)-rects(:,5);
            for k=1:length(fit)
                if fit(k)<0 || fit(k)==F(i,j)
                    fit(k)=NaN;
                end
            end
            [m,I]=mink(fit,length(fit));
            if F(i,j+1) > 1
                m(1)=m(F(i,j+1));
                I(1)=I(F(i,j+1));
            end
            if  ~isempty(m(1)) && ~isnan(m(1)) && (rects(I(1),3)<=F(i,j-2) && rects(I(1),4)<=F(i,j-1))
                rects(I(1),1) =F(i,j-4);
                rects(I(1),2) =F(i,j-3);
                if F(i,j-2)<F(i,j-1)
                    new_width1 =F(i,j-2)-rects(I(1),3);
                    new_width2 =F(i,j-2);
                    new_height1 =rects(I(1),4);
                    new_height2 =F(i,j-1)-rects(I(1),4);                
                    new_area1 =new_width1*new_height1;
                    new_area2 =new_width2*new_height2;
                    
                else
                    new_width1 =F(i,j-2)-rects(I(1),3);
                    new_width2 =rects(I(1),3);
                    new_height1 =F(i,j-1);
                    new_height2 =F(i,j-1)-rects(I(1),4);                
                    new_area1 =new_width1*new_height1;
                    new_area2 =new_width2*new_height2;
                end
                flag =false;
                flag2=false;
                if rects(I(1),4)<F(i,j-1)                    
                     F(i+1,c:c+5)=[F(i,j-4),F(i,j-3)+rects(I(1),4), new_width2,new_height2,new_area2,1];
                     flag=true;
                end
                if rects(I(1),3)<F(i,j-2) 
                    if flag
                     F(i+1,c+6:c+11)=[F(i,j-4)+rects(I(1),3),F(i,j-3), new_width1,new_height1,new_area1,1];
                    else
                     F(i+1,c:c+5)=[F(i,j-4)+rects(I(1),3),F(i,j-3), new_width1,new_height1,new_area1,1];
                    end
                    flag2=true;
                end
                packed(n_packed,:)=rects(I(1),:);
                n_packed=n_packed+1;
                rects(I(1),:)=0;
                if flag && flag2
                    c=c+12;
                elseif ~(flag || flag2)
                else
                    c=c+6;
                end
            else
                F(i+1,c:c+5)=F(i,c:c+5);
                F(i+1,c+5)=F(i,c+5)+1;
                c=c+6;
            end
        else
            break
        end
    end
end

%% Plot dei risultati
n_packed=n_packed-1;
fprintf("Rettangoli posti nel bin: %d\n",n_packed)
rectangle('Position',[0,0,widb,heib]); hold on
for i=1:size(packed,1)
rectangle('Position',[packed(i,1),packed(i,2),packed(i,3),packed(i,4)], ...
            'FaceColor',rand(1,3));
end
axis equal
T1=Z(16:30,:); % get Z scores for Novel tone period 
T2=Z2(16:30,:); %  get Z scores for CS+ tone period

A=[T1;T2];


% Rescale data to facilitate clustering
A = rescale(A,-3,3,"InputMin",-5,"InputMax",5);

% clustering parameters
li='ward';
PD='euclidean';


% Linkage function
L = linkage(A',li,PD,'savememory','on'); %X is PCA coordinate matrix

f=0.05; % fraction of linkage to be used

a=redbluecmap; % select color map to use

color = L(end-round(f*max(L(:,3))),3)-eps; % color threshold for dendogram

%% generates clustergram (heatmap and dendrogram)

C=clustergram(A','Cluster','column','Linkage',{'ward','ward'},'ColumnPDist','euclidean','Dendrogram',color,'Colormap',a)
C. DisplayRange=6;


%% cluster data

s=7; % Enter number of unique colors in clustergram above

c = cluster(L,'Maxclust',s);
m=max(c);

%% Cluster unscaled Z values

Z=[T1;T2]; % get unscaled Z scores


% transpose variables
A=A';
Z=Z';


%% Use this to match heatmap from clustering to dendrogram generated from clustergram

[id2,node_2,testing]=dendrogram(L,size(Z,1)); 

leafOrder = optimalleaforder(L,pdist(A));
[id2,node_2,order]=dendrogram(L,0,Reorder=leafOrder,Orientation="left");


order=order';
order= flip(order);

ZZ=Z(order,:);
AA=A(order,:);

n1=-6;
n2=6;
figure,imagesc(ZZ,[n1 n2]);
colormap(a)

%% Group z scores for each cluster n within structure variable
Z=Z';
d=c';
for n=1:m;
    Zclust{n}=Z(:,d==n);
end

%% average, SD, N of each cluster

ZclustM=zeros(32,size(Zclust,2));
ZclustSD=ZclustM;
O=ones(32,1);
for i=1:m;
    ZclustM(:,i)=mean(Zclust{1,i},2);
    ZclustSD(:,i)=std(Zclust{1,i},0,2);
    Nclust(:,i)=O*(size(Zclust{1,i},2));
end

%%
O=ones(size(ZclustM,1),size(ZclustM,2));
Nclust=O.*Nclust;

%% results in a matrix with mean, SD ,N recurrent pattern to paste into prism
P=[ZclustM(:,1),ZclustSD(:,1),Nclust(:,1)];
for i=2:m;
    
    T=[ZclustM(:,i),ZclustSD(:,i),Nclust(:,i)];
    P=[P,T];
    
end

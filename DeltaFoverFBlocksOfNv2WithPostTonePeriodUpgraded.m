%% This code assumes 10 frames per second data acquisition frequency


clc
clear all
%% Get data from CSV files exported from Inscopix Data Processing Software
current=uigetdir('/Users/patellab/Desktop');
cd (current)
fileName=uigetfile('mouse1recall.xlsx'); %%write File name
[DataBase.Num DataBase.Txt] = xlsread(fileName);
DataBase.cell=DataBase.Txt(1,2:end);%get cell ids
DataBase.status=DataBase.Txt(2,2:end);%get cell accept/reject status
DataBase.values=DataBase.Num(1:end,2:end); %%get deltaFoverFvalues for all cells
Times=DataBase.Num(1:end,1);

%% accepted cells filter
for m=1:size(DataBase.status,2)
    
if DataBase.status{1,m}==' accepted'
    accepted(1,m)=1
else 
    accepted(1,m)=0
end
end
accepted=logical(accepted);
deltaFoverF=DataBase.values;


deltaFoverF=deltaFoverF(:,accepted); 


%% Construct structure variables around events of interest (times of tone onset)

EventOnset=[399.6 499.6]; %list events (either manually or from flag file; 1 decimal figure only)
EventOnset2=[599.4 709.5];

EventOnset= (round(EventOnset,1))*10;
EventOnset2=(round(EventOnset2,1))*10;
Times=round(Times,1);
Times=Times*10;


% For novel tones
for tone=1:size(EventOnset,2);
    Event=find(Times==EventOnset(1,tone));
    initial=(Event-150);
    last=(Event+309);

    Tone{tone}= [deltaFoverF(initial:last,1:size(deltaFoverF,2))];
end
 
% For CS+
for tone2=1:size(EventOnset2,2);
    Event2=find(Times==EventOnset2(1,tone2));
    initial=(Event2-150);
    last=(Event2+309);
    
      Tone2{tone2}= [deltaFoverF(initial:last,1:size(deltaFoverF,2))];
end


%% Bin Data into selected bin size

%Build matrix called Binned of values at 1 second precision from 0.1 second precision matrix

VectorLength=(size(Tone{1},1))/10;


for tone=1:size(EventOnset,2);
   for i =1:size(deltaFoverF,2); %% build columns
    for j = 1:VectorLength; %build rows; bin 1 column at a time
        rr=j*10;
        A=Tone{tone}(rr-9:rr,i);
            Binned{tone}(j,i)= mean(A);
                   
    end
  end
end
            
         
for tone2=1:size(EventOnset2,2);
   for i =1:size(deltaFoverF,2); %% build columns
    for j = 1:VectorLength; %build rows; bin 1 column at a time
        rr=j*10;
        A=Tone2{tone2}(rr-9:rr,i);
            Binned2{tone2}(j,i)= mean(A);
                    
    end
  end
end




%% Average Binned matrices onto a single average matrix (block of n (n=nuber of events))
   
n=length(EventOnset); %number of events
     
temporary= sum(cat(3,Binned{:}),3);
Block=temporary/n;
   
 % blocks of n for tones (n=number of events)
   
n=length(EventOnset2); %number of events
     
   temporary2= sum(cat(3,Binned2{:}),3);
    Block2=temporary2/n;    
       
   

%% Z score the data with pretone as baseline; 

    D=Block(1:15,1:end)
    x=mean(D,1);
    r=Block(1:end,1);
    dim=size(r,1)
    X=ones([dim,1])*x ;%create matrix of means same size as Block in order to substract means to each column element
    
    stdev=std(D,0,1);
    StDev=ones([dim,1])*stdev;
    delta=(Block-X);
    Z=delta./StDev;    



% Repeat for other tone type
    D2=Block2(1:15,1:end)
    x2=mean(D2,1);
    r2=Block2(1:end,1);
    dim2=size(r2,1)
    X2=ones([dim2,1])*x2 ;%create matrix of means same size as Block in order to substract means to each column element
    
    stdev2=std(D2,0,1);
    StDev2=ones([dim2,1])*stdev2;
    delta2=(Block2-X2);
    Z2=delta2./StDev2; 
    

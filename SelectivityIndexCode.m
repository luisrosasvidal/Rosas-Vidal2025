
M_NT_DO34=mean(DO34Traces,1); % Use deltaFoverF aligned around tone onsets and Z score using the pretone tone and postone periods
M_NT_DO34=ones(46,1)*M_NT_DO34;

S_NT_DO34=std(DO34Traces,1);
S_NT_DO34=ones(46,1)*S_NT_DO34;

Z_NT_DO34=(NT_DO34-M_NT_DO34)./S_NT_DO34;

M_CS_DO34=mean(DO34Traces,1);
M_CS_DO34=ones(46,1)*M_CS_DO34;

S_CS_DO34=std(DO34Traces,1);
S_CS_DO34=ones(46,1)*S_CS_DO34;

Z_CS_DO34=(CS_DO34-M_CS_DO34)./S_CS_DO34;



M_NT_Veh=mean(VehicleTraces,1);
M_NT_Veh=ones(46,1)*M_NT_Veh;

S_NT_Veh=std(VehicleTraces,1);
S_NT_Veh=ones(46,1)*S_NT_Veh;

Z_NT_Veh=(NT_Veh-M_NT_Veh)./S_NT_Veh; %NT_Veh are the traces for Veh during NT presentation



M_CS_Veh=mean(VehicleTraces,1);
M_CS_Veh=ones(46,1)*M_CS_Veh;

S_CS_Veh=std(VehicleTraces,1);
S_CS_Veh=ones(46,1)*S_CS_Veh;

Z_CS_Veh=(CS_Veh-M_CS_Veh)./S_CS_Veh;  %CS_Veh are the traces for Veh during CS+ presentation




%% Calculate average Z for tones and index

Z_NT_DO34=mean(Z_NT_DO34(16:30,:),1); % calculate average Z novel tone period (DO34 treatment)
Z_CS_DO34=mean(Z_CS_DO34(16:30,:),1); % calculate average Z CS+ tone period (DO34 treatment)

Z_NT_Veh=mean(Z_NT_Veh(16:30,:),1); % calculate average Z novel tone tone period (vehicle treatment)
Z_CS_Veh=mean(Z_CS_Veh(16:30,:),1); % calculate average Z CS+ tone period (vehicle treatment)

% Calculate indeces
I_DO34=abs(Z_NT_DO34-Z_CS_DO34)./(abs(Z_NT_DO34)+abs(Z_CS_DO34)); % Index for all neurons; DO34 exposed
I_Veh=abs(Z_NT_Veh-Z_CS_Veh)./(abs(Z_NT_Veh)+abs(Z_CS_Veh)); % Index for all neurons; vehicle exposed


% Ascribe sign depending on absolute modulation preference for NT vs CS+
c=zeros(1,885);
for i=1:885
if Z_NT_DO34(i)==Z_CS_DO34(i)
    c(i)=0
elseif abs(Z_NT_DO34(i))>abs(Z_CS_DO34(i)) % novel tone preference
    c(i)=1;
else
    c(i)=-1; % CS+ preference
end
end

I_DO34=c.*I_DO34; % index for all neurons; DO34 exposed


c=zeros(1,802);
for i=1:802
if Z_NT_Veh(i)==Z_CS_Veh(i)
    c(i)=0
elseif abs(Z_NT_Veh(i))>abs(Z_CS_Veh(i)) % novel tone preference
    c(i)=1;
else
    c(i)=-1;  % CS+ preference
end
end
I_Veh=c.*I_Veh; % Index for all neurons; vehicle exposed



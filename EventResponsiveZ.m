
%% Filter for statistically significant response  for any 2 consecutive bins in the tone period

T= 3; % statistical threshold

% Tone onset is bin #16; create logical filter for neurons with
% statistically significant increase in activity during the tone period

for cc=1:size(Z,2)
  if (Z(17,cc)>=T && Z(18,cc)>=T) || (Z(18,cc)>=T && Z(19,cc)>=T) || (Z(19,cc)>=T && Z(20,cc)>=T) || (Z(20,cc)>=T && Z(21,cc)>=T) ...
      || (Z(21,cc)>=T && Z(22,cc)>=T) || (Z(22,cc)>=T && Z(23,cc)>=T) || (Z(23,cc)>=T && Z(24,cc)>=T) || (Z(24,cc)>=T && Z(25,cc)>=T) ...
      || (Z(25,cc)>=T && Z(26,cc)>=T) || (Z(26,cc)>=T && Z(27,cc)>=T) || (Z(27,cc)>=T && Z(28,cc)>=T) || (Z(28,cc)>=T && Z(29,cc)>=T) ...
      || (Z(29,cc)>=T && Z(30,cc)>=T);
      
    significant(1,cc)=1;
else significant(1,cc)=0;
end
end
significant=logical(significant);

% Obtain matrix of Tone Responsive cells
Responsive=Z(:,significant);

%% create logical filter for neurons with statistically significant decrease in activity during the tone period

for cc=1:size(Z,2)
if (Z(17,cc)<=-T && Z(18,cc)<=-T) || (Z(18,cc)<=-T && Z(19,cc)<=-T) || (Z(19,cc)<=-T && Z(20,cc)<=-T) || (Z(20,cc)<=-T && Z(21,cc)<=-T) ...
      || (Z(21,cc)<=-T && Z(22,cc)<=-T) || (Z(22,cc)<=-T && Z(23,cc)<=-T) || (Z(23,cc)<=-T && Z(24,cc)<=-T) || (Z(24,cc)<=-T && Z(25,cc)<=-T) ...
      || (Z(25,cc)<=-T && Z(26,cc)<=-T) || (Z(26,cc)<=-T && Z(27,cc)<=-T) || (Z(27,cc)<=-T && Z(28,cc)<=-T) || (Z(28,cc)<=-T && Z(29,cc)<=-T) ...
      || (Z(29,cc)<=-T && Z(30,cc)<=-T)
    Nsignificant(1,cc)=1;
else Nsignificant(1,cc)=0;
end
end
Nsignificant=logical(Nsignificant);

%% Obtain matrix of negative responsive cells
NegativeResponsive=Z(:,Nsignificant);



%% Repeat for the second tone type
for cc=1:size(Z2,2)
if (Z2(17,cc)>=T && Z2(18,cc)>=T) || (Z2(18,cc)>=T && Z2(19,cc)>=T) || (Z2(19,cc)>=T && Z2(20,cc)>=T) || (Z2(20,cc)>=T && Z2(21,cc)>=T) ...
      || (Z2(21,cc)>=T && Z2(22,cc)>=T) || (Z2(22,cc)>=T && Z2(23,cc)>=T) || (Z2(23,cc)>=T && Z2(24,cc)>=T) || (Z2(24,cc)>=T && Z2(25,cc)>=T) ...
      || (Z2(25,cc)>=T && Z2(26,cc)>=T) || (Z2(26,cc)>=T && Z2(27,cc)>=T) || (Z2(27,cc)>=T && Z2(28,cc)>=T) || (Z2(28,cc)>=T && Z2(29,cc)>=T) ...
      || (Z2(29,cc)>=T && Z2(30,cc)>=T)

    significant2(1,cc)=1;
else significant2(1,cc)=0;
end
end
significant2=logical(significant2);

% Responsive cells
Responsive2=Z2(:,significant2);

for cc=1:size(Z2,2)
if (Z2(17,cc)<=-T && Z2(18,cc)<=-T) || (Z2(18,cc)<=-T && Z2(19,cc)<=-T) || (Z2(19,cc)<=-T && Z2(20,cc)<=-T)|| (Z2(20,cc)<=-T && Z2(21,cc)<=-T) ...
      || (Z2(21,cc)<=-T && Z2(22,cc)<=-T) || (Z2(22,cc)<=-T && Z2(23,cc)<=-T) || (Z2(23,cc)<=-T && Z2(24,cc)<=-T) || (Z2(24,cc)<=-T && Z2(25,cc)<=-T) ...
      || (Z2(25,cc)<=-T && Z2(26,cc)<=-T) || (Z2(26,cc)<=-T && Z2(27,cc)<=-T) || (Z2(27,cc)<=-T && Z2(28,cc)<=-T) || (Z2(28,cc)<=-T && Z2(29,cc)<=-T) ...
      || (Z2(29,cc)<=-T && Z2(30,cc)<=-T)
% if Z2(16,cc)<=-1.645 || Z2(17,cc)<=-1.645 || Z2(18,cc)<=-1.
% if Z2(16,cc)<=-1.96 || Z2(17,cc)<=-1.96 || Z2(18,cc)<=-1.96
    Nsignificant2(1,cc)=1;
else Nsignificant2(1,cc)=0;
end
end
Nsignificant2=logical(Nsignificant2);

% Responsive cells
NegativeResponsive2=Z2(:,Nsignificant2);



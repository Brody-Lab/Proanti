clear
clc

load data_files/matsc
load data_files/matpfc

%%% area to use
pop=matsc;



% close all


dprimesvalues=[-1 1];
% dprimesvalues=[-0.8 0.8];


%45 85 143


% 21 good
% 45 ok

% 34
% 73
% 69
% 114
% 85

save_figures=0;

indneur1=45;
indneur2=74;
indneur3=143;

% indneur1=74
% indneur1=143;
% indneur2=47;
% indneur3=139;





%%%% median delay between end_of_delay and cout (computed using step0_compute_timing.m in preparatory_code)
cout_time_delay=0.127;

%%% x axis limit (time)
xlimit=[-1.9 0.7];

%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers=centers+centers_back;
xlimit=xlimit+centers_back;

xlim_use=[min(centers) max(centers)];



% [dp_ap,~,dp_choice,~] = compute_dprimes_correct(pop);

[dp_ap1,pvals_ap1,dp_ap2,pvals_ap2] = compute_proanti_fix_motion(pop);






dp_ap=dp_ap1;
pvals_ap=pvals_ap1;

% 
dp=dp_ap;
%%% sort neurons
[~,indmax]=max(abs(dp_ap),[],2);
[~,indsort]=sort(indmax);
dp=dp(indsort,:);
%%% normalize dprimes
sigo=sign(dp);
dp=abs(dp);
minval=abs(tinv(0.05,98)/sqrt(25)); %significant p<=0.05
maxval=1;
dp=dp-minval; 
dp(dp<0)=0;
maxval_use=maxval-minval; 
dp(dp>maxval_use)=maxval_use;
dp=dp/maxval_use;
dp1=dp.*sigo;
%%% plot!


% save cde_sorting indmax indneur*
% return


figure('units','normalized','position',[.3 0 .2 .5])
imagesc(centers,1:size(dp,1),dp1,dprimesvalues)
xlim(xlimit)
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('SC neurons')
set(gca,'YTick',[1 100 193])
title('d'' SC - ipsi')
hold on
plot([0 0],ylim,'w')
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
plot([0 0]-(1.5+cout_time_delay),ylim,'w')



a=[linspace(1,0,32) linspace(0,0,32)]' ;
b=[linspace(0,0,32) linspace(0,1,32)]' ;
c=[linspace(0,0,32) linspace(0,0,32)]' ;
co=[a b c];
colormap(co);



colorbar
%%%% example neuron index
xa=xlim;
plot([xa(1) xa(1)+2.9],[indneur1 indneur1]-.5,'w','LineWidth',0.5)
plot([xa(1) xa(1)+2.9],[indneur1 indneur1]+.5,'w','LineWidth',0.5)
hold on
plot([xa(1) xa(1)+2.9],[indneur2 indneur2]-.5,'w','LineWidth',0.5)
plot([xa(1) xa(1)+2.9],[indneur2 indneur2]+.5,'w','LineWidth',0.5)
plot([xa(1) xa(1)+2.9],[indneur3 indneur3]-.5,'w','LineWidth',0.5)
plot([xa(1) xa(1)+2.9],[indneur3 indneur3]+.5,'w','LineWidth',0.5)
set(gca,'FontSize',24)

















% 
dp_ap=dp_ap2;
pvals_ap=pvals_ap2;

dp=dp_ap;
%%% sort neurons
[~,indmax]=max(abs(dp_ap),[],2);
[~,indsort]=sort(indmax);
dp=dp(indsort,:);
%%% normalize dprimes
sigo=sign(dp);
dp=abs(dp);
minval=abs(tinv(0.05,98)/sqrt(25)); %significant p<=0.05
maxval=1;
dp=dp-minval; 
dp(dp<0)=0;
maxval_use=maxval-minval; 
dp(dp>maxval_use)=maxval_use;
dp=dp/maxval_use;
dp1=dp.*sigo;
%%% plot!


% save cde_sorting indmax indneur*
% return


figure('units','normalized','position',[.3 0 .2 .5])
imagesc(centers,1:size(dp,1),dp1,dprimesvalues)
xlim(xlimit)
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('SC neurons')
set(gca,'YTick',[1 100 193])
title('d'' SC - contra')
hold on
plot([0 0],ylim,'w')
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
plot([0 0]-(1.5+cout_time_delay),ylim,'w')



a=[linspace(1,0,32) linspace(0,0,32)]' ;
b=[linspace(0,0,32) linspace(0,1,32)]' ;
c=[linspace(0,0,32) linspace(0,0,32)]' ;
co=[a b c];
colormap(co);



colorbar
%%%% example neuron index
xa=xlim;
plot([xa(1) xa(1)+2.9],[indneur1 indneur1]-.5,'w','LineWidth',0.5)
plot([xa(1) xa(1)+2.9],[indneur1 indneur1]+.5,'w','LineWidth',0.5)
hold on
plot([xa(1) xa(1)+2.9],[indneur2 indneur2]-.5,'w','LineWidth',0.5)
plot([xa(1) xa(1)+2.9],[indneur2 indneur2]+.5,'w','LineWidth',0.5)
plot([xa(1) xa(1)+2.9],[indneur3 indneur3]-.5,'w','LineWidth',0.5)
plot([xa(1) xa(1)+2.9],[indneur3 indneur3]+.5,'w','LineWidth',0.5)
set(gca,'FontSize',24)













clear
clc

load data_files/matsc
load data_files/matpfc

%%% area to use
pop=matpfc;



close all


dprimesvalues=[-1 1];

%good
%33
% 228

% 56

% 
% % 79
% % 136


save_figures=0;

indneur1=33;
indneur2=56;
indneur3=228;





%%%% median delay between end_of_delay and cout (computed using step0_compute_timing.m in preparatory_code)
cout_time_delay=0.127;

%%% x axis limit (time)
xlimit=[-1.9 0.7];

%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers=centers+centers_back;
xlimit=xlimit+centers_back;

xlim_use=[min(centers) max(centers)];



[dp_ap,~,dp_choice,~] = compute_dprimes_correct(pop);



dp=dp_ap;
%%% sort neurons
[~,indmax]=max(abs(dp_ap),[],2);
[~,indsort]=sort(indmax);
dp=dp(indsort,:);
%%% normalize dprimes
sigo=sign(dp);
dp=abs(dp);
minval=abs(tinv(0.05,98)/sqrt(50)); %significant p<=0.05
maxval=1;
dp=dp-minval; 
dp(dp<0)=0;
maxval_use=maxval-minval; 
dp(dp>maxval_use)=maxval_use;
dp=dp/maxval_use;
dp1=dp.*sigo;
%%% plot!


% 


figure('units','normalized','position',[.3 0 .4 1])
imagesc(centers,1:size(dp,1),dp1,dprimesvalues)
xlim(xlimit)
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('SC neurons')
set(gca,'YTick',[1 100 193])
title('d'' PFC')
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
if(save_figures)
    saveas(gcf,'aaa1','pdf')
end



















dp=dp_choice;
%%% sort neurons
[~,indmax]=max(abs(dp_ap),[],2);
[~,indsort]=sort(indmax);
dp=dp(indsort,:);
%%% normalize dprimes
sigo=sign(dp);
dp=abs(dp);
minval=abs(tinv(0.05,98)/sqrt(50)); %significant p<=0.05
maxval=1;
dp=dp-minval; 
dp(dp<0)=0;
maxval_use=maxval-minval; 
dp(dp>maxval_use)=maxval_use;
dp=dp/maxval_use;
dp2=dp.*sigo;
%%% plot!




figure('units','normalized','position',[.3 0 .4 1])
imagesc(centers,1:size(dp,1),dp2,dprimesvalues)
xlim(xlimit)
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('SC neurons')
set(gca,'YTick',[1 100 193])
title('d'' PFC')
hold on
plot([0 0],ylim,'w')
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
plot([0 0]-(1.5+cout_time_delay),ylim,'w')



a=[linspace(1,0,32) linspace(0,40/255,32)]' ;
b=[linspace(125/255,0,32) linspace(0,110/255,32)]' ;
c=[linspace(36/255,0,32) linspace(0,1,32)]' ;

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
if(save_figures)
    saveas(gcf,'aaa2','pdf')
end





%%%%%%%%%%% FIRST NEURON %%%%%%%%%%%



%%% find index of example neuron
val_index=indsort(indneur1);

%reload centers without shift (will be shifted by plot_example_neuron)
centers_shifted=centers;
load data_files/matsc centers


figure('units','normalized','position',[0 .3 .5 .25])
plot_example_neuron_pfc(centers,pop,val_index)
if(save_figures)
    saveas(gcf,'aaa3a','pdf')
end




figure('units','normalized','position',[0 .5 .5 .05])
imagesc(centers_shifted,1,dp1(indneur1,:,:),dprimesvalues)

a=[linspace(1,0,32) linspace(0,0,32)]' ;
b=[linspace(0,0,32) linspace(0,1,32)]' ;
c=[linspace(0,0,32) linspace(0,0,32)]' ;
co=[a b c];
colormap(co);


xlim(xlimit)
set(gca,'TickDir','out','YTick',[])
box off
%%%% cout
hold on
plot([0 0],ylim,'w')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'w')
% colorbar
if(save_figures)
    saveas(gcf,'aaa4a','pdf')
end



figure('units','normalized','position',[0 .5 .5 .05])
imagesc(centers_shifted,1,dp2(indneur1,:,:),dprimesvalues)


a=[linspace(1,0,32) linspace(0,40/255,32)]' ;
b=[linspace(125/255,0,32) linspace(0,110/255,32)]' ;
c=[linspace(36/255,0,32) linspace(0,1,32)]' ;

co=[a b c];
colormap(co);


xlim(xlimit)
set(gca,'TickDir','out','YTick',[])
box off
%%%% cout
hold on
plot([0 0],ylim,'w')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'w')
% colorbar
if(save_figures)
    saveas(gcf,'aaa5a','pdf')
end






















%%%%%%%%%%% FIRST NEURON %%%%%%%%%%%



%%% find index of example neuron
val_index=indsort(indneur2);

%reload centers without shift (will be shifted by plot_example_neuron)
centers_shifted=centers;
load data_files/matsc centers


figure('units','normalized','position',[0 .3 .5 .25])
plot_example_neuron_pfc(centers,pop,val_index)
if(save_figures)
    saveas(gcf,'aaa3b','pdf')
end




figure('units','normalized','position',[0 .5 .5 .05])
imagesc(centers_shifted,1,dp1(indneur2,:,:),dprimesvalues)

a=[linspace(1,0,32) linspace(0,0,32)]' ;
b=[linspace(0,0,32) linspace(0,1,32)]' ;
c=[linspace(0,0,32) linspace(0,0,32)]' ;
co=[a b c];
colormap(co);


xlim(xlimit)
set(gca,'TickDir','out','YTick',[])
box off
%%%% cout
hold on
plot([0 0],ylim,'w')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'w')
% colorbar
if(save_figures)
    saveas(gcf,'aaa4b','pdf')
end



figure('units','normalized','position',[0 .5 .5 .05])
imagesc(centers_shifted,1,dp2(indneur2,:,:),dprimesvalues)


a=[linspace(1,0,32) linspace(0,40/255,32)]' ;
b=[linspace(125/255,0,32) linspace(0,110/255,32)]' ;
c=[linspace(36/255,0,32) linspace(0,1,32)]' ;

co=[a b c];
colormap(co);


xlim(xlimit)
set(gca,'TickDir','out','YTick',[])
box off
%%%% cout
hold on
plot([0 0],ylim,'w')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'w')
% colorbar
if(save_figures)
    saveas(gcf,'aaa5b','pdf')
end





















%%%%%%%%%%% FIRST NEURON %%%%%%%%%%%



%%% find index of example neuron
val_index=indsort(indneur3);

%reload centers without shift (will be shifted by plot_example_neuron)
centers_shifted=centers;
load data_files/matsc centers


figure('units','normalized','position',[0 .3 .5 .25])
plot_example_neuron_pfc(centers,pop,val_index)
if(save_figures)
    saveas(gcf,'aaa3c','pdf')
end




figure('units','normalized','position',[0 .5 .5 .05])
imagesc(centers_shifted,1,dp1(indneur3,:,:),dprimesvalues)

a=[linspace(1,0,32) linspace(0,0,32)]' ;
b=[linspace(0,0,32) linspace(0,1,32)]' ;
c=[linspace(0,0,32) linspace(0,0,32)]' ;
co=[a b c];
colormap(co);


xlim(xlimit)
set(gca,'TickDir','out','YTick',[])
box off
%%%% cout
hold on
plot([0 0],ylim,'w')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'w')
% colorbar
if(save_figures)
    saveas(gcf,'aaa4c','pdf')
end



figure('units','normalized','position',[0 .5 .5 .05])
imagesc(centers_shifted,1,dp2(indneur3,:,:),dprimesvalues)


a=[linspace(1,0,32) linspace(0,40/255,32)]' ;
b=[linspace(125/255,0,32) linspace(0,110/255,32)]' ;
c=[linspace(36/255,0,32) linspace(0,1,32)]' ;

co=[a b c];
colormap(co);


xlim(xlimit)
set(gca,'TickDir','out','YTick',[])
box off
%%%% cout
hold on
plot([0 0],ylim,'w')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'w')
% colorbar
if(save_figures)
    saveas(gcf,'aaa5c','pdf')
end






return

%%%%%%%%%%% SECOND NEURON %%%%%%%%%%%




%%% find index of example neuron
val_index=indsort(indneur2);
figure('units','normalized','position',[0 .3 .5 .25])
plot_example_neuron(centers,pop,val_index)
if(save_figures)
    saveas(gcf,'figures/singleneurons_examplecell2','pdf')
end



figure('units','normalized','position',[0 .5 .5 .05])
imagesc(centers_shifted,1,dp1(indneur2,:,:),dprimesvalues)

a=[linspace(1,0,32) linspace(0,0,32)]' ;
b=[linspace(0,0,32) linspace(0,1,32)]' ;
c=[linspace(0,0,32) linspace(0,0,32)]' ;
co=[a b c];
colormap(co);


xlim(xlimit)
set(gca,'TickDir','out','YTick',[])
box off
%%%% cout
hold on
plot([0 0],ylim,'w')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'w')
% colorbar
if(save_figures)
    saveas(gcf,'aaa4','pdf')
end



figure('units','normalized','position',[0 .5 .5 .05])
imagesc(centers_shifted,1,dp2(indneur2,:,:),dprimesvalues)


a=[linspace(1,0,32) linspace(0,40/255,32)]' ;
b=[linspace(125/255,0,32) linspace(0,110/255,32)]' ;
c=[linspace(36/255,0,32) linspace(0,1,32)]' ;

co=[a b c];
colormap(co);


xlim(xlimit)
set(gca,'TickDir','out','YTick',[])
box off
%%%% cout
hold on
plot([0 0],ylim,'w')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'w')
% colorbar
if(save_figures)
    saveas(gcf,'aaa5','pdf')
end



%%%%%%%%%%% THIRD NEURON %%%%%%%%%%%


%%% find index of example neuron
val_index=indsort(indneur3);
figure('units','normalized','position',[0 .3 .5 .25])
plot_example_neuron(centers,pop,val_index)
ylim([0 13])
if(save_figures)
    saveas(gcf,'figures/singleneurons_examplecell3','pdf')
end




figure('units','normalized','position',[0 .5 .5 .05])
imagesc(centers_shifted,1,dp1(indneur3,:,:),dprimesvalues)

a=[linspace(1,0,32) linspace(0,0,32)]' ;
b=[linspace(0,0,32) linspace(0,1,32)]' ;
c=[linspace(0,0,32) linspace(0,0,32)]' ;
co=[a b c];
colormap(co);


xlim(xlimit)
set(gca,'TickDir','out','YTick',[])
box off
%%%% cout
hold on
plot([0 0],ylim,'w')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'w')
% colorbar
if(save_figures)
    saveas(gcf,'aaa4','pdf')
end



figure('units','normalized','position',[0 .5 .5 .05])
imagesc(centers_shifted,1,dp2(indneur3,:,:),dprimesvalues)


a=[linspace(1,0,32) linspace(0,40/255,32)]' ;
b=[linspace(125/255,0,32) linspace(0,110/255,32)]' ;
c=[linspace(36/255,0,32) linspace(0,1,32)]' ;

co=[a b c];
colormap(co);


xlim(xlimit)
set(gca,'TickDir','out','YTick',[])
box off
%%%% cout
hold on
plot([0 0],ylim,'w')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'w')
% colorbar
if(save_figures)
    saveas(gcf,'aaa5','pdf')
end




clear
clc
close all
load data_files/matsc
load data_files/matpfc

%%% area to use
pop=matsc;



%%%% median delay between end_of_delay and cout (computed using step0_compute_timing.m in preparatory_code)
cout_time_delay=0.127;

%%% x axis limit (time)
xlimit=[-1.9 0.7];

%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers=centers+centers_back;
xlimit=xlimit+centers_back;

xlim_use=[min(centers) max(centers)];




[dp_ap,~,dp_choice,~] = compute_dprimes_correct(pop,'dprime');
%%% sort neurons
[~,indmax]=max(abs(dp_ap),[],2);
[~,indsort]=sort(indmax);



% 
% %%% dprime, auc, diffe
% [dp_ap,~,dp_choice,~] = compute_dprimes_correct(pop,'dprime');
% dprimesvalues=[-1 1];
% minval=abs(tinv(0.05,98)/sqrt(50)); %significant p<=0.05
% maxval=1;

% % % % 
% % % % % [dp_ap,~,dp_choice,~] = compute_dprimes_correct(pop,'auc');
% % % % % auc_ap=dp_ap;
% % % % % auc_choice=dp_choice;
% % % % % save auc_ap auc_ap
% % % % % save auc_choice auc_choice



load auc_ap
load auc_choice
dp_ap=auc_ap;
dp_choice=auc_choice;
dp_ap=2*(dp_ap-.5);
dp_choice=2*(dp_choice-.5);
dprimesvalues=[-1 1];
minval=.1;
maxval=.7;


% 
% 
% 
% [dp_ap,~,dp_choice,~] = compute_dprimes_correct(pop*4,'diffe');
% 
% dprimesvalues=[-1 1];
% minval=2.4;
% maxval=10;
% % 
% 



dp=dp_ap;
dp=dp(indsort,:);


%%% normalize dprimes
sigo=sign(dp);
dp=abs(dp);
dp=dp-minval; 
dp(dp<0)=0;
maxval_use=maxval-minval; 
dp(dp>maxval_use)=maxval_use;
dp=dp/maxval_use;
dp1=dp.*sigo;
%%% plot!





figure('units','normalized','position',[.15 0 .2 .5])

% figure('Position',[616   129   584   889]);
imagesc(centers,1:size(dp,1),dp1,dprimesvalues)

% imagesc(centers,1:size(dp,1),dp1,[-3 3])
xlim(xlimit)
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('SC neurons')
set(gca,'YTick',[1 100 193])
title('d'' SC')
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
set(gca,'FontSize',24)



















dp=dp_choice;


% 
% %%% sort neurons
% [~,indmax]=max(abs(dp_ap),[],2);
% [~,indsort]=sort(indmax);
dp=dp(indsort,:);



%%% normalize dprimes
sigo=sign(dp);
dp=abs(dp);
dp=dp-minval; 
dp(dp<0)=0;
maxval_use=maxval-minval; 
dp(dp>maxval_use)=maxval_use;
dp=dp/maxval_use;
dp2=dp.*sigo;
%%% plot!



figure('units','normalized','position',[.15 0 .2 .5])
imagesc(centers,1:size(dp,1),dp2,dprimesvalues)
xlim(xlimit)
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('SC neurons')
set(gca,'YTick',[1 100 193])
title('d'' SC')
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
set(gca,'FontSize',24)




return







figure('units','normalized','position',[0 .5 .5 .1])

xs=linspace(-1,1,1000);
dp=linspace(-1,1,1000);

sigo=sign(dp);
dp=abs(dp);
minval=abs(tinv(0.05,98)/sqrt(50)); %significant p<=0.05
maxval=1;
dp=dp-minval; 
dp(dp<0)=0;
maxval_use=maxval-minval; 
dp(dp>maxval_use)=maxval_use;
dp=dp/maxval_use;
dp=dp.*sigo;


% hold on
imagesc(xs,1,dp,dprimesvalues)
box off
set(gca,'XTick',-1:.5:1)
set(gca,'YTick',[]);
set(gca,'TickDir','out')
set(gca,'FontSize',14)


a=[linspace(1,0,32) linspace(0,40/255,32)]' ;
b=[linspace(125/255,0,32) linspace(0,110/255,32)]' ;
c=[linspace(36/255,0,32) linspace(0,1,32)]' ;

co=[a b c];
colormap(co);

ind=find(dp==0);
ind1=ind(1);
ind2=ind(end);
hold on
plot(xs([ind1 ind1])-0.001,ylim,'w-')
plot(xs([ind2 ind2])+0.001,ylim,'w-')









%%%%%%%%%%% FIRST NEURON %%%%%%%%%%%



%%% find index of example neuron
val_index=indsort(indneur1);

%reload centers without shift (will be shifted by plot_example_neuron)
centers_shifted=centers;
load data_files/matsc centers


figure('units','normalized','position',[0 .3 .5 .25])
plot_example_neuron(centers,pop,val_index)
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
plot_example_neuron(centers,pop,val_index)
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
plot_example_neuron(centers,pop,val_index)
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




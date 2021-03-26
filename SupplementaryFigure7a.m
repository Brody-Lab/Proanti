clear
clc

load data_files/matsc
load data_files/matpfc

%%% area to use
pop=matpfc;












save_figures=0;



indneur1=123;
indneur2=27;
indneur3=71;



indneur5=168


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
dp=cat(3,dp_ap,zeros(size(dp_ap)),dp_choice);
%%% sort neurons
[~,indmax]=max(abs(dp_ap),[],2);
[~,indsort]=sort(indmax);
dp=dp(indsort,:,:);
%%% normalize dprimes
dp=abs(dp);
minval=abs(tinv(0.05,98)/sqrt(50)); %significant p<=0.05
maxval=1;
dp=dp-minval;
dp(dp<0)=0;
maxval_use=maxval-minval;
dp(dp>maxval_use)=maxval_use;
dp=dp/maxval_use;
%%% plot!
% figure
figure('units','normalized','position',[.3 0 .4 1])
image(centers,1:size(dp,1),dp)
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
% colorbar
%%%% example neuron index
xa=xlim;
% plot([xa(1) xa(1)+2.9],[indneur1 indneur1]-.5,'w','LineWidth',0.5)
% plot([xa(1) xa(1)+2.9],[indneur1 indneur1]+.5,'w','LineWidth',0.5)
% hold on
% plot([xa(1) xa(1)+2.9],[indneur2 indneur2]-.5,'w','LineWidth',0.5)
% plot([xa(1) xa(1)+2.9],[indneur2 indneur2]+.5,'w','LineWidth',0.5)
% plot([xa(1) xa(1)+2.9],[indneur3 indneur3]-.5,'w','LineWidth',0.5)
% plot([xa(1) xa(1)+2.9],[indneur3 indneur3]+.5,'w','LineWidth',0.5)
set(gca,'FontSize',24)
if(save_figures)
    saveas(gcf,'figures/singleneurons_dprime_correct_sc','pdf')
end



%%% PLOT COLORMAP
frac1=maxval-minval;
frac2=minval;
tot=150;
n1=round(tot*frac1);
n2=round(tot*frac2);
lblue=[ones(1,25) linspace(1,0,25)];
lred=[linspace(0,1,25) ones(1,25)];
lstrength=linspace(1,0,n1);
ve=nan(n1,50,3);
for i=1:n1
    ve(i,:,1)=lblue*lstrength(i);
    ve(i,:,2)=0;
    ve(i,:,3)=lred*lstrength(i);
end
ve=cat(1,ve,zeros(n2,50,3));
figure('units','normalized','position',[.3 0 .3 1])
image(ve)
axis image
set(gca,'XTick',[1 50])
set(gca,'XTickLabel',{'Pro/Anti','Choice'})
set(gca,'YTick',[1 75 150])
set(gca,'YTickLabel',[1 0.5 0])
ylabel('d'' (standard deviations)')
set(gca,'TickDir','out')
hold on
plot(xlim,150-[n2 n2],'w:')
box off
set(gca,'FontSize',24)
if(save_figures)
    saveas(gcf,'figures/singleneurons_dprime_correct_colorbar','pdf')
end


return

%%%%%%%%%%% FIRST NEURON %%%%%%%%%%%



%%% find index of example neuron
val_index=indsort(indneur1);

%reload centers without shift (will be shifted by plot_example_neuron)
centers_shifted=centers;
load data_files/matsc centers


figure('units','normalized','position',[0 .3 .5 .25])
plot_example_neuron(centers,pop,val_index)
if(save_figures)
    saveas(gcf,'figures/singleneurons_examplecell1','pdf')
end




figure('units','normalized','position',[0 .5 .5 .05])
image(centers_shifted,1,dp(indneur1,:,:))
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
    saveas(gcf,'figures/singleneurons_dprime_correct_cell1','pdf')
end





%%%%%%%%%%% SECOND NEURON %%%%%%%%%%%




%%% find index of example neuron
val_index=indsort(indneur2);
figure('units','normalized','position',[0 .3 .5 .25])
plot_example_neuron(centers,pop,val_index)
if(save_figures)
    saveas(gcf,'figures/singleneurons_examplecell2','pdf')
end



figure('units','normalized','position',[0 .5 .5 .05])
image(centers_shifted,1,dp(indneur2,:,:))
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
    saveas(gcf,'figures/singleneurons_dprime_correct_cell2','pdf')
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




% ind=find(indsort==171);
figure('units','normalized','position',[0 .5 .5 .05])
image(centers_shifted,1,dp(indneur3,:,:))
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
xlim(xlim_use)
% colorbar
if(save_figures)
    saveas(gcf,'figures/singleneurons_dprime_correct_cell3','pdf')
end




% 
% 
% %%%%%%%%%%% NEW NEURON %%%%%%%%%%%
% 
% 
% 
% 
% %%% find index of example neuron
% val_index=indneur5;
% 
% %reload centers without shift (will be shifted by plot_example_neuron)
% centers_shifted=centers;
% load data_files/matsc centers
% 
% figure
% 
% % figure('units','normalized','position',[0 .3 .5 .25])
% plot_example_neuron(centers,pop,val_index)
% if(save_figures)
%     saveas(gcf,'figures/singleneurons_examplecell1','pdf')
% end
% 
% 

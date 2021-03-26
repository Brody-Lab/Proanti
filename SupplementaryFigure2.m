clear
clc
close all
load cde_sorting


load data_files/baseline_pop_sc
cece=centers;
ind=1:40; %before cue
base=matsc(:,ind,:,:,:);
mu=mean(base(:,:),2);
st=std(base(:,:),[],2);


% 
% % base=matsc;
% load data_files/matsc
% load data_files/matpfc




% load data_files/matsc
%%% area to use
pop=matsc;



pop=(pop-repmat(mu,[1 141 25 2 2]))./(.1+repmat(st,[1 141 25 2 2]));


% 
[~,indsort]=sort(indmax);
% pop=pop(indsort,:,:,:,:);





pro=squeeze(pop(:,:,:,1,:));
pro=mean(pro(:,:,:),3);


anti=squeeze(pop(:,:,:,2,:));
anti=mean(anti(:,:,:),3);

% ind=indsort(indneur1)
% figure
% hold on
% plot(cece,pro(ind,:),'b')
% plot(cece,anti(ind,:),'r')
% xlim([-.2 1.5])
% 
% % 
% % ind=indneur2;
% % figure
% % hold on
% % plot(cece,pro(ind,:),'b')
% % plot(cece,anti(ind,:),'r')
% % 
% 
% ind=indsort(indneur3)
% figure
% hold on
% plot(cece,pro(ind,:),'b')
% plot(cece,anti(ind,:),'r')
% xlim([-.2 1.5])


% 
% load data_files/indices_subpopulations 
% figure
% for i=1:29
%     subplot(6,5,i)    
%     hold on
%     plot(cece,pro(ind1(i),:),'b')
%     plot(cece,anti(ind1(i),:),'r')
%     set(gca,'XTick',[],'YTick',[]);
%     xlim([-.2 1.5])
%     title(ind1(i))
% end
% 
% % 
% % 
% load data_files/indices_subpopulations 
% figure
% for i=1:45
%     subplot(8,6,i)    
%     hold on
%     plot(cece,pro(ind2(i),:),'b')
%     plot(cece,anti(ind2(i),:),'r')
%     set(gca,'XTick',[],'YTick',[]);
%     xlim([-.2 2.5])
%     title(ind2(i))
% end
% % 
% 
% ind1
% ind2


% 
% pro:
% 40 94 101 104 175 190 171 179 44 45
% 
% 
% anti:
% 29 30 84 88 99 109 122 123 177 126 182
% 
% 32 151 163 159
% 
% pro_units=[40  101 104  190 171 179 44 45];

% 
% pro_units=[40  101 190 179 44 45];


% pro_units=[115  101 44 45 23 ...
%     99 126 33 100 151];


pro_units=[115  101 44 45 23 ...
    99 177 33 100 151];

figure
for i=1:10
    subplot(2,5,i)    
    hold on
    plot(cece,pro(pro_units(i),:),'b','LineWidth',2)
    plot(cece,anti(pro_units(i),:),'r','LineWidth',2)
%     set(gca,'XTick',[],'YTick',[]);
    xlim([-.2 2.5])
    plot([0 0],ylim,'k')
    plot([1 1],ylim,'k')
    plot([1.5 1.5],ylim,'k')    
    title(pro_units(i))
    box off
    set(gca,'TickDir','out')
    set(gca,'FontSize',24')
end



figure
imagesc(cece,1:193,pro,[-2 2])
colorbar
colormap viridis
xlim([-0.5 2.5]) 
title('Pro trials')
box off
set(gca,'TickDir','out')
set(gca,'FontSize',24')  



figure
imagesc(cece,1:193,anti,[-2 2])
colorbar
colormap viridis
xlim([-0.5 2.5])
title('Anti trials')
box off
set(gca,'TickDir','out')
set(gca,'FontSize',24')


% 
% figure
% imagesc(cece,1:193,(pro(indsort,:)+anti(indsort,:))/2,[-2 2])
% colorbar
% colormap jet
% xlim([-0.5 2.5])

return
% 
% figure
% plot(cece,mean(pro),'b')
% 
% hold on
% plot(cece,mean(anti),'r')

ba=[pro(:,42:end) anti(:,42:end)];
u=min(ba,[],2);
ind=find(u>-.2);

% u=max(ba,[],2);
% ind=find(u<.2);


figure; plot(cece,pro(ind,:))
figure; plot(cece,anti(ind,:))




return



anti=squeeze(pop(:,:,:,2,:));
anti=mean(anti(:,:,:),3);




return
anti=squeeze(pop(:,:,:,2,:));
anti=anti(:,:,:);
%%%% numerator : difference
num=mean(pro,3)-mean(anti,3);

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





figure('units','normalized','position',[.3 0 .4 1])
imagesc(centers,1:size(dp,1),dp1,dprimesvalues)
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
%%%% example neuron index
% xa=xlim;
% plot([xa(1) xa(1)+2.9],[indneur1 indneur1]-.5,'w','LineWidth',0.5)
% plot([xa(1) xa(1)+2.9],[indneur1 indneur1]+.5,'w','LineWidth',0.5)
% hold on
% plot([xa(1) xa(1)+2.9],[indneur2 indneur2]-.5,'w','LineWidth',0.5)
% plot([xa(1) xa(1)+2.9],[indneur2 indneur2]+.5,'w','LineWidth',0.5)
% plot([xa(1) xa(1)+2.9],[indneur3 indneur3]-.5,'w','LineWidth',0.5)
% plot([xa(1) xa(1)+2.9],[indneur3 indneur3]+.5,'w','LineWidth',0.5)
set(gca,'FontSize',24)
% if(save_figures)
%     saveas(gcf,'aaa1','pdf')
% end


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

a=[linspace(1,0,32) linspace(0,0,32)]' ;
b=[linspace(0,0,32) linspace(0,1,32)]' ;
c=[linspace(0,0,32) linspace(0,0,32)]' ;
co=[a b c];
colormap(co);


ind=find(dp==0);
ind1=ind(1);
ind2=ind(end);
hold on
plot(xs([ind1 ind1])-0.001,ylim,'w-')
plot(xs([ind2 ind2])+0.001,ylim,'w-')











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




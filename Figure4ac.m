clear
clc

close all
plot_figures=1;
save_figures=0;
cout_time_delay=0.127;


load data_files/matsc
pop=matsc;
pop_err_ap=matsc_err_ap;
pop_err_choice=matsc_err_choice;
waves=waves_sc;


[dp_ap,pvals_ap,dp_choice,pvals_choice] = compute_dprimes_correct(pop);

%%% CONTRA PREFERRING VS IPSI PREFERRING
a=dp_choice(:,82);  %t=0.125
p=pvals_choice(:,82);
% 
% ind_contra=find(a>0 & p<0.1);
% ind_ipsi=find(a<0 & p<0.1);

ind_contra=find(a>0 & p<0.05);
ind_ipsi=find(a<0 & p<0.05);


load data_files/indices_subpopulations
ind_contra=intersect(ind_contra,ind2);
ind_ipsi=intersect(ind_ipsi,ind2);






% pop_use=pop;
% neurtype='all';
% plot_dprime_ap_choice(centers,pop_use,neurtype);



pop_use=pop(ind_contra,:,:,:,:);
neurtype='contra';
plot_dprime_ap_choice2_centered(centers,pop_use,neurtype);



% 
% return


pop_use=pop(ind_ipsi,:,:,:,:);
neurtype='ipsi';
plot_dprime_ap_choice2_centered(centers,pop_use,neurtype);













%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
% centers_back=0.125;
centers_back=0;
centers2=centers+centers_back;










x=centers2;
ind=find(x>=-0.2 & x<=0.7);
x=x(ind);






figure


subplot(4,1,1)


hold on

plot(1,1,'Color',[0 0 1],'LineWidth',1.5)

plot(1,1,'Color',[1 0 0],'LineWidth',1.5)

a=squeeze(mean(mean(pop(ind_contra,:,:,:),1),3));
as=squeeze(mean(std(pop(ind_contra,:,:,:),[],3),1))/sqrt(50);
a=a/.25;
as=as/.25;

vec=mean(a(:,1:2),2)'-mean(a(:,3:4),2)';
vecs=(mean(as(:,1:2),2)'+mean(as(:,3:4),2)')/2;
vec=vec(ind);
vecs=vecs(ind);
y1=vec;
y2=vecs;
vec1=y1+y2;
vec2=y1-y2;
plot(x,y1,'Color',[0 0 1],'LineWidth',1.5)
plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[0 0 1],'LineWidth',1)


% 
% vec=mean(a(:,3:4),2)';
% vecs=mean(as(:,3:4),2)';
% vec=vec(ind);
% vecs=vecs(ind);
% y1=vec;
% y2=vecs;
% vec1=y1+y2;
% vec2=y1-y2;
% plot(x,y1,'Color',[1.0000    0.4902    0.1412],'LineWidth',1.5)
% plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[1.0000    0.4902    0.1412],'LineWidth',1)




hold on
plot(xlim,[0 0],'k--')
%%%% 1, 3 , 2 , 4
% legend('contra','ipsi',...
%     'Location','NorthWest');
xlim([-0.175 0.7]);
ylim([-20 20])
title('Pro-Contra neurons')
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('Firing rate (Hz)')
%%%% cout
hold on
plot([0 0],ylim,'k')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'k')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'k')


set(gca,'XTick',0:0.2:0.6);








subplot(4,1,2)
hold on

plot(1,1,'Color',[0 0 1],'LineWidth',1.5)

plot(1,1,'Color',[1 0 0],'LineWidth',1.5)


a=squeeze(mean(mean(pop(ind_contra,:,:,:),1),3));
as=squeeze(mean(std(pop(ind_contra,:,:,:),[],3),1))/sqrt(25);
a=a/.25;
as=as/.25;


vec=mean(a(:,[1 3]),2)'-mean(a(:,[2 4]),2)';
vecs=(mean(as(:,[1 3]),2)'+mean(as(:,[2 4]),2)')/2;
vec=vec(ind);
vecs=vecs(ind);
y1=vec;
y2=vecs;
vec1=y1+y2;
vec2=y1-y2;
plot(x,y1,'Color',[0 0.7 0],'LineWidth',1.5)
plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[0 0.7 0],'LineWidth',1)


% 
% vec=mean(a(:,[2 4]),2)';
% vecs=mean(as(:,[2 4]),2)';
% vec=vec(ind);
% vecs=vecs(ind);
% y1=vec;
% y2=vecs;
% vec1=y1+y2;
% vec2=y1-y2;
% plot(x,y1,'Color',[1 0 0],'LineWidth',1.5)
% plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[1 0 0],'LineWidth',1)



hold on
plot(xlim,[0 0],'k--')

%%%% 1, 3 , 2 , 4
% legend('pro','anti',...
%     'Location','NorthWest');
xlim([-0.175 0.7]);
ylim([-13 13])
title('Pro-Contra neurons')
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('Firing rate (Hz)')
%%%% cout
hold on
plot([0 0],ylim,'k')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'k')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'k')


set(gca,'XTick',0:0.2:0.6);






% 
% 
% figure
% hold on
% 
% plot(1,1,'Color',[0 0 1],'LineWidth',1.5)
% 
% plot(1,1,'Color',[0 1 1],'LineWidth',1.5)
% 
% plot(1,1,'Color',[1 0 0],'LineWidth',1.5)
% 
% plot(1,1,'Color',[1 1.1*150/255 1.1*180/255],'LineWidth',1.5)
% 
% a=squeeze(mean(mean(pop(ind_contra,:,:,:),1),3));
% as=squeeze(mean(std(pop(ind_contra,:,:,:),[],3),1))/sqrt(25);
% a=a/.25;
% as=as/.25;
% 
% vec=a(:,1)';
% vecs=as(:,1)';
% vec=vec(ind);
% vecs=vecs(ind);
% y1=vec;
% y2=vecs;
% vec1=y1+y2;
% vec2=y1-y2;
% plot(x,y1,'Color',[0 0 1],'LineWidth',1.5)
% plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[0 0 1],'LineWidth',1)
% 
% 
% 
% vec=a(:,3)';
% vecs=as(:,3)';
% vec=vec(ind);
% vecs=vecs(ind);
% y1=vec;
% y2=vecs;
% vec1=y1+y2;
% vec2=y1-y2;
% plot(x,y1,'Color',[0 1 1],'LineWidth',1.5)
% plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[0 1 1],'LineWidth',1)
% 
% 
% 
% 
% vec=a(:,2)';
% vecs=as(:,2)';
% vec=vec(ind);
% vecs=vecs(ind);
% y1=vec;
% y2=vecs;
% vec1=y1+y2;
% vec2=y1-y2;
% plot(x,y1,'Color',[1 0 0],'LineWidth',1.5)
% plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[1 0 0],'LineWidth',1)
% 
% 
% 
% vec=a(:,4)';
% vecs=as(:,4)';
% vec=vec(ind);
% vecs=vecs(ind);
% y1=vec;
% y2=vecs;
% vec1=y1+y2;
% vec2=y1-y2;
% plot(x,y1,'Color',[1 1.1*150/255 1.1*180/255],'LineWidth',1.5)
% plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[1 1.1*150/255 1.1*180/255],'LineWidth',1)
% 
% 
% 
% %%%% 1, 3 , 2 , 4
% legend('pro trial; contra stim','pro trial; ipsi stim','anti trial; contra stim',...
%     'anti trial; ipsi stim',...
%     'Location','NorthWest');
% xlim([-0.15 0.7]);
% ylim([0 38])
% title('Pro-Contra neurons')
% set(gca,'TickDir','out')
% box off
% xlabel('Time from stimulus onset (s)')
% ylabel('Firing rate (Hz)')
% %%%% cout
% hold on
% plot([0 0],ylim,'k')
% hold on
% %%%% start of delay
% plot([0 0]-(0.5+cout_time_delay),ylim,'k')
% hold on
% %%%% start of cue stimulus
% plot([0 0]-(1.5+cout_time_delay),ylim,'k')











% f=figure;set(f,'Position',[440 378 560 220]);

subplot(4,1,3)
hold on


plot(1,1,'Color',[0 0 1],'LineWidth',1.5)


plot(1,1,'Color',[1 0 0],'LineWidth',1.5)


a=squeeze(mean(mean(pop(ind_ipsi,:,:,:),1),3));
as=squeeze(mean(std(pop(ind_ipsi,:,:,:),[],3),1))/sqrt(25);
a=a/.25;
as=as/.25;


vec=mean(a(:,1:2),2)'-mean(a(:,3:4),2)';
vecs=(mean(as(:,1:2),2)'+mean(as(:,3:4),2)')/2;
vec=vec(ind);
vecs=vecs(ind);
y1=vec;
y2=vecs;
vec1=y1+y2;
vec2=y1-y2;
plot(x,y1,'Color',[0 0 1],'LineWidth',1.5)
plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[0 0 1],'LineWidth',1)


% 
% vec=mean(a(:,[3 4]),2)';
% vecs=mean(as(:,[3 4]),2)';
% vec=vec(ind);
% vecs=vecs(ind);
% y1=vec;
% y2=vecs;
% vec1=y1+y2;
% vec2=y1-y2;
% plot(x,y1,'Color',[1.0000    0.4902    0.1412],'LineWidth',1.5)
% plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[1.0000    0.4902    0.1412],'LineWidth',1)




hold on
plot(xlim,[0 0],'k--')

% legend('contra','ipsi',...
%     'Location','NorthWest');
xlim([-0.175 0.7]);
ylim([-20 20])
title('Anti-Ipsi neurons')
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('Firing rate (Hz)')
%%%% cout
hold on
plot([0 0],ylim,'k')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'k')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'k')



set(gca,'XTick',0:0.2:0.6);















% f=figure;set(f,'Position',[440 378 560 220]);

subplot(4,1,4)
hold on


plot(1,1,'Color',[0 0 1],'LineWidth',1.5)


plot(1,1,'Color',[1 0 0],'LineWidth',1.5)


a=squeeze(mean(mean(pop(ind_ipsi,:,:,:),1),3));
as=squeeze(mean(std(pop(ind_ipsi,:,:,:),[],3),1))/sqrt(25);
a=a/.25;
as=as/.25;


vec=mean(a(:,[1 3]),2)'-mean(a(:,[2 4]),2)';
vecs=(mean(as(:,[1 3]),2)'+mean(as(:,[2 4]),2)')/2;

vec=vec(ind);
vecs=vecs(ind);
y1=vec;
y2=vecs;
vec1=y1+y2;
vec2=y1-y2;
plot(x,y1,'Color',[0 0.7 0],'LineWidth',1.5)
plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[0 0.7 0],'LineWidth',1)


% 
% vec=mean(a(:,[2 4]),2)';
% vecs=mean(as(:,[2 4]),2)';
% vec=vec(ind);
% vecs=vecs(ind);
% y1=vec;
% y2=vecs;
% vec1=y1+y2;
% vec2=y1-y2;
% plot(x,y1,'Color',[1 0 0],'LineWidth',1.5)
% plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[1 0 0],'LineWidth',1)


hold on
plot(xlim,[0 0],'k--')


% legend('pro','contra',...
%     'Location','NorthWest');
xlim([-0.175 0.7]);
ylim([-18 18])
title('Anti-Ipsi neurons')
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('Firing rate (Hz)')
%%%% cout
hold on
plot([0 0],ylim,'k')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'k')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'k')





set(gca,'XTick',0:0.2:0.6);











% figure
% hold on
% 
% 
% plot(1,1,'Color',[0 0 1],'LineWidth',1.5)
% 
% plot(1,1,'Color',[0 1 1],'LineWidth',1.5)
% 
% plot(1,1,'Color',[1 0 0],'LineWidth',1.5)
% 
% plot(1,1,'Color',[1 1.1*150/255 1.1*180/255],'LineWidth',1.5)
% 
% 
% a=squeeze(mean(mean(pop(ind_ipsi,:,:,:),1),3));
% as=squeeze(mean(std(pop(ind_ipsi,:,:,:),[],3),1))/sqrt(25);
% a=a/.25;
% as=as/.25;
% 
% 
% vec=a(:,1)';
% vecs=as(:,1)';
% vec=vec(ind);
% vecs=vecs(ind);
% y1=vec;
% y2=vecs;
% vec1=y1+y2;
% vec2=y1-y2;
% plot(x,y1,'Color',[0 0 1],'LineWidth',1.5)
% plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[0 0 1],'LineWidth',1)
% 
% 
% 
% vec=a(:,3)';
% vecs=as(:,3)';
% vec=vec(ind);
% vecs=vecs(ind);
% y1=vec;
% y2=vecs;
% vec1=y1+y2;
% vec2=y1-y2;
% plot(x,y1,'Color',[0 1 1],'LineWidth',1.5)
% plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[0 1 1],'LineWidth',1)
% 
% 
% 
% 
% vec=a(:,2)';
% vecs=as(:,2)';
% vec=vec(ind);
% vecs=vecs(ind);
% y1=vec;
% y2=vecs;
% vec1=y1+y2;
% vec2=y1-y2;
% plot(x,y1,'Color',[1 0 0],'LineWidth',1.5)
% plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[1 0 0],'LineWidth',1)
% 
% 
% 
% vec=a(:,4)';
% vecs=as(:,4)';
% vec=vec(ind);
% vecs=vecs(ind);
% y1=vec;
% y2=vecs;
% vec1=y1+y2;
% vec2=y1-y2;
% plot(x,y1,'Color',[1 1.1*150/255 1.1*180/255],'LineWidth',1.5)
% plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],'Color',[1 1.1*150/255 1.1*180/255],'LineWidth',1)
% 
% 
% 
% legend('pro trial; contra stim','pro trial; ipsi stim','anti trial; contra stim',...
%     'anti trial; ipsi stim',...
%     'Location','NorthWest');
% xlim([-0.15 0.7]);
% ylim([0 38])
% title('Anti-Ipsi neurons')
% set(gca,'TickDir','out')
% box off
% xlabel('Time from stimulus onset (s)')
% ylabel('Firing rate (Hz)')
% %%%% cout
% hold on
% plot([0 0],ylim,'k')
% hold on
% %%%% start of delay
% plot([0 0]-(0.5+cout_time_delay),ylim,'k')
% hold on
% %%%% start of cue stimulus
% plot([0 0]-(1.5+cout_time_delay),ylim,'k')
% 








% 
% 

% 
% 
% pval=0.05;
% 
% pop_use=pop(ind_contra,:,:,:,:);
% neurtype='contra';
% plot_dprime_ap_choice_multiplex(centers,pop_use,neurtype,pval);
% 
% 
% 
% 
% pop_use=pop(ind_ipsi,:,:,:,:);
% neurtype='ipsi';
% plot_dprime_ap_choice_multiplex(centers,pop_use,neurtype,pval);



% 
% pop_use=pop(ind_contra,:,:,:,:);
% neurtype='contra';
% plot_dprime_ap_choice_thresholded(centers,pop_use,neurtype,pval);
% 
% 
% pop_use=pop(ind_ipsi,:,:,:,:);
% neurtype='ipsi';
% plot_dprime_ap_choice_thresholded(centers,pop_use,neurtype,pval);
% 
% 
% 
% 
% 
% 
% 
% 

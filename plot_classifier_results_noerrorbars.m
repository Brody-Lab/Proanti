function [] = plot_classifier_results_noerrorbars(x,res,colo,xlimit,ylimit)


%%%% median delay between end_of_delay and cout (computed using step0_compute_timing.m in preparatory_code)
cout_time_delay=0.127;

%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
x=x+centers_back;
xlimit=xlimit+centers_back;

ind=find(x>=xlimit(1) & x<=xlimit(2));
x=x(ind);
res=res(:,ind);




y1=mean(res);

%%% plot!
plot(x,y1,colo,'LineWidth',1.5)
hold on

xlim(xlimit)
ylim(ylimit)
set(gca,'TickDir','out')
box off


plot(xlim,[0.5 0.5],'k--')
hold on
xlabel('Time from stimulus onset (s)')
ylabel('Population performance')
set(gca,'FontSize',24)
set(gca,'LineWidth',2)
%%%% cout
plot([0 0],ylim,'k')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'k')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'k')
% legend('choice','pro/anti','Location','Best')
% legend BOXOFF




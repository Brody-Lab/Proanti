function [] = plot_dprime_results2_centered(x,dp,minval,maxval)


%%%% median delay between end_of_delay and cout (computed using step0_compute_timing.m in preparatory_code)
cout_time_delay=0.127;

xlimit=[0 0.7];


%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0;
x=x+centers_back;
% xlimit=xlimit+centers_back;

% 
% ind=find(x>=xlimit(1) & x<=xlimit(2));
% x=x(ind);
% dp=dp(:,ind);

if(minval>=0)
    si=sign(dp);
    dp=abs(dp);
    dp=dp-minval;
    dp(dp<0)=0;
    maxval_use=maxval-minval;
    dp(dp>maxval_use)=maxval_use;
    dp=dp/maxval_use;
    dp=si.*dp;
end

% figure
imagesc(x,1:size(dp,1),dp,[-maxval maxval])
xlim(xlimit)
set(gca,'TickDir','out','YTick',[])
box off
xlabel('Time from stimulus onset (s)')
ylabel('SC neurons')
set(gca,'FontSize',24)
a=linspace(1,0,64)';
b=[linspace(0,0.5,32) linspace(0.5,0,32)]';
c=linspace(0,1,64)';

% a=[linspace(1,0,32) zeros(1,32)]';
% b=zeros(1,64)';
% c=[zeros(1,32) linspace(0,1,32)]';

co=[a b c];
colormap(co)
hold on
% plot([0 0],ylim,'w')
% plot([0 0]-(0.5+cout_time_delay),ylim,'w')
% plot([0 0]-(1.5+cout_time_delay),ylim,'w')

colorbar


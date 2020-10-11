function [] = plot_example_neuron(x,pop,val_index)


%%%% median delay between end_of_delay and cout (computed using step0_compute_timing.m in preparatory_code)
cout_time_delay=0.127;

xlimit=[-1.9 0.7];

%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
x=x+centers_back;
xlimit=xlimit+centers_back;

a=squeeze(mean(pop,3));
as=squeeze(std(pop,[],3))/sqrt(25);

%%% turn spike counts into firing rates
a=a/.25;
as=as/.25;
ind=find(x>=xlimit(1) & x<=xlimit(2));
x=x(ind);
a=a(:,ind,:,:);
as=as(:,ind,:,:);


plot(1,1,'b-')
hold on
plot(1,1,'r-')
hold on
plot(1,1,'b--')
hold on
plot(1,1,'r--')
hold on

vec=squeeze(a(val_index,:,1,1));
vecs=squeeze(as(val_index,:,1,1));
colo='b-';
y1=vec;
y2=vecs;
vec1=y1+y2;
vec2=y1-y2;
plot(x,y1,colo,'LineWidth',1.5)
hold on
plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],colo,'LineWidth',1)
hold on



vec=squeeze(a(val_index,:,1,2));
vecs=squeeze(as(val_index,:,1,2));
colo='r-';
y1=vec;
y2=vecs;
vec1=y1+y2;
vec2=y1-y2;
plot(x,y1,colo,'LineWidth',1.5)
hold on
plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],colo,'LineWidth',1)
hold on


vec=squeeze(a(val_index,:,2,1));
vecs=squeeze(as(val_index,:,2,1));
colo='b--';
y1=vec;
y2=vecs;
vec1=y1+y2;
vec2=y1-y2;
plot(x,y1,colo,'LineWidth',1.5)
hold on
plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],colo,'LineWidth',1)
hold on


vec=squeeze(a(val_index,:,2,2));
vecs=squeeze(as(val_index,:,2,2));
colo='r--';
y1=vec;
y2=vecs;
vec1=y1+y2;
vec2=y1-y2;
plot(x,y1,colo,'LineWidth',1.5)
hold on
plot([x x(end:-1:1) x(1)],[vec1 vec2(end:-1:1) vec1(1)],colo,'LineWidth',1)
hold on

hold on

legend('Pro contra','Pro ipsi','Anti contra','Anti ipsi','Location','Best')


% legend('choice','pro/anti','Location','Best')
legend BOXOFF
title('SC neuron')
xlim(xlimit)
% ylim([-0.1 20])
% ylim([-0.1 140])

mi=-0.1;
ma=a(val_index,:,:,:);
ma=max(ma(:))+10;
ylim([mi ma]);



set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('Firing rate (Hz)')
set(gca,'FontSize',24)

va=ylim;


%%%% cout
hold on
plot([0 0],ylim,'k')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'k')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'k')


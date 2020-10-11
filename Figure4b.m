clear
clc
% close all

load data_files/matsc
load data_files/matpfc

%%% area to use
pop=matsc;

[dp_ap,~,dp_choice,pvals_choice] = compute_dprimes_correct(pop);



load data_files/indices_subpopulations


figure
 
hold on

%%% CONTRA PREFERRING VS IPSI PREFERRING
a=dp_ap(ind2,82);  %t=0.2
b=dp_choice(ind2,82);
p=pvals_choice(ind2,82);

plot(a,b,'.k','MarkerSize',30)

xlabel('d'' pro-anti')
ylabel('d'' contra-ipsi')
set(gca,'TickDir','out')
box off
xlim([-2 2])
ylim([-2 2])
set(gca,'XTick',-2:1:2,'YTick',-2:1:2)

corr(a,b)
% axis square




% a=dp_choice(ind2,82);  %t=0.125
% p=pvals_choice(ind2,82);
% 
ind_contra=find(b>0 & p<0.05);
ind_ipsi=find(b<0 & p<0.05);

% ind_contra=find(a>0 & p<0.05);
% ind_ipsi=find(a<0 & p<0.05);



% 
% ind_contra=find(b>=0);
% ind_ipsi=find(b<0);

% ind_pro=find(a>=0);
% ind_anti=find(a<0);


% figure
hold on
%%% CONTRA PREFERRING VS IPSI PREFERRING
plot(a(ind_contra),b(ind_contra),'.b','MarkerSize',30)
plot(a(ind_ipsi),b(ind_ipsi),'.r','MarkerSize',30)
% plot(a(ind_pro),b(ind_pro),'og','MarkerSize',10)
% plot(a(ind_anti),b(ind_anti),'om','MarkerSize',10)
xlabel('d'' pro-anti')
ylabel('d'' contra-ipsi')
set(gca,'TickDir','out')
box off
xlim([-2 2])
ylim([-2 2])
set(gca,'XTick',-2:1:2,'YTick',-2:1:2)
corr(a,b)
% % axis square
set(gca,'FontSize',24)

axis square


set(gca,'FontSize',24)



xlabel('pro/anti')
ylabel('contra/ipsi')
% legend(rai)

hold on



plot(xlim,[0 0],'k--','LineWidth',2)
plot([0 0],ylim,'k--','LineWidth',2)

set(gca,'TickDir','out','XTick',[-2:1:2],'YTick',[-2:1:2])
set(gca,'FontSize',24)
box off

axis square

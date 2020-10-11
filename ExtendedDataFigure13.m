clear
clc
close all

%%% for all populations use classifier results
%%% with 29 neurons

load data_files/svm_results_sc
load data_files/svm_results_pfc
load data_files/svm_results_fof

res_choice_sc_full=res_choice_sc;
res_choice_pfc_full=res_choice_pfc;
res_choice_fof_full=res_choice_fof;


load data_files/svm_results_choice_subpopulations
res_svm1_choice=res_svm1;
res_svm2_choice=res_svm2;

load data_files/svm_results_pfc_comparesubpop res_choice_pfc
res_svm3_choice=res_choice_pfc;

load data_files/svm_results_fof_comparesubpop res_choice_fof
res_svm4_choice=res_choice_fof;

% 

load data_files/svm_results_sc29
load data_files/svm_results_pfc29
load data_files/svm_results_fof29


%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers=centers+centers_back;


figure
hold on


plot(centers,mean(res_choice_sc),'b','LineWidth',3)
plot(centers,mean(res_choice_fof),'r','LineWidth',3)
plot(centers,mean(res_choice_pfc),'k','LineWidth',3)

plot(centers,mean(res_svm1_choice),'g','LineWidth',3)
plot(centers,mean(res_svm2_choice),'c','LineWidth',3)
plot([-1.775 0.875],[.65 .65],'k--','LineWidth',3)
xlim([-.4 0.875]);
ylim([.45 1])
box off
set(gca,'TickDir','out','FontSize',24)

x=linspace(0,0.8,500);
y = interp1(centers,mean(res_choice_sc),x);
[~,ind]=min(abs(y-0.65));
plot(x(ind),y(ind),'b.','MarkerSize',50);

y = interp1(centers,mean(res_choice_fof),x);
[~,ind]=min(abs(y-0.65));
plot(x(ind),y(ind),'r.','MarkerSize',50);

y = interp1(centers,mean(res_choice_pfc),x);
[~,ind]=min(abs(y-0.65));
plot(x(ind),y(ind),'k.','MarkerSize',50);

y = interp1(centers,mean(res_svm1_choice),x);
[~,ind]=min(abs(y-0.65));
plot(x(ind),y(ind),'g.','MarkerSize',50);

y = interp1(centers,mean(res_svm2_choice),x);
[~,ind]=min(abs(y-0.65));
plot(x(ind),y(ind),'c.','MarkerSize',50);

legend('SC','FOF','PFC','SC Delay/Choice','SC cue');











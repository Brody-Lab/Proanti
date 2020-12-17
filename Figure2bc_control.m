clear
clc
close all

load data_files/svm_results_sc_control


%%% x axis limit (time)
xlimit=[-1.9 0.7];

%%% y axis limit (performance)
ylimit=[0.35 1.02];


%%%%%%%%% COMPARE SC AND PFC - PRO/ANTI
figure;
plot_classifier_results(centers,res_ap_sc_ipsi,'r',xlimit,ylimit)

title('Task: pro vs anti ipsi')
legend('SC','PFC','Location','Best')
legend BOXOFF


%%%%%%%%% COMPARE SC AND PFC - PRO/ANTI
figure;
plot_classifier_results(centers,res_ap_sc_contra,'r',xlimit,ylimit)

title('Task: pro vs anti contra')
legend('SC','PFC','Location','Best')
legend BOXOFF


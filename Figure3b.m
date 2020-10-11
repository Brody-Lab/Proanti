clear
clc
close all
load data_files/svm_results_subpopulations_error
% load data_files/svm_results_subpopulations_error2



save_figures=0;


%%% x axis limit (time)
xlimit=[-1.9 0.7];

%%% y axis limit (performance)
ylimit=[0 1.02];


%%%%%%%%% PLOT RESULTS SC - AP
figure
plot_classifier_results(centers,res_ap_sc,'b',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_ap_sc_err,'r',xlimit,ylimit)
title('SC')
legend('correct','error','Location','Best')
legend BOXOFF
if(save_figures)
    saveas(gcf,'figures/classifier_error_sc_ap','pdf')
end








clear
clc

% load data_files/svm_results_subpopulations_error
load data_files/svm_results_subpopulations_error2



save_figures=0;


%%% x axis limit (time)
xlimit=[-1.9 0.7];

%%% y axis limit (performance)
ylimit=[0 1.02];


%%%%%%%%% PLOT RESULTS SC - AP
figure
plot_classifier_results(centers,res_ap_sc,'b',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_ap_sc_err,'r',xlimit,ylimit)
title('SC')
legend('correct','error','Location','Best')
legend BOXOFF
if(save_figures)
    saveas(gcf,'figures/classifier_error_sc_ap','pdf')
end








return

%%% y axis limit (performance)
ylimit=[-.02 1.02];

%%%%%%%%% PLOT RESULTS SC - CHOICE
figure
plot_classifier_results(centers,res_choice_sc,'b',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_choice_sc_err,'r',xlimit,ylimit)
title('SC')
legend('correct','error','Location','Best')
legend BOXOFF
if(save_figures)
    saveas(gcf,'figures/classifier_error_sc_choice','pdf')
end




%%% y axis limit (performance)
ylimit=[0.2 1.02];


%%%%%%%%% PLOT RESULTS PFC - AP
figure
plot_classifier_results(centers,res_ap_pfc,'b',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_ap_pfc_err,'r',xlimit,ylimit)
title('SC')
legend('correct','error','Location','Best')
legend BOXOFF
if(save_figures)
    saveas(gcf,'figures/classifier_error_pfc_ap','pdf')
end


%%% y axis limit (performance)
ylimit=[-.02 1.02];

%%%%%%%%% PLOT RESULTS PFC - CHOICE
figure
plot_classifier_results(centers,res_choice_pfc,'b',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_choice_pfc_err,'r',xlimit,ylimit)
title('SC')
legend('correct','error','Location','Best')
legend BOXOFF
if(save_figures)
    saveas(gcf,'figures/classifier_error_pfc_choice','pdf')
end



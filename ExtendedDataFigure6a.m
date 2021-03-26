
clear
clc

load data_files/svm_results_sc
load data_files/svm_results_sc_stim
load data_files/svm_results_pfc
load data_files/svm_results_pfc_stim


save_figures=0;


%%% x axis limit (time)
xlimit=[-1.9 0.7];

%%% y axis limit (performance)
ylimit=[0.3 1.05];



%%%%%%%%% COMPARE SC AND PFC - PRO/ANTI
figure;
plot_classifier_results(centers,res_ap_sc,'r',xlimit,ylimit)

hold on
plot_classifier_results(centers,res_choice_sc,'b-',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_stim_sc,'k-',xlimit,ylimit)
title('Task: pro vs anti')
% legend('SC','PFC','Location','Best')
legend BOXOFF
% ax = gca;
% ax.Position = [0.1300 0.1437 0.7750 0.45];
if(save_figures)
    saveas(gcf,'figures/classifier_correct_ap','pdf')
end



%%%%%%%%% COMPARE SC AND PFC - PRO/ANTI
figure;
plot_classifier_results(centers,res_ap_pfc,'r',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_choice_pfc,'b-',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_stim_pfc,'k-',xlimit,ylimit)
title('Task: pro vs anti')
% legend('SC','PFC','Location','Best')
legend BOXOFF
% ax = gca;
% ax.Position = [0.1300 0.1437 0.7750 0.45];
if(save_figures)
    saveas(gcf,'figures/classifier_correct_ap','pdf')
end







%%%%%%%%% COMPARE SC AND PFC - PRO/ANTI
figure;
plot_classifier_results(centers,res_ap_sc,'r',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_ap_pfc,'r--',xlimit,ylimit)
title('Task: pro vs anti')
legend('SC','PFC','Location','Best')
legend BOXOFF
% ax = gca;
% ax.Position = [0.1300 0.1437 0.7750 0.45];
if(save_figures)
    saveas(gcf,'figures/classifier_correct_ap','pdf')
end


%%%%%%%%% COMPARE SC AND PFC - CHOICE
figure
plot_classifier_results(centers,res_choice_sc,'b',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_choice_pfc,'b--',xlimit,ylimit)
title('Task: choice')
legend('SC','PFC','Location','Best')
legend BOXOFF
% ax = gca;
% ax.Position = [0.1300 0.1437 0.7750 0.45];
if(save_figures)
    saveas(gcf,'figures/classifier_correct_choice','pdf')
end



vals=0.65;

balo1=nan(size(res_choice_sc,1),length(vals));
for i=1:size(res_choice_sc,1)
    vec=res_choice_sc(i,:);
    vec=smooth(vec)';
    for j=1:length(vals)
%         ind=find(centers>=-.125 & vec>=vals(j));
        ind=find(centers>=-.15 & vec>=vals(j));
        balo1(i,j)=centers(ind(1));
    end
end

balo2=nan(size(res_choice_pfc,1),length(vals));
for i=1:size(res_choice_pfc,1)
    vec=res_choice_pfc(i,:);
    vec=smooth(vec)';
    for j=1:length(vals)
%         ind=find(centers>=-.125 & vec>=vals(j));
        ind=find(centers>=-.15 & vec>=vals(j));
        balo2(i,j)=centers(ind(1));
    end
end

%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
balo1=balo1+centers_back;
balo2=balo2+centers_back;

mean(balo2-balo1)
std(balo2-balo1)


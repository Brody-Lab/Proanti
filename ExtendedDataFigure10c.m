clear
clc

% %this is what we use for the figure currently in paper
% load data_files/svm_results_sc_new1

%this is more correct
load data_files/svm_results_sc_new1_new
res_ap_sc2=res_ap_sc;
res_choice_sc2=res_choice_sc;

load data_files/svm_results_sc
load data_files/svm_results_pfc




vals=0.65;

balo1=nan(size(res_choice_pfc,1),length(vals));
for i=1:size(res_choice_pfc,1)
    vec=res_choice_pfc(i,:);
    vec=smooth(vec)';
    for j=1:length(vals)
%         ind=find(centers>=-.125 & vec>=vals(j));
        ind=find(centers>=-.15 & vec>=vals(j));
        balo1(i,j)=centers(ind(1));
    end
end

balo2=nan(size(res_choice_sc2,1),length(vals));
for i=1:size(res_choice_sc2,1)
    vec=res_choice_sc2(i,:);
    vec=smooth(vec)';
    for j=1:length(vals)
%         ind=find(centers>=-.125 & vec>=vals(j));
        ind=find(centers>=-.15 & vec>=vals(j));
        balo2(i,j)=centers(ind(1));
    end
end
length(find(res_ap_pfc(:,82)>res_ap_sc2(:,82)))/500

length(find(balo1<balo2))/500





save_figures=0;


%%% x axis limit (time)
xlimit=[-1.9 0.7];

%%% y axis limit (performance)
ylimit=[0.35 1.02];



%%%%%%%%% COMPARE SC AND PFC - PRO/ANTI
figure;
subplot(2,2,1)
plot_classifier_results_noerrorbars(centers,res_ap_sc2,'r-.',xlimit,ylimit)
hold on
plot_classifier_results_noerrorbars(centers,res_ap_sc,'r',xlimit,ylimit)
hold on
plot_classifier_results_noerrorbars(centers,res_ap_pfc,'r--',xlimit,ylimit)
title('Task: pro vs anti')
legend('SC','PFC','Location','Best')
legend BOXOFF
% ax = gca;
% ax.Position = [0.1300 0.1437 0.7750 0.45];
if(save_figures)
    saveas(gcf,'figures/classifier_correct_ap','pdf')
end



%%%%%%%%% COMPARE SC AND PFC - CHOICE
% figure
subplot(2,2,2)
plot_classifier_results_noerrorbars(centers,res_choice_sc2,'b-.',xlimit,ylimit)
hold on
plot_classifier_results_noerrorbars(centers,res_choice_sc,'b',xlimit,ylimit)
hold on
plot_classifier_results_noerrorbars(centers,res_choice_pfc,'b--',xlimit,ylimit)
title('Task: choice')
legend('SC','PFC','Location','Best')
legend BOXOFF
% ax = gca;
% ax.Position = [0.1300 0.1437 0.7750 0.45];
if(save_figures)
    saveas(gcf,'figures/classifier_correct_choice','pdf')
end


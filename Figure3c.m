clear
clc


load data_files/svm_results_ap_subpopulations
res_svm1_ap=res_svm1;
res_svm2_ap=res_svm2;

load data_files/svm_results_choice_subpopulations
res_svm1_choice=res_svm1;
res_svm2_choice=res_svm2;

load data_files/svm_results_pfc_comparesubpop res_choice_pfc
res_svm3_choice=res_choice_pfc;


save_figures=0;


%%% x axis limit (time)
xlimit=[-1.9 0.7];


%%% y axis limit (performance)
ylimit=[0.33 1.02];


% %%%%%%%%% COMPARE subpop1 AND subpop2 - PRO/ANTI
% figure
% plot_classifier_results(centers,res_svm1_ap,'b',xlimit,ylimit)
% hold on
% plot_classifier_results(centers,res_svm2_ap,'r',xlimit,ylimit)
% title('Task: pro vs anti')
% legend('subpop1','subpop2','Location','Best')
% legend BOXOFF
% if(save_figures)
%     saveas(gcf,'figures/classifier_correct_subpop_ap','pdf')
% end



%%%%%%%%% COMPARE subpop1 AND subpop2 - CHOICE
figure
plot_classifier_results(centers,res_svm1_choice,'b',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_svm2_choice,'r',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_svm3_choice,'g',xlimit,ylimit)
title('Task: choice')
legend('subpop1','subpop2','PFC','Location','Best')
legend BOXOFF
if(save_figures)
    saveas(gcf,'figures/classifier_correct_subpop_choice','pdf')
end

% 
%%%%%%%%% COMPARE subpop1 AND subpop2 - CHOICE
figure
plot_classifier_results_noerrorbars(centers,res_svm1_choice,'b',xlimit,ylimit)
hold on
plot_classifier_results_noerrorbars(centers,res_svm2_choice,'r',xlimit,ylimit)
hold on
plot_classifier_results_noerrorbars(centers,res_svm3_choice,'g',xlimit,ylimit)
title('Task: choice')
legend('subpop1','subpop2','PFC','Location','Best')
legend BOXOFF


valsz=0.6:0.05:0.75;
%%% here I tried different threshold
%%% to check that it doesn't matter
%%% the threshold we use is 0.65

for iii=1:length(valsz)


vals=valsz(iii)

balo1=nan(size(res_svm1_choice,1),length(vals));
for i=1:size(res_svm1_choice,1)
    vec=res_svm1_choice(i,:);
    vec=smooth(vec)';
    for j=1:length(vals)
%         ind=find(centers>=-.125 & vec>=vals(j));
        ind=find(centers>=-.15 & vec>=vals(j));
        balo1(i,j)=centers(ind(1));
    end
end

balo2=nan(size(res_svm2_choice,1),length(vals));
for i=1:size(res_svm2_choice,1)
    vec=res_svm2_choice(i,:);
    vec=smooth(vec)';
    for j=1:length(vals)
%         ind=find(centers>=-.125 & vec>=vals(j));
        ind=find(centers>=-.215 & vec>=vals(j));
        balo2(i,j)=centers(ind(1));
    end
end


balo3=nan(size(res_svm3_choice,1),length(vals));
for i=1:size(res_svm3_choice,1)
    vec=res_svm3_choice(i,:);
    vec=smooth(vec)';
    for j=1:length(vals)
%         ind=find(centers>=-.125 & vec>=vals(j));
        ind=find(centers>=-.15 & vec>=vals(j));
        balo3(i,j)=centers(ind(1));
    end
end


%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
balo1=balo1+centers_back;
balo2=balo2+centers_back;
balo3=balo3+centers_back;


%%% the threshold we use for plotting/testing is 0.65
if(vals==0.65)
x=vals;
y1=mean(balo1);
y2=std(balo1);
colo='b';

%%% plot!
vec1=y1+y2;
vec2=y1-y2;
% hold on
% plot(y1,x,colo,'LineWidth',2)
hold on
plot([vec1 vec2(end:-1:1) vec1(1)],[x x(end:-1:1) x(1)],colo,'LineWidth',1)
hold on



x=vals;
y1=mean(balo2);
y2=std(balo2);
colo='r';

%%% plot!
vec1=y1+y2;
vec2=y1-y2;
hold on
plot([vec1 vec2(end:-1:1) vec1(1)],[x x(end:-1:1) x(1)],colo,'LineWidth',1)
hold on


x=vals;
y1=mean(balo3);
y2=std(balo3);
colo='g';

%%% plot!
vec1=y1+y2;
vec2=y1-y2;
hold on
plot([vec1 vec2(end:-1:1) vec1(1)],[x x(end:-1:1) x(1)],colo,'LineWidth',1)
hold on
end

[~,p]=ttest2(balo2,balo1)
[~,p]=ttest2(balo2,balo3)

end



if(save_figures)
    saveas(gcf,'figures/classifier_correct_subpop_choice_horiz_errorbar','pdf')
end




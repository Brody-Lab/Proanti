clear
clc
close all

load data_files/svm_results_sc
load data_files/svm_results_pfc
load data_files/svm_results_fof


save_figures=0;


%%% x axis limit (time)
xlimit=[-1.9 0.7];

%%% y axis limit (performance)
ylimit=[0.35 1.02];



%%%%%%%%% COMPARE SC AND PFC - PRO/ANTI
figure;
% plot_classifier_results(centers,res_ap_sc,'r',xlimit,ylimit)


hold on
plot_classifier_results(centers,res_ap_pfc,'r-',xlimit,ylimit)
title('Task: pro vs anti')
% legend('SC','PFC','Location','Best')
legend BOXOFF

% ax = gca;
% ax.Position = [0.1300 0.1437 0.7750 0.45];
if(save_figures)
    saveas(gcf,'figures/classifier_correct_ap','pdf')
end


return


%%%%%%%%% COMPARE SC AND PFC - CHOICE
figure
plot_classifier_results(centers,res_choice_sc,'b',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_choice_pfc,'b--',xlimit,ylimit)
hold on
plot_classifier_results(centers,res_choice_fof,'r-',xlimit,ylimit)
title('Task: choice')
legend('SC','PFC','Location','Best')
legend BOXOFF
% ax = gca;
% ax.Position = [0.1300 0.1437 0.7750 0.45];
if(save_figures)
    saveas(gcf,'figures/classifier_correct_choice','pdf')
end



vals=0.7;

balo1=nan(size(res_choice_sc,1),length(vals));
for i=1:size(res_choice_sc,1)
    vec=res_choice_sc(i,:);
    vec=smooth(vec)';
    for j=1:length(vals)
%         ind=find(centers>=-.125 & vec>=vals(j));
        ind=find(centers>=-1 & vec>=vals(j));
        balo1(i,j)=centers(ind(1));
    end
end

balo2=nan(size(res_choice_pfc,1),length(vals));
for i=1:size(res_choice_pfc,1)
    vec=res_choice_pfc(i,:);
    vec=smooth(vec)';
    for j=1:length(vals)
%         ind=find(centers>=-.125 & vec>=vals(j));
        ind=find(centers>=-1 & vec>=vals(j));
        balo2(i,j)=centers(ind(1));
    end
end

balo3=nan(size(res_choice_fof,1),length(vals));
for i=1:size(res_choice_fof,1)
    vec=res_choice_fof(i,:);
    vec=smooth(vec)';
    for j=1:length(vals)
%         ind=find(centers>=-.125 & vec>=vals(j));
        ind=find(centers>=-1 & vec>=vals(j));
        balo3(i,j)=centers(ind(1));
    end
end


%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
balo1=balo1+centers_back;
balo2=balo2+centers_back;
balo3=balo3+centers_back;

mean(balo2-balo1)
std(balo2-balo1)


mean(balo3-balo1)
std(balo3-balo1)


mean(balo1)
std(balo1)





x=vals;
y1=mean(balo1);
y2=std(balo1);
colo='b';

%     %% plot!
vec1=y1+y2;
vec2=y1-y2;
hold on
plot([vec1 vec2],[x x],colo,'LineWidth',5)
hold on



x=vals;
y1=mean(balo2);
y2=std(balo2);
colo='b';

%     %% plot!
vec1=y1+y2;
vec2=y1-y2;
hold on
plot([vec1 vec2],[x x],colo,'LineWidth',5)
hold on



x=vals;
y1=mean(balo3);
y2=std(balo3);
colo='r';

%     %% plot!
vec1=y1+y2;
vec2=y1-y2;
hold on
plot([vec1 vec2],[x x],colo,'LineWidth',5)
hold on



return

x=vals;
y1=mean(balo1);
y2=std(balo1);
colo='b';

%     %% plot!
vec1=y1+y2;
vec2=y1-y2;
hold on
plot(y1,x,colo,'LineWidth',2)
hold on
plot([vec1 vec2(end:-1:1) vec1(1)],[x x(end:-1:1) x(1)],colo,'LineWidth',1)
hold on




x=vals;
y1=mean(balo2);
y2=std(balo2);
colo='b';

%     %% plot!
vec1=y1+y2;
vec2=y1-y2;
hold on
plot(y1,x,colo,'LineWidth',2)
hold on
plot([vec1 vec2(end:-1:1) vec1(1)],[x x(end:-1:1) x(1)],colo,'LineWidth',1)
hold on

x=vals;
y1=mean(balo3);
y2=std(balo3);
colo='b';

%     %% plot!
vec1=y1+y2;
vec2=y1-y2;
hold on
plot(y1,x,colo,'LineWidth',2)
hold on
plot([vec1 vec2(end:-1:1) vec1(1)],[x x(end:-1:1) x(1)],colo,'LineWidth',1)
hold on

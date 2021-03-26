clear
clc



load data_files/svm_results_sc_new2
load data_files/svm_results_pfc_new2




save_figures=0;


%%% x axis limit (time)
xlimit=[-1.9 0.7];

%%% y axis limit (performance)
ylimit=[0.35 1.02];

figure

%%%%%%%%% COMPARE SC AND PFC - PRO/ANTI
subplot(2,2,1)
for i=1:length(neurvals)
plot_classifier_results_noerrorbars(centers,res_ap_sc(:,:,i),'r',xlimit,ylimit)
% hold on
% plot_classifier_results_noerrorbars(centers,res_ap_pfc(:,:,i),'r--',xlimit,ylimit)


set(gca,'FontSize',10)

end




%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers2=centers+centers_back;

%%%% median delay between end_of_delay and cout (computed using step0_compute_timing.m in preparatory_code)
cout_time_delay=0.127;

load data_files/matsc
[dp_ap,~,dp_choice,~] = compute_dprimes_correct(matsc);
    
subplot(2,2,2)
for i=1:length(neurvals)

    a=dp_ap.^2;
    a=a-0.05;
    a=sum(a);
    a=a*neurvals(i)/193;
    a(a<0)=0;
    a=sqrt(a);
    a=a*.5;
    a=1-qfunc(a/2);
    
    hold on
    plot(centers2,a,'k','LineWidth',1)


    

end

xlim(xlimit)
ylim(ylimit)
set(gca,'TickDir','out')
box off


plot(xlim,[0.5 0.5],'k--')
hold on
xlabel('Time from stimulus onset (s)')
ylabel('Population performance')
set(gca,'FontSize',10)
set(gca,'LineWidth',2)
%%%% cout
plot([0 0],ylim,'k')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'k')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'k')
% legend('choice','pro/anti','Location','Best')
% legend BOXOFF









%%%%%%%%% COMPARE SC AND PFC - PRO/ANTI
subplot(2,2,3)
for i=1:length(neurvals)
plot_classifier_results_noerrorbars(centers,res_ap_pfc(:,:,i),'r',xlimit,ylimit)
% hold on
% plot_classifier_results_noerrorbars(centers,res_ap_pfc(:,:,i),'r--',xlimit,ylimit)


set(gca,'FontSize',10)
end



    
    
%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers2=centers+centers_back;

%%%% median delay between end_of_delay and cout (computed using step0_compute_timing.m in preparatory_code)
cout_time_delay=0.127;

load data_files/matpfc
[dp_ap,~,dp_choice,~] = compute_dprimes_correct(matpfc);
    
subplot(2,2,4)


% neurvals=[neurvals 1000]
% return

for i=1:length(neurvals)

    a=dp_ap.^2;
    a=a-0.05;
    a=sum(a)*193/291;
    a=a*neurvals(i)/193;
    a(a<0)=0;
    a=sqrt(a);
    a=a*.5;
    a=1-qfunc(a/2);
    
    hold on
    plot(centers2,a,'k','LineWidth',1)


    

end

xlim(xlimit)
ylim(ylimit)
set(gca,'TickDir','out')
box off


plot(xlim,[0.5 0.5],'k--')
hold on
xlabel('Time from stimulus onset (s)')
ylabel('Population performance')
set(gca,'FontSize',10)
set(gca,'LineWidth',2)
%%%% cout
plot([0 0],ylim,'k')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'k')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'k')
% legend('choice','pro/anti','Location','Best')
% legend BOXOFF



















clear
clc



load data_files/svm_results_sc_new2
load data_files/svm_results_pfc_new2


save_figures=0;


%%% x axis limit (time)
xlimit=[-1.9 0.7];

%%% y axis limit (performance)
ylimit=[0.35 1.02];


figure;




%%%%%%%%% COMPARE SC AND PFC - PRO/ANTI
subplot(2,2,1)
for i=1:length(neurvals)
plot_classifier_results_noerrorbars(centers,res_choice_sc(:,:,i),'r',xlimit,ylimit)
% hold on
% plot_classifier_results_noerrorbars(centers,res_ap_pfc(:,:,i),'r--',xlimit,ylimit)


set(gca,'FontSize',10)


end



%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers2=centers+centers_back;

%%%% median delay between end_of_delay and cout (computed using step0_compute_timing.m in preparatory_code)
cout_time_delay=0.127;

load data_files/matsc
[dp_ap,~,dp_choice,~] = compute_dprimes_correct(matsc);
    
subplot(2,2,2)
for i=1:length(neurvals)

    a=dp_choice.^2;
    a=a-0.05;
    a=sum(a);
    a=a*neurvals(i)/193;
    a(a<0)=0;
    a=sqrt(a);
    a=a*.5;
    a=1-qfunc(a/2);
    
    hold on
    plot(centers2,a,'k','LineWidth',1)


    

end

xlim(xlimit)
ylim(ylimit)
set(gca,'TickDir','out')
box off


plot(xlim,[0.5 0.5],'k--')
hold on
xlabel('Time from stimulus onset (s)')
ylabel('Population performance')
set(gca,'FontSize',10)
set(gca,'LineWidth',2)
%%%% cout
plot([0 0],ylim,'k')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'k')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'k')
% legend('choice','pro/anti','Location','Best')
% legend BOXOFF









%%%%%%%%% COMPARE SC AND PFC - PRO/ANTI
subplot(2,2,3)
for i=1:length(neurvals)
plot_classifier_results_noerrorbars(centers,res_choice_pfc(:,:,i),'r',xlimit,ylimit)
% hold on
% plot_classifier_results_noerrorbars(centers,res_ap_pfc(:,:,i),'r--',xlimit,ylimit)


set(gca,'FontSize',10)
end


    
    
%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers2=centers+centers_back;

%%%% median delay between end_of_delay and cout (computed using step0_compute_timing.m in preparatory_code)
cout_time_delay=0.127;

load data_files/matpfc
[dp_ap,~,dp_choice,~] = compute_dprimes_correct(matpfc);
    
subplot(2,2,4)


neurvals=[neurvals 1000];

for i=1:length(neurvals)

    a=dp_choice.^2;
    a=a-0.05;
    a=sum(a)*193/291;
    a=a*neurvals(i)/193;
    a(a<0)=0;
    a=sqrt(a);
    a=a*.5;
    a=1-qfunc(a/2);
    
    hold on
    plot(centers2,a,'k','LineWidth',1)


    

end

xlim(xlimit)
ylim(ylimit)
set(gca,'TickDir','out')
box off




plot(xlim,[0.5 0.5],'k--')
hold on
xlabel('Time from stimulus onset (s)')
ylabel('Population performance')
set(gca,'FontSize',10)
set(gca,'LineWidth',2)
%%%% cout
plot([0 0],ylim,'k')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'k')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'k')
% legend('choice','pro/anti','Location','Best')
% legend BOXOFF














load data_files/svm_results_sc_new2 neurvals
for i=1:length(neurvals)

%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers2=centers+centers_back;
vec=mean(res_choice_sc(:,:,i));
vec=vec-.5;
val=max(vec)/2;

% ind=find(vec>.75);
ind=find(vec>=val);

cio(i)=centers2(ind(1));
end


figure
subplot(2,2,1)
plot(neurvals,cio,'b.-','MarkerSize',20)

xlim([0 1000])
ylim([-.01 0.35])

xlabel('neurons')
ylabel('latency')
title('SC, True data')


    
%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers2=centers+centers_back;

load data_files/matsc
[dp_ap,~,dp_choice,~] = compute_dprimes_correct(matsc);
    



% neurvals=[neurvals 1000];
neurvals=25:25:1000;

for i=1:length(neurvals)

    a=dp_choice.^2;
    a=a-0.05;
    a=sum(a);
    a=a*neurvals(i)/193;
    a(a<0)=0;
    a=sqrt(a);
    a=a*.5;
    a=1-qfunc(a/2);
    
    
    vec=a;
    vec=vec-.5;
    val=max(vec)/2;
    
%     ind=find(vec>.75);
    ind=find(vec>=val);
    
    cio2(i)=centers2(ind(1));
    

end
subplot(2,2,2)
plot(neurvals,cio2,'r.-','MarkerSize',20)
xlim([0 1000])
ylim([-.01 0.35])

xlabel('neurons')
ylabel('latency')
title('SC, Estimate')









load data_files/svm_results_sc_new2 neurvals
for i=1:length(neurvals)

%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers2=centers+centers_back;
vec=mean(res_choice_pfc(:,:,i));
vec=vec-.5;
val=max(vec)/2;

% ind=find(vec>.75);
ind=find(vec>=val);

cio3(i)=centers2(ind(1));
end



subplot(2,2,3)
plot(neurvals,cio3,'b.-','MarkerSize',20)

xlim([0 1000])
ylim([-.01 0.35])



xlabel('neurons')
ylabel('latency')
title('PFC, True data')


    
%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers2=centers+centers_back;

load data_files/matpfc
[dp_ap,~,dp_choice,~] = compute_dprimes_correct(matpfc);
    



% neurvals=[neurvals 1000];
neurvals=25:25:1000;

for i=1:length(neurvals)

    a=dp_choice.^2;
    a=a-0.05;
    a=sum(a)*193/291;
    a=a*neurvals(i)/193;
    a(a<0)=0;
    a=sqrt(a);
    a=a*.5;
    a=1-qfunc(a/2);
    
    
    vec=a;
    vec=vec-.5;
    val=max(vec)/2;
    
%     ind=find(vec>.75);
    ind=find(vec>=val);
    
    cio4(i)=centers2(ind(1));
    

end
subplot(2,2,4)
plot(neurvals,cio4,'r.-','MarkerSize',20)
xlim([0 1000])
ylim([-.01 0.35])


xlabel('neurons')
ylabel('latency')
title('PFC, Estimate')






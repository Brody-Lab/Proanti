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



load data_files/svm_results_sc29
load data_files/svm_results_pfc29
load data_files/svm_results_fof29







vals=0.65;

classifier_results=res_choice_sc;

latency=nan(size(classifier_results,1),1);
for i=1:size(classifier_results,1)
    vec=classifier_results(i,:);
    vec=smooth(vec)';
    ind=find(centers>=-1 & vec>=vals);
    latency(i)=centers(ind(1));
end
%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
latency=latency+centers_back;

latency_sc=latency;




classifier_results=res_choice_pfc;

latency=nan(size(classifier_results,1),1);
for i=1:size(classifier_results,1)
    vec=classifier_results(i,:);
    vec=smooth(vec)';
    ind=find(centers>=-1 & vec>=vals);
    latency(i)=centers(ind(1));
end
%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
latency=latency+centers_back;

latency_pfc=latency;






classifier_results=res_choice_fof;

latency=nan(size(classifier_results,1),1);
for i=1:size(classifier_results,1)
    vec=classifier_results(i,:);
    vec=smooth(vec)';
    ind=find(centers>=-1 & vec>=vals);
    latency(i)=centers(ind(1));
end
%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
latency=latency+centers_back;

latency_fof=latency;










classifier_results=res_svm1_choice;

latency=nan(size(classifier_results,1),1);
for i=1:size(classifier_results,1)
    vec=classifier_results(i,:);
    vec=smooth(vec)';
    ind=find(centers>=-1 & vec>=vals);
    latency(i)=centers(ind(1));
end
%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
latency=latency+centers_back;

latency_sc_subpop1=latency;





classifier_results=res_svm2_choice;

latency=nan(size(classifier_results,1),1);
for i=1:size(classifier_results,1)
    vec=classifier_results(i,:);
    vec=smooth(vec)';
    ind=find(centers>=-1 & vec>=vals);
    latency(i)=centers(ind(1));
end
%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
latency=latency+centers_back;

latency_sc_subpop2=latency;





classifier_results=res_svm3_choice;

latency=nan(size(classifier_results,1),1);
for i=1:size(classifier_results,1)
    vec=classifier_results(i,:);
    vec=smooth(vec)';
    ind=find(centers>=-1 & vec>=vals);
    latency(i)=centers(ind(1));
end
%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
latency=latency+centers_back;

latency_pfc_subpop=latency;









classifier_results=res_svm4_choice;

latency=nan(size(classifier_results,1),1);
for i=1:size(classifier_results,1)
    vec=classifier_results(i,:);
    vec=smooth(vec)';
    ind=find(centers>=-1 & vec>=vals);
    latency(i)=centers(ind(1));
end
%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
latency=latency+centers_back;

latency_fof_subpop=latency;




disp('sc')
mean(latency_sc)

disp('pfc')
mean(latency_pfc)

disp('fof')
mean(latency_fof)



disp('sc 1')
mean(latency_sc_subpop1)

disp('sc 2')
mean(latency_sc_subpop2)

disp('pfc')
mean(latency_pfc_subpop)

disp('fof')
mean(latency_fof_subpop)












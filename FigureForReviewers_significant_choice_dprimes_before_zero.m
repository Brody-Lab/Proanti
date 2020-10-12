clear
clc


load data_files/matsc

%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;
centers=centers+centers_back;


%%% area to use
pop=matsc;

[dp_ap,~,dp_choice,~] = compute_dprimes_correct(pop);

dp=dp_choice;
%%% normalize dprimes
sigo=sign(dp);
dp=abs(dp);
minval=abs(tinv(0.05,98)/sqrt(50)); %significant p<=0.05

dp=dp-minval;
dp(dp<0)=0;
dp2=dp;
% maxval_use=maxval-minval;
% dp(dp>maxval_use)=maxval_use;
% dp=dp/maxval_use;
% dp2=dp.*sigo;


ind=find(centers<-0.001);
dp3=dp2(:,ind);
truevalue=length(find(dp3~=0))



for iii=1:1000
    
    [iii 1000]
    
    %%% area to use
    pop=matsc;
    
    %%% shuffle trials
    pop=pop(:,:,:);
    ra=randperm(100);
    pop=pop(:,:,ra);
    pop=reshape(pop,[193 105 25 2 2]);
    
    
    
    [dp_ap,~,dp_choice,~] = compute_dprimes_correct(pop);
    
    
    dp=dp_choice;
    %%% normalize dprimes
    sigo=sign(dp);
    dp=abs(dp);
    minval=abs(tinv(0.05,98)/sqrt(50)); %significant p<=0.05

    dp=dp-minval;
    dp(dp<0)=0;
    dp2=dp;
    
    ind=find(centers<-0.001);
    dp3=dp2(:,ind);
    value(iii)=length(find(dp3~=0));
    
end



figure
hist(value,30)
hold on
plot([truevalue truevalue],ylim,'r','LineWidth',3)
xlabel('number of significant points on shuffled data')
set(gca,'FontSize',24)




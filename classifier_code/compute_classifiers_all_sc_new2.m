clear
clc
load ../data_files/matpfc


load ../data_files/matsc



%%% number of iterations
n_iterations=500;


%%% set cost parameter
cost=1;


%%% number of training trials
ntrain=30;
%%% number of testing trials
ntest=20;
%%% number of testing trials
ntest_err=9;


% n_neur=min([size(matsc,1) size(matpfc,1)]);

neurvals=[25 50 75 100 125 150 175 193];


pop=matsc;


res_ap_sc=nan(n_iterations,length(centers),length(neurvals));
res_choice_sc=nan(n_iterations,length(centers),length(neurvals));


for jjj=1:length(neurvals)
    
    n_neur=neurvals(jjj)
    
    for i=1:n_iterations
        
        [i n_iterations]
        
        for tx=1:length(centers) %look over different time points
            
            %%%%% SC
            
            ra_neur=randperm(size(pop,1));
            
            
            
            
            %%%%% PRO/ANTI
            train_pro=nan(n_neur,ntrain);
            train_anti=nan(n_neur,ntrain);
            
            test_pro=nan(n_neur,ntest);
            test_anti=nan(n_neur,ntest);
            
            test_pro_err=nan(n_neur,ntest_err);
            test_anti_err=nan(n_neur,ntest_err);
            
            
            %%%%% CONTRA/IPSI
            train_contra=nan(n_neur,ntrain);
            train_ipsi=nan(n_neur,ntrain);
            
            test_contra=nan(n_neur,ntest);
            test_ipsi=nan(n_neur,ntest);
            
            test_contra_err=nan(n_neur,ntest_err);
            test_ipsi_err=nan(n_neur,ntest_err);
            
            
            
            for nx=1:n_neur
                
                %%%%% PRO/ANTI
                
                %%%%% CORRECT PRO
                mat=squeeze(pop(:,tx,:,1,:));
                mat=mat(:,:);
                ra=randperm(size(mat,2));
                train_pro(nx,:)=mat(ra_neur(nx),ra(1:ntrain));
                test_pro(nx,:)=mat(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
                
                %%%%% CORRECT ANTI
                mat=squeeze(pop(:,tx,:,2,:));
                mat=mat(:,:);
                ra=randperm(size(mat,2));
                train_anti(nx,:)=mat(ra_neur(nx),ra(1:ntrain));
                test_anti(nx,:)=mat(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
                
                
                
                
                %%%%% CHOICE
                
                %%%%% CORRECT CONTRA
                mat=squeeze(pop(:,tx,:,:,1));
                mat=mat(:,:);
                ra=randperm(size(mat,2));
                train_contra(nx,:)=mat(ra_neur(nx),ra(1:ntrain));
                test_contra(nx,:)=mat(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
                
                %%%%% CORRECT IPSI
                mat=squeeze(pop(:,tx,:,:,2));
                mat=mat(:,:);
                ra=randperm(size(mat,2));
                train_ipsi(nx,:)=mat(ra_neur(nx),ra(1:ntrain));
                test_ipsi(nx,:)=mat(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
                
                
            end
            
            
            %%%%%% classify PRO/ANTI
            
            %%% run svm classifier
            [w,k]=svm_train(train_pro,train_anti,cost);
            
            %%% classify points (CORRECT)
            valp=w'*test_pro + k>0; % classified as Pro
            vala=w'*test_anti + k<=0; % classified as Anti
            res_ap_sc(i,tx,jjj)=mean([valp vala]);
            
            
            
            %%%%%% classify CHOICE
            
            %%% run svm classifier
            [w,k]=svm_train(train_contra,train_ipsi,cost);
            
            %%% classify points (CORRECT)
            valp=w'*test_contra + k>0; % classified as Pro
            vala=w'*test_ipsi + k<=0; % classified as Anti
            res_choice_sc(i,tx,jjj)=mean([valp vala]);
            
            
        end
        
    end
    
end

save ../data_files/svm_results_sc_new2 res_ap_sc ...
    res_choice_sc centers neurvals




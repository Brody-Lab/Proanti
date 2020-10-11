clear
clc
load ../data_files/matsc


%%% number of iterations
n_iterations=500;


%%% decode pro vs anti
condition1=[1 3];
condition2=[2 4];


%%% set cost parameter
cost=1;


%%% number of training trials
ntrain=30; 
%%% number of testing trials
ntest=20;
%%% number of testing trials
ntest_err=9;


load ../data_files/indices_subpopulations

%%% first subpopulation (calling it matsc to avoid changing the code...)
matsc=matsc(ind2,:,:,:,:);
matsc_err_ap=matsc_err_ap(ind2,:,:,:,:);


n_neur=min([size(matsc,1)]);

pop=matsc;
pop_err_ap=matsc_err_ap;

res_ap_sc=nan(n_iterations,length(centers));
res_ap_sc_err=nan(n_iterations,length(centers));

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
                
                %%%%% ERROR PRO
                mat=pop_err_ap{ra_neur(nx),tx,1};
                ra=randperm(length(mat));
                test_pro_err(nx,:)=mat(ra(1:ntest_err));
            
                %%%%% ERROR ANTI
                mat=pop_err_ap{ra_neur(nx),tx,2};
                ra=randperm(length(mat));
                test_anti_err(nx,:)=mat(ra(1:ntest_err));
                
                

                
            end
            
        
        %%%%%% classify PRO/ANTI 
        
        %%% run svm classifier
        [w,k]=svm_train(train_pro,train_anti,cost);
        
        %%% classify points (CORRECT)
        valp=w'*test_pro + k>0; % classified as Pro
        vala=w'*test_anti + k<=0; % classified as Anti
        res_ap_sc(i,tx)=mean([valp vala]);
        
        %%% classify points (ERROR)
        valp=w'*test_pro_err + k>0; % classified as Pro
        vala=w'*test_anti_err + k<=0; % classified as Anti
        res_ap_sc_err(i,tx)=mean([valp vala]);
        
        
        
        
    end
    
end


save ../data_files/svm_results_subpopulations_error res_ap_sc res_ap_sc_err centers





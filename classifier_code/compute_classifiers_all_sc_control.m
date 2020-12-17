clear
clc
load ../data_files/matsc
load ../data_files/matpfc


%%% number of iterations
n_iterations=500;


%%% set cost parameter
cost=1;


%%% number of training trials
ntrain=15; 
%%% number of testing trials
ntest=10;


n_neur=min([size(matsc,1) size(matpfc,1)]);

pop=matsc;

res_ap_sc_ipsi=nan(n_iterations,length(centers));
res_ap_sc_contra=nan(n_iterations,length(centers));

for i=1:n_iterations
    
    [i n_iterations]
    
    for tx=1:length(centers) %look over different time points
        
        %%%%% SC
        
        ra_neur=randperm(size(pop,1));
        
        
        
        %%%%% PRO/ANTI IPSI
        train_pro_ipsi=nan(n_neur,ntrain);
        train_anti_ipsi=nan(n_neur,ntrain);
        
        test_pro_ipsi=nan(n_neur,ntest);
        test_anti_ipsi=nan(n_neur,ntest);
        
        %%%%% PRO/ANTI CONTRA
        train_pro_contra=nan(n_neur,ntrain);
        train_anti_contra=nan(n_neur,ntrain);
        
        test_pro_contra=nan(n_neur,ntest);
        test_anti_contra=nan(n_neur,ntest);
        
        
        for nx=1:n_neur
            
            %%%%% PRO/ANTI IPSI
            
            %%%%% CORRECT PRO
            mat=squeeze(pop(:,tx,:,1,1));
            mat=mat(:,:);
            ra=randperm(size(mat,2));
            train_pro_ipsi(nx,:)=mat(ra_neur(nx),ra(1:ntrain));
            test_pro_ipsi(nx,:)=mat(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
            
            %%%%% CORRECT ANTI
            mat=squeeze(pop(:,tx,:,2,1));
            mat=mat(:,:);
            ra=randperm(size(mat,2));
            train_anti_ipsi(nx,:)=mat(ra_neur(nx),ra(1:ntrain));
            test_anti_ipsi(nx,:)=mat(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
            
            
            
            %%%%% PRO/ANTI CONTRA
            
            %%%%% CORRECT PRO
            mat=squeeze(pop(:,tx,:,1,2));
            mat=mat(:,:);
            ra=randperm(size(mat,2));
            train_pro_contra(nx,:)=mat(ra_neur(nx),ra(1:ntrain));
            test_pro_contra(nx,:)=mat(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
            
            %%%%% CORRECT ANTI
            mat=squeeze(pop(:,tx,:,2,2));
            mat=mat(:,:);
            ra=randperm(size(mat,2));
            train_anti_contra(nx,:)=mat(ra_neur(nx),ra(1:ntrain));
            test_anti_contra(nx,:)=mat(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
            
            
            
            
        end
            
        
        %%%%%% classify PRO/ANTI IPSI
        
        %%% run svm classifier
        [w,k]=svm_train(train_pro_ipsi,train_anti_ipsi,cost);
        
        %%% classify points (CORRECT)
        valp=w'*test_pro_ipsi + k>0; % classified as Pro
        vala=w'*test_anti_ipsi + k<=0; % classified as Anti
        res_ap_sc_ipsi(i,tx)=mean([valp vala]);
        
        
        
        
        
        %%%%%% classify PRO/ANTI CONTRA
        
        %%% run svm classifier
        [w,k]=svm_train(train_pro_contra,train_anti_contra,cost);
        
        %%% classify points (CORRECT)
        valp=w'*test_pro_contra + k>0; % classified as Pro
        vala=w'*test_anti_contra + k<=0; % classified as Anti
        res_ap_sc_contra(i,tx)=mean([valp vala]);
        
        
        
    end
    
end


save ../data_files/svm_results_sc_control res_ap_sc_ipsi res_ap_sc_contra centers





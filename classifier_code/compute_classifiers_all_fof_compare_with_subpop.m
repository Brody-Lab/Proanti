clear
clc
load ../data_files/matsc
load ../data_files/matfof

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


n_neur=29;

pop=matfof;


res_choice_fof=nan(n_iterations,length(centers));



for i=1:n_iterations
    
    [i n_iterations]
    
    for tx=1:length(centers) %look over different time points
        
        %%%%% fof
        
        ra_neur=randperm(size(pop,1));
        

            
        

            %%%%% CONTRA/IPSI
            train_contra=nan(n_neur,ntrain);
            train_ipsi=nan(n_neur,ntrain);
            
            test_contra=nan(n_neur,ntest);
            test_ipsi=nan(n_neur,ntest);
            
            
            
            
            for nx=1:n_neur
                
                

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
            
        
            

        %%%%%% classify CHOICE
        
        %%% run svm classifier
        [w,k]=svm_train(train_contra,train_ipsi,cost);
        
        %%% classify points (CORRECT)
        valp=w'*test_contra + k>0; % classified as Pro
        vala=w'*test_ipsi + k<=0; % classified as Anti
        res_choice_fof(i,tx)=mean([valp vala]);
        
        
        
    end
    
end


save ../data_files/svm_results_fof_comparesubpop ...
    res_choice_fof centers





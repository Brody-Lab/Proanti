clear
clc
load ../data_files/matsc
load ../data_files/matpfc


%%% number of iterations
n_iterations=500;


%%% set cost parameter
cost=1;


%%% number of training trials
ntrain=30; 
%%% number of testing trials
ntest=20;



n_neur=min([size(matsc,1) size(matpfc,1)]);

pop=matsc;

res_stim_sc=nan(n_iterations,length(centers));



for i=1:n_iterations
    
    [i n_iterations]
    
    for tx=1:length(centers) %look over different time points
        
        %%%%% SC
        
        ra_neur=randperm(size(pop,1));
        

            
            
            %%%%% PRO/ANTI
            train_stim1=nan(n_neur,ntrain);
            train_stim2=nan(n_neur,ntrain);
            
            test_stim1=nan(n_neur,ntest);
            test_stim2=nan(n_neur,ntest);
            
            
                        
            
            
            for nx=1:n_neur
                
                
                
                %%%%% CORRECT stim1
                mat1=squeeze(pop(:,tx,:,1,1));
                mat2=squeeze(pop(:,tx,:,2,2));
                mat=[mat1 mat2];
                
                mat=mat(:,:);
                ra=randperm(size(mat,2));
                train_stim1(nx,:)=mat(ra_neur(nx),ra(1:ntrain));
                test_stim1(nx,:)=mat(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
                
                %%%%% CORRECT stim2
                mat1=squeeze(pop(:,tx,:,1,2));
                mat2=squeeze(pop(:,tx,:,2,1));
                mat=[mat1 mat2];
                mat=mat(:,:);
                ra=randperm(size(mat,2));
                train_stim2(nx,:)=mat(ra_neur(nx),ra(1:ntrain));
                test_stim2(nx,:)=mat(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
                
            end
            
        
        %%%%%% classify STIM
        
        %%% run svm classifier
        [w,k]=svm_train(train_stim1,train_stim2,cost);
        
        %%% classify points (CORRECT)
        valp=w'*test_stim1 + k>0; % classified as Pro
        vala=w'*test_stim2 + k<=0; % classified as Anti
        res_stim_sc(i,tx)=mean([valp vala]);
        
        
        
        
    end
    
end


save ../data_files/svm_results_sc_stim res_stim_sc centers





clear
clc
load ../data_files/matsc
load ../data_files/matpfc


cd ..

[~,~,dp_choice_sc,~] = compute_dprimes_correct(matsc);
[~,~,dp_choice_pfc,~] = compute_dprimes_correct(matpfc);


disp('max d prime SC')
max(mean(dp_choice_sc.^2))

disp(' ')

disp('max d prime PFC')
max(mean(dp_choice_pfc.^2))



num=183;

% % % %index 72 = timepoint 0
% % % vals=mean(dp_choice_pfc(:,72:end).^2,2);


vals=mean(dp_choice_sc.^2,2);
[~,ind_sc]=sort(vals,'ascend');
dp_choice_sc=dp_choice_sc(ind_sc(1:num),:);

vals=mean(dp_choice_pfc.^2,2);
[~,ind_pfc]=sort(vals,'descend');
dp_choice_pfc=dp_choice_pfc(ind_pfc(1:num),:);


disp(' ')

disp('max d prime SC after subselection')
max(mean(dp_choice_sc.^2))

disp(' ')

disp('max d prime PFC after subselection')
max(mean(dp_choice_pfc.^2))




matsc=matsc(ind_sc(1:num),:,:,:,:);
matpfc=matpfc(ind_pfc(1:num),:,:,:,:);

cd classifier_code


return


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


n_neur=num;





pop=matsc;

res_choice_sc=nan(n_iterations,length(centers));


for i=1:n_iterations
    
    [i n_iterations]
    
    for tx=1:length(centers) %look over different time points
        
        
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
        res_choice_sc(i,tx)=mean([valp vala]);
        
        
    end
    
end












pop=matpfc;

res_choice_pfc=nan(n_iterations,length(centers));


for i=1:n_iterations
    
    [i n_iterations]
    
    for tx=1:length(centers) %look over different time points
        
        
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
        res_choice_pfc(i,tx)=mean([valp vala]);
        
        
    end
    
end


save ../data_files/svm_results_sc_pfc_matched_dprimes ...
    res_choice_sc res_choice_pfc centers





clear
clc
load ../data_files/matsc



%%% number of iterations
n_iterations=500;



%%% decode choice
condition1=[1 2];
condition2=[3 4];


load ../data_files/indices_subpopulations

%%% second subpopulation (calling it matpfc to avoid changing the code...)
matpfc=matsc(ind2,:,:,:,:);
%%% first subpopulation (calling it matsc to avoid changing the code...)
matsc=matsc(ind1,:,:,:,:);



costval=1;



%%% number of training trials
ntrain=30; 
%%% number of testing trials
ntest=20;


n_neur=min([length(ind1) length(ind2)]);



res_svm1=nan(n_iterations,length(centers),length(costval));
res_svm2=nan(n_iterations,length(centers),length(costval));
for i=1:n_iterations
    
    [i n_iterations]
    
    for tx=1:length(centers) %look over different time points
        
        
        %%%%% create train and test matrices for SC
        
        Dp=squeeze(matsc(:,tx,:,condition1));        
        Dp=Dp(:,:);
        Da=squeeze(matsc(:,tx,:,condition2));
        Da=Da(:,:);
        
        
        ra_neur=randperm(size(matsc,1));
        
        
        for nx=1:n_neur
            
            ra=randperm(size(Dp,2));
            Dp_train1(nx,:)=Dp(ra_neur(nx),ra(1:ntrain));
            Dp_test1(nx,:)=Dp(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
            
            ra=randperm(size(Da,2));
            Da_train1(nx,:)=Da(ra_neur(nx),ra(1:ntrain));
            Da_test1(nx,:)=Da(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
            
        end
        
        
        

        %%%%% create train and test matrices for PFC
        
        Dp=squeeze(matpfc(:,tx,:,condition1));
        Dp=Dp(:,:);
        Da=squeeze(matpfc(:,tx,:,condition2));
        Da=Da(:,:);
        
        ra_neur=randperm(size(matpfc,1));
        
        
        
        for nx=1:n_neur

            ra=randperm(size(Dp,2));
            Dp_train2(nx,:)=Dp(ra_neur(nx),ra(1:ntrain));
            Dp_test2(nx,:)=Dp(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
            
            ra=randperm(size(Da,2));
            Da_train2(nx,:)=Da(ra_neur(nx),ra(1:ntrain));
            Da_test2(nx,:)=Da(ra_neur(nx),ra(ntrain+1:ntrain+ntest));
            
        end
        
        
        
        
        
        for j=1:length(costval)
            
            %%% set cost parameter
            cost=costval(j);
            
            
            %%%%%% compute performances for SC
            
            %%% run svm classifier
            [w,k]=svm_train(Dp_train1,Da_train1,cost);
            
            %%% classify points
            valp=w'*Dp_test1 + k>0; % classified as Pro
            vala=w'*Da_test1 + k<=0; % classified as Anti
            res_svm1(i,tx,j)=mean([valp vala]);
            
            

            %%%%%% compute performances for PFC
            
            %%% run svm classifier
            [w,k]=svm_train(Dp_train2,Da_train2,cost);
            
            %%% classify points
            valp=w'*Dp_test2 + k>0; % classified as Pro
            vala=w'*Da_test2 + k<=0; % classified as Anti
            res_svm2(i,tx,j)=mean([valp vala]);
            
            
            
        end
        
        
    end
    
end


save ../data_files/svm_results_choice_subpopulations res_svm1 res_svm2 centers





function [dp_ap,pvals_ap,dp_choice,pvals_choice,...
    dp_stim,pvals_stim] = compute_dprimes_correct(pop,varargin)


if( isempty(varargin) || strcmp(varargin{1},'dprime') )
    
    
    %%%% PRO/ANTI CORRECT
    pro=squeeze(pop(:,:,:,1,:));
    pro=pro(:,:,:);
    anti=squeeze(pop(:,:,:,2,:));
    anti=anti(:,:,:);
    %%%% numerator : difference
    num=mean(pro,3)-mean(anti,3);
    %%%% denominator : pooled standard deviation
    den=sqrt((var(pro,[],3)+var(anti,[],3))/2);
    %%% step to avoid dividing by 0
    den=den+eps;
    %%%% COMPUTE D'
    dp_ap=num./den;
    %%%% COMPUTE P VALUES FOR PAIRWISE T TEST
    pvals_ap = 2 * tcdf(-abs(sqrt(25)*dp_ap),98);
    
    
    %%%% CHOICE CORRECT
    contra=squeeze(pop(:,:,:,:,1));
    contra=contra(:,:,:);
    ipsi=squeeze(pop(:,:,:,:,2));
    ipsi=ipsi(:,:,:);
    %%%% numerator : difference
    num=mean(contra,3)-mean(ipsi,3);
    %%%% denominator : pooled standard deviation
    den=sqrt((var(contra,[],3)+var(ipsi,[],3))/2);
    %%% step to avoid dividing by 0
    den=den+eps;
    %%%% COMPUTE D'
    dp_choice=num./den;
    %%%% COMPUTE P VALUES FOR PAIRWISE T TEST
    pvals_choice = 2 * tcdf(-abs(sqrt(25)*dp_choice),98);
    
    
    %%%% STIMULUS CORRECT
    contra1=squeeze(pop(:,:,:,1,1));
    contra2=squeeze(pop(:,:,:,2,2));
    contra=cat(3,contra1(:,:,:),contra2(:,:,:));
    
    
    ipsi1=squeeze(pop(:,:,:,1,2));
    ipsi2=squeeze(pop(:,:,:,2,1));
    ipsi=cat(3,ipsi1(:,:,:),ipsi2(:,:,:));
    %%%% numerator : difference
    num=mean(contra,3)-mean(ipsi,3);
    %%%% denominator : pooled standard deviation
    den=sqrt((var(contra,[],3)+var(ipsi,[],3))/2);
    %%% step to avoid dividing by 0
    den=den+eps;
    %%%% COMPUTE D'
    dp_stim=num./den;
    %%%% COMPUTE P VALUES FOR PAIRWISE T TEST
    pvals_stim = 2 * tcdf(-abs(sqrt(25)*dp_stim),98);
    
    
elseif(strcmp(varargin{1},'auc'))
    
    
    %%%% PRO/ANTI CORRECT
    pro=squeeze(pop(:,:,:,1,:));
    pro=pro(:,:,:);
    anti=squeeze(pop(:,:,:,2,:));
    anti=anti(:,:,:);
    clear labels
    for i=1:50
        labels{i}='pro';
    end
    for i=51:100
        labels{i}='anti';
    end
    for i=1:193
        for j=1:105
            vec1=pro(i,j,:);
            vec2=anti(i,j,:);
            scores=[vec1(:);vec2(:)];
            [~,~,~,dp_ap(i,j)] = perfcurve(labels,scores,'pro');
        end
    end
    pvals_ap=[];
    
    
    
    
    
    %%%% CHOICE CORRECT
    contra=squeeze(pop(:,:,:,:,1));
    contra=contra(:,:,:);
    ipsi=squeeze(pop(:,:,:,:,2));
    ipsi=ipsi(:,:,:);
    for i=1:50
        labels{i}='contra';
    end
    for i=51:100
        labels{i}='ipsi';
    end
    for i=1:193
        [i 193]
        for j=1:105
            vec1=contra(i,j,:);
            vec2=ipsi(i,j,:);
            scores=[vec1(:);vec2(:)];
            [~,~,~,dp_choice(i,j)] = perfcurve(labels,scores,'contra');
        end
    end
    pvals_choice=[];
    
    
    dp_stim=[];
    pvals_stim=[];
    
    
elseif(strcmp(varargin{1},'diffe'))
    
    
    %%%% PRO/ANTI CORRECT
    pro=squeeze(pop(:,:,:,1,:));
    pro=pro(:,:,:);
    anti=squeeze(pop(:,:,:,2,:));
    anti=anti(:,:,:);
    %%%% numerator : difference
    num=mean(pro,3)-mean(anti,3);
    %%%% COMPUTE D'
    dp_ap=num;
    %%%% COMPUTE P VALUES FOR PAIRWISE T TEST
    pvals_ap = 2 * tcdf(-abs(sqrt(25)*dp_ap),98);
    
    
    %%%% CHOICE CORRECT
    contra=squeeze(pop(:,:,:,:,1));
    contra=contra(:,:,:);
    ipsi=squeeze(pop(:,:,:,:,2));
    ipsi=ipsi(:,:,:);
    %%%% numerator : difference
    num=mean(contra,3)-mean(ipsi,3);
    %%%% COMPUTE D'
    dp_choice=num;
    %%%% COMPUTE P VALUES FOR PAIRWISE T TEST
    pvals_choice = 2 * tcdf(-abs(sqrt(25)*dp_choice),98);
    
    
    %%%% STIMULUS CORRECT
    contra1=squeeze(pop(:,:,:,1,1));
    contra2=squeeze(pop(:,:,:,2,2));
    contra=cat(3,contra1(:,:,:),contra2(:,:,:));
    
    
    ipsi1=squeeze(pop(:,:,:,1,2));
    ipsi2=squeeze(pop(:,:,:,2,1));
    ipsi=cat(3,ipsi1(:,:,:),ipsi2(:,:,:));
    %%%% numerator : difference
    num=mean(contra,3)-mean(ipsi,3);    
    %%%% COMPUTE D'
    dp_stim=num;
    %%%% COMPUTE P VALUES FOR PAIRWISE T TEST
    pvals_stim = 2 * tcdf(-abs(sqrt(25)*dp_stim),98);
    
    
    
    
    
end



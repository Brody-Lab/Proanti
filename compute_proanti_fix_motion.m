function [dp_ap1,pvals_ap1,dp_ap2,pvals_ap2] = compute_proanti_fix_motion(pop)


%%%% PRO/ANTI CORRECT
pro=squeeze(pop(:,:,:,1,1));
pro=pro(:,:,:);
anti=squeeze(pop(:,:,:,2,1));
anti=anti(:,:,:);
%%%% numerator : difference
num=mean(pro,3)-mean(anti,3);
%%%% denominator : pooled standard deviation
den=sqrt((var(pro,[],3)+var(anti,[],3))/2);
%%% step to avoid dividing by 0
den=den+eps;
%%%% COMPUTE D'
dp_ap1=num./den;
%%%% COMPUTE P VALUES FOR PAIRWISE T TEST
pvals_ap1 = 2 * tcdf(-abs(sqrt(12.5)*dp_ap1),98);



%%%% PRO/ANTI CORRECT
pro=squeeze(pop(:,:,:,1,2));
pro=pro(:,:,:);
anti=squeeze(pop(:,:,:,2,2));
anti=anti(:,:,:);
%%%% numerator : difference
num=mean(pro,3)-mean(anti,3);
%%%% denominator : pooled standard deviation
den=sqrt((var(pro,[],3)+var(anti,[],3))/2);
%%% step to avoid dividing by 0
den=den+eps;
%%%% COMPUTE D'
dp_ap2=num./den;
%%%% COMPUTE P VALUES FOR PAIRWISE T TEST
pvals_ap2 = 2 * tcdf(-abs(sqrt(12.5)*dp_ap2),98);



clear
clc
close all

load data_files/matsc


plot_figures=1;
save_figures=0;



%%%% median delay between end_of_delay and cout (computed using step0_compute_timing.m in preparatory_code)
cout_time_delay=0.127;
%%%% shift the time axis to make plot "causal" (e.g. no choice information before 0)
centers_back=0.125;


%%% x axis limit (time)
xlimit=[-1.9 0.7];

centers=centers+centers_back;
xlimit=xlimit+centers_back;




[dp_ap,~,dp_choice,~] = compute_dprimes_correct(matsc);




%%% order the matrix
[valomax,indmax]=max(abs(dp_ap),[],2);
[~,indsort]=sort(indmax);

% figure
% x=1:4:105;
% y=hist(indmax,x);
% hold on
% bar(centers(x),smooth(y,7),'b')
% %%%% cout
% hold on
% plot([0 0],ylim,'k','LineWidth',2)
% hold on
% %%%% start of delay
% plot([0 0]-(0.5+cout_time_delay),ylim,'k','LineWidth',2)
% hold on
% %%%% start of cue stimulus
% plot([0 0]-(1.5+cout_time_delay),ylim,'k','LineWidth',2)
% xlim([min(centers)-0.05 max(centers)+0.05])
% 
% xlabel('Time (s)')
% ylabel('Neurons')
% set(gca,'FontSize',24)
% box off
% set(gca,'TickDir','out')




figure
x=1:4:105;
y=hist(indmax,x);
hold on
bar(centers(x),smooth(y,3),'b')
%%%% cout
hold on
plot([0 0],ylim,'k','LineWidth',2)
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'k','LineWidth',2)
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'k','LineWidth',2)
xlim([min(centers)-0.05 max(centers)+0.05])

xlabel('Time (s)')
ylabel('Neurons')
set(gca,'FontSize',24)
box off
set(gca,'TickDir','out')


% figure
% x=1:4:105;
% y=hist(indmax,x);
% hold on
% bar(centers(x),y,'b')
% %%%% cout
% hold on
% plot([0 0],ylim,'k','LineWidth',2)
% hold on
% %%%% start of delay
% plot([0 0]-(0.5+cout_time_delay),ylim,'k','LineWidth',2)
% hold on
% %%%% start of cue stimulus
% plot([0 0]-(1.5+cout_time_delay),ylim,'k','LineWidth',2)
% xlim([min(centers)-0.05 max(centers)+0.05])
% 
% xlabel('Time (s)')
% ylabel('Neurons')
% set(gca,'FontSize',24)
% box off
% set(gca,'TickDir','out')



% 
% centers2=[centers 0.85:0.0250:1];
% figure
% x=1:7:112;
% whos x
% y=hist(indmax,x);
% hold on
% bar(centers2(x),y,'b')
% %%%% cout
% hold on
% plot([0 0],ylim,'k')
% hold on
% %%%% start of delay
% plot([0 0]-(0.5+cout_time_delay),ylim,'k')
% hold on
% %%%% start of cue stimulus
% plot([0 0]-(1.5+cout_time_delay),ylim,'k')
% xlim([min(centers) max(centers)])
% 
% xlabel('Time (s)')
% ylabel('Neurons')
% set(gca,'FontSize',24)
% box off
% set(gca,'TickDir','out')



%%%% DETERMINE SIGNIFICANCE THRESHOLD BY SHUFFLING PROCEDURE



%%%% PRO/ANTI CORRECT
pop2=reshape(matsc,[size(matsc,1) size(matsc,2) 50 2]);

dp_shuf=nan(193,100);
for i=1:100
    
    %%% shuffle pro/anti labels
    ra=randperm(50);
    pro=pop2(:,:,ra(1:25),:);
    anti=pop2(:,:,ra(26:50),:);
    
    pro=pro(:,:,:);
    anti=anti(:,:,:);
    %%%% numerator : difference
    num=mean(pro,3)-mean(anti,3);
    %%%% denominator : pooled standard deviation
    den=sqrt((var(pro,[],3)+var(anti,[],3))/2);
    %%% step to avoid dividing by 0
    den=den+eps;
    %%%% COMPUTE D'
    dp_ap2=num./den;
    
    dp_shuf(:,i)=max(abs(dp_ap2),[],2);
    
end
dp_thres=prctile(dp_shuf(:),95)



p_sig=abs(dp_ap)>dp_thres;
good=sum(p_sig,2)>0;


tim1=-0.5-cout_time_delay;
ind1=find(centers(indmax)<tim1 & good');
ind2=find(centers(indmax)>tim1 & centers(indmax)<0.4 & good');



whos ind1 ind2

% save data_files/indices_subpopulations ind1 ind2

signif=double(abs(dp_ap)>dp_thres);

signif(ind1,:)=signif(ind1,:)*2;
signif(ind2,:)=signif(ind2,:)*3;
signif=signif(indsort,:);

figure;
imagesc(centers,1:size(matsc,1),signif)
co=zeros(64,3);



rgb=[0 255 255];
ind=40:44;
% first subpopulation
co(ind,1)=rgb(1)/255;
co(ind,2)=rgb(2)/255;
co(ind,3)=rgb(3)/255;



rgb=[255 255 0];
ind=60:64;
% second subpopulation
co(ind,1)=rgb(1)/255;
co(ind,2)=rgb(2)/255;
co(ind,3)=rgb(3)/255;




rgb=[255 255 255]/2;
ind=20:22;
% third subpopulation
co(ind,1)=rgb(1)/255;
co(ind,2)=rgb(2)/255;
co(ind,3)=rgb(3)/255;


colormap(co)



xlim(xlimit)
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('SC neurons')

set(gca,'FontSize',24)

title('significant pro/anti')

%%%% cout
hold on
plot([0 0],ylim,'w')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'w')



if(save_figures)
    saveas(gcf,'figures/singleneurons_subpopulations1','pdf')
end

return


signif2=double(abs(dp_ap)>dp_thres);


signif2=signif2(indsort,:);


figure;
imagesc(centers,1:size(matsc,1),signif2)

colormap gray
xlim(xlimit)
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('SC neurons')

set(gca,'FontSize',24)

title('significant pro/anti')

%%%% cout
hold on
plot([0 0],ylim,'w')
hold on
%%%% start of delay
plot([0 0]-(0.5+cout_time_delay),ylim,'w')
hold on
%%%% start of cue stimulus
plot([0 0]-(1.5+cout_time_delay),ylim,'w')



if(save_figures)
    saveas(gcf,'figures/singleneurons_subpopulations1b','pdf')
end











figure; plot(centers,sum(signif))

% ind1=find(good==1);
hold on
vec=centers(indmax);
% vec=centers(indmax(ind1));
plot(vec(ind1),70*ones(1,length(ind1)),'.c','MarkerSize',20)
hold on
plot(vec(ind2),70*ones(1,length(ind2)),'.y','MarkerSize',20)

ylim([0 75])
hold on
plot([-.5-cout_time_delay -.5-cout_time_delay],ylim,'k')



xlim(xlimit)
set(gca,'TickDir','out')
box off
xlabel('Time from stimulus onset (s)')
ylabel('# significant neurons')

set(gca,'FontSize',24)




if(save_figures)
    saveas(gcf,'figures/singleneurons_subpopulations2','pdf')
end




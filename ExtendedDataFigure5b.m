clear
clc
close all

load data_files/matsc
load data_files/matpfc

%%% code for Extended Data Figure 14b



%%% area to use
pop=matsc;

[dp_ap,~,dp_choice,~] = compute_dprimes_correct(pop);


[cor,p]=corr(dp_ap,dp_choice);

% figure;
% plot(cor(:),p(:),'.')
% return

% cor(p>=0.05)=0;
cor(abs(cor)<.141)=0;
cor(cor>.141)=cor(cor>.141)-.141;
cor(cor<-.141)=cor(cor<-.141)+.141;
figure;
imagesc(centers, centers,cor',[-.259 .259])
colormap(jet)
ylabel('time d'' choice')
xlabel('time d'' pro-anti')
hold on
plot(xlim,[0 0],'w--','LineWidth',2)
plot([0 0],ylim,'w--','LineWidth',2)
colorbar


axis equal
a=ylim;
xlim(a);
ylim(a);
box off
set(gca,'TickDir','out')
set(gca,'FontSize',24)

return

% vec=1:64;
vec=[1:32 32*ones(1,22) 33:64];

vec=vec(end:-1:1);

figure
imagesc(vec')
hold on
plot(xlim,[32.5 32.5],'w--','LineWidth',3)
plot(xlim,[55.5 55.5],'w--','LineWidth',3)
colormap(jet)
set(gca,'XTick',[],'YTick',[])
box off



figure
imagesc(1,[-.4 .4])
colormap(jet)
colorbar
% 
% figure;
% imagesc(.141,[-.2 .2])
% colormap(jet)






[cor,p]=corr(dp_ap,dp_choice);

% figure;
% plot(cor(:),p(:),'.')
% return

% cor(p>=0.05)=0;
cor(abs(cor)<.141)=0;
cor(cor>.141)=cor(cor>.141)-.141;
cor(cor<-.141)=cor(cor<-.141)+.141;
figure;
imagesc(centers, centers,cor,[-.2 .2])
colormap(jet)
xlabel('time d'' choice')
ylabel('time d'' pro-anti')
hold on
plot(xlim,[0 0],'w--','LineWidth',2)
plot([0 0],ylim,'w--','LineWidth',2)


blacks=2;
r=[linspace(0,0,(64-blacks)/2) linspace(0,0,blacks) linspace(0,1,(64-blacks)/2)]' ;
g=[linspace(0,0,64)]' ;
b=[linspace(1,0,(64-blacks)/2) linspace(0,0,blacks) linspace(0,0,(64-blacks)/2)]' ;
co=[r g b];
colormap(co);







[cor,p]=corr(dp_ap,dp_choice);

% figure;
% plot(cor(:),p(:),'.')
% return

cor(p>=0.05)=0;
% cor(cor>.141)=cor(cor>.141)-.141;
% cor(cor<-.141)=cor(cor<-.141)+.141;
figure;
imagesc(centers, centers,cor,[-.5 .5])
colormap(jet)
xlabel('time d'' choice')
ylabel('time d'' pro-anti')
hold on
plot(xlim,[0 0],'w--','LineWidth',2)
plot([0 0],ylim,'w--','LineWidth',2)







clear max1 max2
for i=1:193
    
    vec=dp_ap(i,:);    
    [~,ind]=max(abs(vec));
    max1(i,1)=dp_ap(i,ind);
    
    vec=dp_choice(i,:);    
    [~,ind]=max(abs(vec));
    max2(i,1)=dp_choice(i,ind);
    
end
figure
plot(max1,max2,'.k','MarkerSize',20)
title(['max, corr=' num2str(corr(max1,max2))])













load data_files/indices_subpopulations


figure
 
hold on

%%% CONTRA PREFERRING VS IPSI PREFERRING
a=dp_ap(ind2,82);  %t=0.2
b=dp_choice(ind2,82);

plot(a,b,'.k','MarkerSize',30)

xlabel('d'' pro-anti')
ylabel('d'' contra-ipsi')
set(gca,'TickDir','out')
box off
xlim([-2 2])
ylim([-2 2])
set(gca,'XTick',-2:1:2,'YTick',-2:1:2)

corr(a,b)






% dp_ap=dp_ap(:,1:10);
[cor,p]=corr(dp_ap,dp_choice);

% cor(abs(cor)<.1)=0;
cor(p>0.05)=0;
figure;
imagesc(centers, centers,cor,[-.5 .5])
colormap(jet)
xlabel('time d'' choice')
ylabel('time d'' pro-anti')
hold on
plot(xlim,[0 0],'w--','LineWidth',2)
plot([0 0],ylim,'w--','LineWidth',2)

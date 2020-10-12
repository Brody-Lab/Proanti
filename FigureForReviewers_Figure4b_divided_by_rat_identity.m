clear
clc
close all

load data_files/matsc
load data_files/matpfc

%%% area to use
pop=matsc;

[dp_ap,~,dp_choice,~] = compute_dprimes_correct(pop);



% 
% [cor,p]=corr(dp_ap,dp_choice);
% 
% 
% cor(abs(cor)<.141)=0;
% cor(cor>.141)=cor(cor>.141)-.141;
% cor(cor<-.141)=cor(cor<-.141)+.141;
% figure;
% imagesc(centers+.125, centers+.125,cor,[-.209 .209])
% colormap(jet)
% xlabel('Time d'' choice')
% ylabel('Time d'' pro-anti')
% hold on
% plot(xlim,[0 0],'w--','LineWidth',4)
% plot([0 0],ylim,'w--','LineWidth',4)
% colorbar
% 
% 
% set(gca,'TickDir','out')
% box off
% set(gca,'FontSize',24)
% 
% 
% saveas(gcf,'aaa4','pdf')
% 
% 
% 
% 
% 
% vec=[1:32 32*ones(1,43) 33:64];
% 
% vec=vec(end:-1:1);
% 
% figure
% imagesc(vec')
% hold on
% plot(xlim,[32.5 32.5],'w--','LineWidth',3)
% plot(xlim,[76.5 76.5],'w--','LineWidth',3)
% colormap(jet)
% set(gca,'XTick',[],'YTick',[])
% box off
% saveas(gcf,'aaa2','pdf')
% 
% 
% 
% figure
% imagesc(1,[-.35 .35])
% colormap(jet)
% colorbar
% saveas(gcf,'aaa3','pdf')
% 
% return






% 
% 
% % 
% 
% clear max1 max2
% for i=1:193
%     
%     vec=dp_ap(i,:);    
%     [~,ind]=max(abs(vec));
%     max1(i,1)=dp_ap(i,ind);
%     
%     vec=dp_choice(i,:);    
%     [~,ind]=max(abs(vec));
%     max2(i,1)=dp_choice(i,ind);
%     
% end
% % max1(max1<-5)=-5;
% figure
% plot(max1,max2,'.k','MarkerSize',10)
% title(['max, corr=' num2str(corr(max1,max2))])
% 
% xlim([-8 4])
% ylim([-4 5])
% xlabel('d'' pro-anti')
% ylabel('d'' contra-ipsi')
% set(gca,'TickDir','out')
% box off
% set(gca,'FontSize',24)




load data_files/indices_subpopulations


figure
 
hold on

%%% CONTRA PREFERRING VS IPSI PREFERRING
a=dp_ap(ind2,82);  %t=0.2
b=dp_choice(ind2,82);

% plot(a,b,'.k','MarkerSize',30)


hold on

colo='brckg';
load data_files/ratti

ra=ra(ind2);
rai=unique(ra);

for i=1:5
   
    rao=rai{i}
    
    clear stra
    for j=1:45
       
        stra(j)=strcmp(ra{j},rao);
        
    end
    
    ind=find(stra==1);
    
    plot(a(ind),b(ind),['.' colo(i)],'MarkerSize',40)

%     
%     p = polyfit(a(ind),b(ind),1);
%     vec=[min(a(ind)) max(a(ind))];
%     plot(vec,p(2)+p(1)*vec,['.-' colo(i)],'LineWidth',3)

    
    
end


p = polyfit(a,b,1);
plot([-2 2],p(2)+p(1)*[-2 2],['-' 'k'],'LineWidth',3)


xlabel('pro/anti')
ylabel('contra/ipsi')
legend(rai)

hold on



plot(xlim,[0 0],'k--','LineWidth',2)
plot([0 0],ylim,'k--','LineWidth',2)

set(gca,'TickDir','out','XTick',[-2:1:2],'YTick',[-2:1:2])
set(gca,'FontSize',24)
box off

axis square
return


xlabel('d'' pro-anti')
ylabel('d'' contra-ipsi')
set(gca,'TickDir','out')
box off
xlim([-2 2])
ylim([-2 2])
set(gca,'XTick',-2:1:2,'YTick',-2:1:2)

corr(a,b)


set(gca,'FontSize',24)

set

return

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
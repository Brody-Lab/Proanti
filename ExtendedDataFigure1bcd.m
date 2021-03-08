function [  ] = ExtendedDataFigure1bcd( EDF1_data )
%  Summary of this function goes here
%   This function takes post-surgery behavioral data from opto and phys
%   rats and plot RT, accuracy, and switch cost on Pro and Anti trials
%   across rats, as in EDF1 in Duan_2020
%   First load EDF1_data
%   Then run ExtendedDataFigure1(EDF1_data)

% EDF1_data contains, for each session:
%   pd                 information for all the trials from that session
%   sessid             session id for that session
%   ratname            ratname for that session


%% Intialize meta arrays for all the rats

    rats = unique(EDF1_data.ratname);
    P_perf_all = nan(numel(rats),1);
    A_perf_all = P_perf_all;
    P_perf_all_sem = P_perf_all;
    A_perf_all_sem = P_perf_all;
    P_h_RT_all = P_perf_all;
    A_h_RT_all = P_perf_all;
    P_e_RT_all = P_perf_all;
    A_e_RT_all = P_perf_all;
    P_sw_all = P_perf_all;
    A_sw_all = P_perf_all;

%% Process data for each rat

    for i=1:numel(rats)
        
        this_rat = rats(i);
        all_sessions = EDF1_data.pd(strcmp(EDF1_data.ratname,this_rat)==1);
        num_sess = numel(all_sessions);
        
        %initialization this_rat arrays
        P_perf = nan(num_sess,1);
        A_perf = P_perf;
        R = nan(num_sess,4); %for 4 conditions, P/A correct/error
        P2A = [];
        A2P = [];
        P_block = [];
        A_block = [];
        
        %Now analyze each session for this rat
        for ns = 1:num_sess
           
            pd = all_sessions{ns};
            pro = pd.side_lights ==1; %Pro
            hits = pd.hits; %Correct
            cpv = pd.cpv ==1; %fixtion violation trials
                  
            %%%accuracy (get session mean, later rat mean)
            P_perf(ns) = nanmean(hits(~cpv & pro));
            A_perf(ns) = nanmean(hits(~cpv & ~pro));
            
            %%%RT (get session median, later rat mean)
            RT=pd.mt;
            T{1}= pro &  pd.hits==1 & ~cpv; %Pro correct
            T{2}= pro &  pd.hits==0 & ~cpv; %Pro error
            T{3}=~pro &  pd.hits==1 & ~cpv; %Anti correct
            T{4}=~pro &  pd.hits==0 & ~cpv; %Anti error

            for rx=1:4
                thisRT=RT(T{rx});
                thisRT(thisRT<=0)=nan;
                thisRT(thisRT>2.5)=nan;
                R(ns,rx)=nanmedian(thisRT);
            end
                        
            %%%switch trial analysis
            ctx = pd.side_lights; 
            swt=diff(ctx); %switch trials
            p2a=swt==-2; %Pro to Anti switch trials
            p2a=[false;p2a]; % p2a=logical(p2a); %logical index of switches from pro to anti
            a2p=swt==2; %Anti to Pro switch trials
            a2p=[false;a2p]; %  a2p=logical(a2p); %logical index of switches from Anti to Pro
                
            %Now concatenate across sessions for each rat
            P2A = [P2A; hits(~cpv & p2a)];
            A2P = [A2P; hits(~cpv & a2p)];
            P_block = [P_block; hits(~cpv & pro & ~a2p)];
            A_block = [A_block; hits(~cpv & ~pro & ~p2a)];
            
        end   
        
        P_perf_all(i) = nanmean(P_perf);
        A_perf_all(i) = nanmean(A_perf);
        P_perf_all_sem(i) = nanstderr(P_perf);
        A_perf_all_sem(i) = nanstderr(P_perf);
        P_h_RT_all(i) = nanmean(R(:,1));
        P_e_RT_all(i) = nanmean(R(:,2));
        A_h_RT_all(i) = nanmean(R(:,3));
        A_e_RT_all(i) = nanmean(R(:,4));
        P_sw_all(i) = nanmean(A2P) - nanmean(P_block);
        A_sw_all(i) = nanmean(P2A) - nanmean(A_block);
        
    end
    
        
%% Plotting

    %%% Setup
    h=figure(202001); clf;
    set(202001,'PaperPosition',[1 1 6 6]);
    ax1=axes('Position',[0.2 0.55 0.15 0.25]); %RT all rats
    ax2=axes('Position',[0.55 0.55 0.12 0.25]); %RT correct bar
    ax3=axes('Position',[0.75 0.55 0.15 0.25]); %RT hit-err
    ax4=axes('Position',[0.2 0.22 0.11 0.14]); %performance mean
    ax5=axes('Position',[0.42 0.2 0.18 0.18]); %performnace all rats

    % RT all individual rats
    hold(ax1,'on');
    plot(ax1,[1 1.3],[A_h_RT_all P_h_RT_all],'-ok','MarkerSize',2,'MarkerFaceColor','k','MarkerEdgeColor','k');
    plot(ax1,1,A_h_RT_all,'o','MarkerSize',2,'MarkerFaceColor',pro_color,'MarkerEdgeColor',anti_color);
    plot(ax1,1.3,P_h_RT_all,'o','MarkerSize',2,'MarkerFaceColor',anti_color,'MarkerEdgeColor',pro_color);
    set(ax1,'Xlim',[0.9 1.4]);
    set(ax1,'XTick',[1 1.3],'XTickLabel',{'Anti','Pro'},'TickDir','out','TickLength',[0.01 0.01]);
    set(ax1,'Ylim',[min(min([A_h_RT_all;A_h_RT_all]))-0.05 max(max([A_h_RT_all;A_h_RT_all]))+0.05]);
    ylabel(ax1,'RT (s)');
    title(ax1,'Correct RT');

    % RT correct difference (Pro - Anti) bar
    hold(ax2,'on');
    plot(ax2,[0 1],[0 0],'k');
    diff_Ph_Ah = A_h_RT_all - P_h_RT_all; %Correct Anti -correct Pro
    errorbar(ax2,0.5,1000*nanmean(diff_Ph_Ah),1000*nanstderr(diff_Ph_Ah),'Marker','none','LineWidth',1,'Color','k','LineStyle','none');
    bar(ax2,0.5,1000*nanmean(diff_Ph_Ah),'BarWidth',0.3,'FaceColor',[1 1 1],'LineWidth',1);
    plot(ax2,0.6,1000*diff_Ph_Ah,'.','Color',[0.5 0.5 0.5]);
    set(ax2,'XTick',0.5,'XTickLabel',{'hits(A-P)'},'TickDir','out','TickLength',[0.01 0.01]);
    set(ax2,'Xlim',[0.2 0.8]);
    set(ax2,'Ylim',[-20 200]);
    ylabel(ax2,'\Delta RT (ms)');    
    title(ax2,'Anti - Pro');
    
    % RT correct difference (Pro - Anti) bar
    hold(ax3,'on');
    plot(ax3,[0 1],[0 0],'k');
    diff_Ph_Pe = P_h_RT_all - P_e_RT_all; %Correct Pro - error Pro
    diff_Ah_Ae = A_h_RT_all - A_e_RT_all; %Correct Anti - error Anti
    errorbar(ax3,[0.3 0.7],1000*[nanmean(diff_Ph_Pe) nanmean(diff_Ah_Ae)],1000*[nanstderr(diff_Ph_Pe) nanstderr(diff_Ah_Ae)],'Marker','none','LineWidth',1,'Color','k','LineStyle','none');
    bar(ax3,0.3,1000*nanmean(diff_Ph_Pe),'BarWidth',0.3,'FaceColor',pro_color,'LineWidth',1);
    bar(ax3,0.7,1000*nanmean(diff_Ah_Ae),'BarWidth',0.3,'FaceColor',anti_color,'LineWidth',1);
    plot(ax3,0.2,1000*diff_Ph_Pe,'.','Color',[0.5 0.5 0.5]);
    plot(ax3,0.8,1000*diff_Ah_Ae,'.','Color',[0.5 0.5 0.5]);
    set(ax3,'XTick',[0.3 0.7],'XTickLabel',{'Pro','Anti'},'TickDir','out','TickLength',[0.01 0.01]);
    set(ax3,'Xlim',[0 1]);
    set(ax3,'Ylim',[-170 130]);
    title(ax3,'hit - error');

    % performance mean (insert)
    hold(ax4,'on');
    errorbar(ax4,[0.3 0.7],100*[nanmean(P_perf_all) nanmean(A_perf_all)],100*[nanstderr(P_perf_all) nanstderr(A_perf_all)],'Marker','none','LineWidth',1,'Color','k','LineStyle','none');
    bar(ax4,0.3,100*nanmean(P_perf_all),'BarWidth',0.2,'FaceColor',pro_color,'LineWidth',1);
    bar(ax4,0.7,100*nanmean(A_perf_all),'BarWidth',0.2,'FaceColor',anti_color,'LineWidth',1);
    plot(ax4,0.25,100*P_perf_all,'.','Color',[0.5 0.5 0.5]);
    plot(ax4,0.75,100*A_perf_all,'.','Color',[0.5 0.5 0.5]);
    set(ax4,'XTick',[0.3 0.7],'XTickLabel',{'Pro','Anti'},'TickDir','out','TickLength',[0.01 0.01]);
    set(ax4,'YTick',[65 70 75],'YTickLabel',{' ',' ','75'},'TickDir','out','TickLength',[0.01 0.01]);
    set(ax4,'Xlim',[0 1]);
    set(ax4,'Ylim',[65 81]);
    ylabel(ax4,'% correct');   
    
    % performance all rats
    hold(ax5,'on');
    plot(ax5,[0 100],[0 100],'--','Color',[0.5 0.5 0.5]);
    errorxy(100*[P_perf_all A_perf_all P_perf_all_sem A_perf_all_sem],'ColXe',[4,4],'EdgeColor','k','Marker','none','WidthEB',1);
    set(ax5,'Xlim',[64 83]);
    set(ax5,'Ylim',[64 83]);
    axis square;
    ylabel(ax5,'Anti % correct');
    xlabel(ax5,'Pro % correct');
    title(ax5,'Performance');
    set(ax5,'XTick',[70 75 80 85],'XTickLabel',{'70','75','80','85'},'TickDir','out','TickLength',[0.025 0.01]);
    set(ax5,'YTick',[70 75 80 85],'XTickLabel',{'70','75','80','85'},'TickDir','out','TickLength',[0.025 0.01]);

    % switch cost
    ax6=axes('Position',[0.75 0.15 0.15 0.25]); %switch cost
    hold(ax6,'on');
    plot(ax6,[0 1],[0 0],'k');
    errorbar(ax6,[0.3 0.7],100*[nanmean(P_sw_all) nanmean(A_sw_all)],100*[nanstderr(P_sw_all) nanstderr(A_sw_all)],'Marker','none','LineWidth',1,'Color','k','LineStyle','none');
    bar(ax6,0.3,100*nanmean(P_sw_all),'BarWidth',0.25,'FaceColor',pro_color,'LineWidth',1);
    bar(ax6,0.7,100*nanmean(A_sw_all),'BarWidth',0.25,'FaceColor',anti_color,'LineWidth',1);
    plot(ax6,0.25,100*P_sw_all,'.','Color',[0.5 0.5 0.5]);
    plot(ax6,0.75,100*A_sw_all,'.','Color',[0.5 0.5 0.5]);
    set(ax6,'XTick',[0.3 0.7],'XTickLabel',{'A2P','P2A'},'TickDir','out','TickLength',[0.01 0.01]);
    set(ax6,'Xlim',[0 1]);
    set(ax6,'Ylim',[-40 5]);
    ylabel(ax6,'switch - block trials (%)');
    title(ax6,'Switch cost');
    
    %%% Post-processing
    set([ax1 ax2 ax3 ax4 ax5 ax6],'Box','Off');
    keyboard;
    
end

function y=pro_color
    % the color for Pro trials
    y=[13 102 1]/255;

end

function y=anti_color
    % the color for Anti trials
    y=[255 103 0]/255;

end
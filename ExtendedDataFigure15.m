function [ ] = Duan_NN_EDF15( opto_table, YFP_table)
% DUAN_NN_EDF5 Summary of this function goes here
%   This function takes bilateral SC optogenetic inactivaiton data and YFP
%   control data as input and conduct analysis/plotting for EDF 15
%   First load opto_table and YFP_table

% opto(YFP)_table contains, for each trial:
%   Rat                  the rat who did that trial;
%   Session_ID           the sesion each trial belonged to;
%   isSwitch             whether it is a switch trial;
%   isPro                whether it is a Pro trial;
%   isCPV                whether it is a center poke violation trial;
%   isStim               whether it is a laser stimulation trial;
%   Stim_Type            the type of laser stimulation;
%   Stim_Duration        the duration of laser stimulation;
%   Stim_Start           the onset time of laser stimulation;
%   Correct              whether it is a correct trial;
%   Correct_Norm         normalized accuracy - compared to the accuracy of 
%                        non-laser control trials in the same session,
%                        mean-substraction normalization is done separately 
%                        for Pro and Anti trials;
%   RT                   the response time (RT) of this trial;
%   RT_Norm              normalized RT - compared to the RT of non-laser
%                        control trials int he same session,
%                        median-substraction normalization is done
%                        separately for Pro and Anti; corret and error
%                        trials respectively.

% You can also do your own version of within-session normalizaiton of
% accuracy and RT using Correct and RT from the same session; all the
% following anlayses 


%% Organize data table into different opto experiments
    
    %%% excluding violation trials and switch trials
    inc = ~opto_table.isCPV & ~opto_table.isSwitch;    
    inc_YFP = ~YFP_table.isCPV & ~YFP_table.isSwitch;    

    %%% data  for full-trial, rule, delay, and choice period inactivations
    % we analyzed epoch-specific effects for 8/9 rats with full-trial
    % effects (excluding A168)
    opto_table_inc = opto_table(inc & strcmp(opto_table.Rat,'A168')~=1,:);
    table_full = opto_table_inc(opto_table_inc.Stim_Type == 4,:);
    table_rule = opto_table_inc(opto_table_inc.Stim_Type == 1,:);
    table_delay = opto_table_inc(opto_table_inc.Stim_Type == 2,:);
    table_choice = opto_table_inc(opto_table_inc.Stim_Type == 3,:);
    
    %%% YFP control data epoch-specific inactivations
    table_full_Y = YFP_table(inc_YFP & YFP_table.Stim_Type == 4,:);
    table_rule_Y = YFP_table(inc_YFP & YFP_table.Stim_Type == 1,:);
    table_delay_Y = YFP_table(inc_YFP & YFP_table.Stim_Type == 2,:);
    table_choice_Y = YFP_table(inc_YFP & YFP_table.Stim_Type == 3,:);
    
    
%% Calculations for plotting epoch-specific effects on accuracy (EDF15a)

    %%% confidence interval for plotting
    sigma = 68;
    low_end = 50 - sigma/2;
    high_end = 50 + sigma/2;
    
    %%% Calculate bootstrapped mean and CI for each experiment
    % full-trial inactivation, Pro and Anti
        P_f = bootstrp(1000, @nanmean, table_full(table_full.isPro==1,:).Correct_Norm);
        muP_f = prctile(P_f,50);
        ciP_f = prctile(P_f,[low_end high_end]);
        A_f = bootstrp(1000, @nanmean, table_full(~table_full.isPro,:).Correct_Norm);
        muA_f = prctile(A_f,50);
        ciA_f = prctile(A_f,[low_end high_end]);
    
    % rule period inactivation, Pro and Anti
        P_r = bootstrp(1000, @nanmean, table_rule(table_rule.isPro==1,:).Correct_Norm);
        muP_r = prctile(P_r,50);
        ciP_r = prctile(P_r,[low_end high_end]);
        A_r = bootstrp(1000, @nanmean, table_rule(~table_rule.isPro,:).Correct_Norm);
        muA_r = prctile(A_r,50);
        ciA_r = prctile(A_r,[low_end high_end]);
        
    % delay period inactivation, Pro and Anti
        P_d = bootstrp(1000, @nanmean, table_delay(table_delay.isPro==1,:).Correct_Norm);
        muP_d = prctile(P_d,50);
        ciP_d = prctile(P_d,[low_end high_end]);
        A_d = bootstrp(1000, @nanmean, table_delay(~table_delay.isPro,:).Correct_Norm);
        muA_d = prctile(A_d,50);
        ciA_d = prctile(A_d,[low_end high_end]);
        
    % choice period inactivation, Pro and Anti
        P_c = bootstrp(1000, @nanmean, table_choice(table_choice.isPro==1,:).Correct_Norm);
        muP_c = prctile(P_c,50);
        ciP_c = prctile(P_c,[low_end high_end]);
        A_c = bootstrp(1000, @nanmean, table_choice(~table_choice.isPro,:).Correct_Norm);
        muA_c = prctile(A_c,50);
        ciA_c = prctile(A_c,[low_end high_end]);
    
    % full-trial YFP, Pro and Anti
        P_f_Y = bootstrp(1000, @nanmean, table_full_Y(table_full_Y.isPro==1,:).Correct_Norm);
        muP_f_Y = prctile(P_f_Y,50);
        ciP_f_Y = prctile(P_f_Y,[low_end high_end]);
        A_f_Y = bootstrp(1000, @nanmean, table_full_Y(~table_full_Y.isPro,:).Correct_Norm);
        muA_f_Y = prctile(A_f_Y,50);
        ciA_f_Y = prctile(A_f_Y,[low_end high_end]);
    
    % rule period YFP, Pro and Anti
        P_r_Y = bootstrp(1000, @nanmean, table_rule_Y(table_rule_Y.isPro==1,:).Correct_Norm);
        muP_r_Y = prctile(P_r_Y,50);
        ciP_r_Y = prctile(P_r_Y,[low_end high_end]);
        A_r_Y = bootstrp(1000, @nanmean, table_rule_Y(~table_rule_Y.isPro,:).Correct_Norm);
        muA_r_Y = prctile(A_r_Y,50);
        ciA_r_Y = prctile(A_r_Y,[low_end high_end]);
        
    % delay period YFP, Pro and Anti
        P_d_Y = bootstrp(1000, @nanmean, table_delay_Y(table_delay_Y.isPro==1,:).Correct_Norm);
        muP_d_Y = prctile(P_d_Y,50);
        ciP_d_Y = prctile(P_d_Y,[low_end high_end]);
        A_d_Y = bootstrp(1000, @nanmean, table_delay_Y(~table_delay_Y.isPro,:).Correct_Norm);
        muA_d_Y = prctile(A_d_Y,50);
        ciA_d_Y = prctile(A_d_Y,[low_end high_end]);
        
    % choice period YFP, Pro and Anti
        P_c_Y = bootstrp(1000, @nanmean, table_choice_Y(table_choice_Y.isPro==1,:).Correct_Norm);
        muP_c_Y = prctile(P_c_Y,50);
        ciP_c_Y = prctile(P_c_Y,[low_end high_end]);
        A_c_Y = bootstrp(1000, @nanmean, table_choice_Y(~table_choice_Y.isPro,:).Correct_Norm);
        muA_c_Y = prctile(A_c_Y,50);
        ciA_c_Y = prctile(A_c_Y,[low_end high_end]);

        
%% Calculations for plotting epoch-specific effects on RT (EDF15b)

    %%% Set up for histogram params
    bin_size = 0.05;
    x_lim = 1.5;
    bins = -x_lim:bin_size:x_lim;
    
    % full-trial inactivation, Pro and Anti
    [n_f, muRT_f, ciRT_f, y_lim_f] = plot_RT_hist(table_full(table_full.isPro ==1& table_full.Correct == 1,:).RT_Norm, table_full(~table_full.isPro& table_full.Correct == 1,:).RT_Norm, bins, low_end ,high_end);
    
    % rule inactivation, Pro and Anti
    [n_r, muRT_r, ciRT_r, y_lim_r] = plot_RT_hist(table_rule(table_rule.isPro ==1 & table_rule.Correct == 1,:).RT_Norm, table_rule(~table_rule.isPro& table_rule.Correct == 1,:).RT_Norm, bins, low_end ,high_end);

    % delay inactivation, Pro and Anti
    [n_d, muRT_d, ciRT_d, y_lim_d] = plot_RT_hist(table_delay(table_delay.isPro ==1& table_delay.Correct == 1,:).RT_Norm, table_delay(~table_delay.isPro& table_delay.Correct == 1,:).RT_Norm, bins, low_end ,high_end);

    % choice inactivation, Pro and Anti
    [n_c, muRT_c, ciRT_c, y_lim_c] = plot_RT_hist(table_choice(table_choice.isPro ==1& table_choice.Correct == 1,:).RT_Norm, table_choice(~table_choice.isPro& table_choice.Correct == 1,:).RT_Norm, bins, low_end ,high_end);

    
%% Plotting

    %%% Setup
    h=figure(2020015); clf;
    set(2020015,'PaperPosition',[1 1 6 6]);
    ax1=axes('Position',[0.34 0.5 0.12 0.16]);
    ax2=axes('Position',[0.56 0.5 0.12 0.16]);
    ax3=axes('Position',[0.78 0.5 0.12 0.16]);
    ax4=axes('Position',[0.12 0.5 0.12 0.16]); %full trial

    % rule period: error increase (%) due to inactivation
    hold(ax1,'on');
    plot(ax1,[0 1],[0 0],'k');
    errorbar(ax1, [0.30],-100*[muP_r],100*[(ciP_r(2)-ciP_r(1))/2],'Marker','o','Color',pro_color);
    errorbar(ax1, [0.60],-100*[muA_r],100*[(ciA_r(2)-ciA_r(1))/2],'Marker','o','Color',anti_color);
    errorbar(ax1, [0.4 0.7],-100*[muP_r_Y muA_r_Y],100*[(ciP_r_Y(2)-ciP_r_Y(1))/2 (ciA_r_Y(2)-ciA_r_Y(1))/2],'Marker','o','Color',[0.5 0.5 0.5],'LineStyle','none');
    title(ax1,'Task cue');

    % delay period: error increase (%) due to inactivation
    hold(ax2,'on');
    plot(ax2,[0 1],[0 0],'k');
    errorbar(ax2, [0.30],-100*[muP_d],100*[(ciP_d(2)-ciP_d(1))/2],'Marker','o','Color',pro_color);
    errorbar(ax2, [0.60],-100*[muA_d],100*[(ciA_d(2)-ciA_d(1))/2],'Marker','o','Color',anti_color);
    errorbar(ax2, [0.4 0.7],-100*[muP_d_Y muA_d_Y],100*[(ciP_d_Y(2)-ciP_d_Y(1))/2 (ciA_d_Y(2)-ciA_d_Y(1))/2],'Marker','o','Color',[0.5 0.5 0.5],'LineStyle','none');
    title(ax2,'Delay');

    % choice period: error increase (%) due to inactivation
    hold(ax3,'on');
    plot(ax3,[0 1],[0 0],'k');
    errorbar(ax3, [0.35],-100*[muP_c],100*[(ciP_c(2)-ciP_c(1))/2],'Marker','o','Color',pro_color);
    errorbar(ax3, [0.65],-100*[muA_c],100*[(ciA_c(2)-ciA_c(1))/2],'Marker','o','Color',anti_color);
    errorbar(ax3, [0.4 0.7],-100*[muP_c_Y muA_c_Y],100*[(ciP_c_Y(2)-ciP_c_Y(1))/2 (ciA_c_Y(2)-ciA_c_Y(1))/2],'Marker','o','Color',[0.5 0.5 0.5],'LineStyle','none');
    title(ax3,'Choice');

    % full trial: error increase (%) due to inactivation
    hold(ax4,'on');
    plot(ax4,[0 1],[0 0],'k');
    errorbar(ax4, [0.35],-100*[muP_f],100*[(ciP_f(2)-ciP_f(1))/2],'Marker','o','Color',pro_color);
    errorbar(ax4, [0.65],-100*[muA_f],100*[(ciA_f(2)-ciA_f(1))/2],'Marker','o','Color',anti_color);
    errorbar(ax4, [0.4 0.7],-100*[muP_f_Y muA_f_Y],100*[(ciP_f_Y(2)-ciP_f_Y(1))/2 (ciA_f_Y(2)-ciA_f_Y(1))/2],'Marker','o','Color',[0.5 0.5 0.5],'LineStyle','none');
    title(ax4,'Full trial');

    %%% RT setup
    ax5=axes('Position',[0.34 0.2 0.14 0.16]);
    ax6=axes('Position',[0.56 0.2 0.14 0.16]);
    ax7=axes('Position',[0.78 0.2 0.14 0.16]);
    ax8=axes('Position',[0.12 0.2 0.14 0.16]); %full trial
    colors{1} = pro_color;
    colors{2} = anti_color;
    
    % rule period: RT changes (ms) due to inactivation
    hold(ax5,'on');
    plot(ax5,[0 0],[-0.5 0.5],'Color',[0.5 0.5 0.5]);
    plot(ax5,[-1 1],[0 0],'Color',[0.5 0.5 0.5]);
    for rx=1:2      
        tmu=muRT_r(rx);
        clr=colors{rx};
        if rx ==1, 
          ty=0.95*y_lim_r;
        else
          n_r(rx,:)=-1*n_r(rx,:);
          ty=-0.95*y_lim_r;
        end
        h1(rx)=stairs(ax5,bins,n_r(rx,:));
        m1(rx)=plot(ax5,[tmu tmu],[0 ty],'Color',clr,'Linewidth',1);
        ch1(rx)=plot(ax5,[ciRT_r(rx,1) ciRT_r(rx,2)], [ty ty],'Color',clr,'Linewidth',1);
        set([h1(rx) ch1(rx)],'Color',clr,'Linewidth',1);
    end
    set(ax5,'Ylim',1.2*[-1*max(y_lim_r) max(y_lim_r)]);
    title(ax5,'Task cue');

    % delay period: RT changes (ms) due to inactivation
    hold(ax6,'on');
    plot(ax6,[0 0],[-0.5 0.5],'Color',[0.5 0.5 0.5]);
    plot(ax6,[-1 1],[0 0],'Color',[0.5 0.5 0.5]);
    for rx=1:2      
        tmu=muRT_d(rx);
        clr=colors{rx};
        if rx ==1, 
          ty=0.95*y_lim_d;
        else
          n_d(rx,:)=-1*n_d(rx,:);
          ty=-0.95*y_lim_d;
        end
        h1(rx)=stairs(ax6,bins,n_d(rx,:));
        m1(rx)=plot(ax6,[tmu tmu],[0 ty],'Color',clr,'Linewidth',1);
        ch1(rx)=plot(ax6,[ciRT_d(rx,1) ciRT_d(rx,2)], [ty ty],'Color',clr,'Linewidth',1);
        set([h1(rx) ch1(rx)],'Color',clr,'Linewidth',1);
    end
    set(ax6,'Ylim',1.2*[-1*max(y_lim_d) max(y_lim_d)]);
    title(ax6,'Delay');

    % choice period: RT changes (ms) due to inactivation
    hold(ax7,'on');
    plot(ax7,[0 0],[-0.5 0.5],'Color',[0.5 0.5 0.5]);
    plot(ax7,[-1 1],[0 0],'Color',[0.5 0.5 0.5]);
    for rx=1:2      
    tmu=muRT_c(rx);
    clr=colors{rx};
    if rx ==1, 
      ty=0.95*y_lim_c;
    else
      n_c(rx,:)=-1*n_c(rx,:);
      ty=-0.95*y_lim_c;
    end
    h1(rx)=stairs(ax7,bins,n_c(rx,:));
    m1(rx)=plot(ax7,[tmu tmu],[0 ty],'Color',clr,'Linewidth',1);
    ch1(rx)=plot(ax7,[ciRT_c(rx,1) ciRT_c(rx,2)], [ty ty],'Color',clr,'Linewidth',1);
    set([h1(rx) ch1(rx)],'Color',clr,'Linewidth',1);
    end
    set(ax7,'Ylim',1.2*[-1*max(y_lim_c) max(y_lim_c)]);
    title(ax7,'Choice');

    % full trial period: RT changes (ms) due to inactivation
    hold(ax8,'on');
    plot(ax8,[0 0],[-0.5 0.5],'Color',[0.5 0.5 0.5]);
    plot(ax8,[-1 1],[0 0],'Color',[0.5 0.5 0.5]);
    for rx=1:2      
    tmu=muRT_f(rx);
    clr=colors{rx};
    if rx ==1, 
      ty=0.95*y_lim_f;
    else
      n_f(rx,:)=-1*n_f(rx,:);
      ty=-0.95*y_lim_f;
    end
    h1(rx)=stairs(ax8,bins,n_f(rx,:));
    m1(rx)=plot(ax8,[tmu tmu],[0 ty],'Color',clr,'Linewidth',1);
    ch1(rx)=plot(ax8,[ciRT_f(rx,1) ciRT_f(rx,2)], [ty ty],'Color',clr,'Linewidth',1);
    set([h1(rx) ch1(rx)],'Color',clr,'Linewidth',1);
    end
    set(ax8,'Ylim',1.2*[-1*max(y_lim_f) max(y_lim_f)]);
    title(ax8,'Full trial');

    %%% Post-processing
    ylabel(ax4,'%Error Increase');
    ylabel(ax8,'Fraction of trials');
    xlabel(ax5,'Changes in RT (ms)');
    set([ax1 ax2 ax3 ax4],'Xlim',[0.2 0.85]);
    set([ax5 ax6 ax7 ax8],'Xlim',[-0.3 0.4]);
    set([ax1 ax2 ax3],'Ylim',[-9 12]);
    set(ax4,'Ylim',[-12 20]);
    set([ax1 ax2 ax3 ax4],'XTick',[0.35 0.65]);
    set([ax1 ax2 ax3 ax4],'XTickLabel',{'' ''},'TickDir','out','TickLength',[0.025 0.01]);
    set([ax5 ax6 ax7 ax8],'XTick',[-0.25 0 0.25],'XTickLabel',{'-250','0','250',},'TickDir','out','TickLength',[0.02 0.02]);
    set([ax1 ax2 ax3 ax4 ax5 ax6 ax7 ax8],'Box','Off');

    ch = get(h, 'Children');
    pp = findobj(ch,'Color', pro_color);
    set(pp,'MarkerFaceColor',pro_color);
    pa=findobj(ch,'Color',anti_color);
    set(pa,'MarkerFaceColor',anti_color);
    pm=findobj(ch,'Marker','o');
    set(pm,'Marker','o','MarkerSize',4);
    pl=findobj(ch,'LineWidth',0.5);
    set(pl,'LineWidth',1);
    
    %keyboard;
    
    
end

function  [n, muRT, ciRT, y_lim] = plot_RT_hist(RT_opto_P, RT_opto_A, bins, low_end, high_end)

    n=nan(2,numel(bins));
    muRT=nan(2,1);
    ciRT=nan(2,2);
    maxy=muRT;    

    % PRO
    n(1,:)=hist(RT_opto_P,bins);
    n(1,:)=n(1,:)/sum(n(1,:));
    B=bootstrp(5000,@nanmedian,RT_opto_P);
    muRT(1)=prctile(B,50);
    ciRT(1,:)=prctile(B,[low_end high_end]);
    maxy(1)=max([maxy(1) n(1,:)]);  
    
    % ANTI
    n(2,:)=hist(RT_opto_A,bins);
    n(2,:)=n(1,:)/sum(n(1,:));
    B=bootstrp(5000,@nanmedian,RT_opto_A);
    muRT(2)=prctile(B,50);
    ciRT(2,:)=prctile(B,[low_end high_end]);
    maxy(2)=max([maxy(1) n(1,:)]);  
    
    y_lim=max(maxy)*1.2;

end

function y=pro_color
    % the color for Pro trials
    y=[13 102 1]/255;

end

function y=anti_color
    % the color for Anti trials
    y=[255 103 0]/255;

end
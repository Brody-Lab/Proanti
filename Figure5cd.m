function [  ] = Duan_NN_Fig5( opto_table )
% DUAN_NN_FIG5 Summary of this function goes here
%   This function takes bilateral SC optogenetic inactivaiton data as input
%   and conducts statistical anlaysis for plots in Fig. 5 in Duan_2020
%   First load opto_table

% opto_table contains, for each trial:
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
    
    %%% data to plot full-trial effects for individual rats
    table_full_rat = opto_table(inc & (opto_table.Stim_Type == 4 | ~opto_table.isStim),:);
    
    %%% data  for full-trial, rule, delay, and choice period inactivations
    % we analyzed epoch-specific effects for 8/9 rats with full-trial
    % effects (excluding A168)
    opto_table_inc = opto_table(inc & strcmp(opto_table.Rat,'A168')~=1,:);
    table_full = opto_table_inc(opto_table_inc.Stim_Type == 4,:);
    table_rule = opto_table_inc(opto_table_inc.Stim_Type == 1,:);
    table_delay = opto_table_inc(opto_table_inc.Stim_Type == 2,:);
    table_choice = opto_table_inc(opto_table_inc.Stim_Type == 3,:);
    table_control = opto_table_inc(~opto_table_inc.isStim,:);

    
%% Calculations for plotting effects across rats (Fig. 5c left)
    
    n_rat = unique(table_full_rat.Rat);
    Anti_effect = nan(numel(n_rat),1);
    Pro_effect = Anti_effect;
    
    for nr = 1:numel(n_rat)
        
        this_rat_table = table_full_rat(strcmp(table_full_rat.Rat,n_rat(nr))==1,:);
        Anti_effect(nr) = nanmean(this_rat_table(~this_rat_table.isPro & this_rat_table.Stim_Type == 4,:).Correct - nanmean(this_rat_table(~this_rat_table.isPro & ~this_rat_table.isStim,:).Correct));
        Pro_effect(nr) = nanmean(this_rat_table(this_rat_table.isPro==1 & this_rat_table.Stim_Type == 4,:).Correct - nanmean(this_rat_table(this_rat_table.isPro == 1 & ~this_rat_table.isStim,:).Correct));
        
    end
    
    
%% Calculations for plotting epoch-specific effects (Fig. 5c right, Fig. 5d)

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
    
        
%% Plotting

    %%% Setup
    h=figure(20205); clf;
    set(20205,'PaperPosition',[1 1 5 5]);
    ax1=axes('Position',[0.125 0.15 0.18 0.25]);
    ax2=axes('Position',[0.425 0.15 0.18 0.25]);
    ax3=axes('Position',[0.725 0.15 0.18 0.25]);
    ax4=axes('Position',[0.425 0.55 0.18 0.25]);
    ax8=axes('Position',[0.125 0.55 0.18 0.25]);

    % rule period: error increase (%) due to inactivation
    hold(ax1,'on');
    plot(ax1,[0 1],[0 0],'k');
    errorbar(ax1, [0.35],-100*[muP_r],100*[(ciP_r(2)-ciP_r(1))/2],'Marker','o','Color',pro_color);
    errorbar(ax1, [0.65],-100*[muA_r],100*[(ciA_r(2)-ciA_r(1))/2],'Marker','o','Color',anti_color);
    title(ax1,'Task cue');

    % delay period: error increase (%) due to inactivation
    hold(ax2,'on');
    plot(ax2,[0 1],[0 0],'k');
    errorbar(ax2, [0.35],-100*[muP_d],100*[(ciP_d(2)-ciP_d(1))/2],'Marker','o','Color',pro_color);
    errorbar(ax2, [0.65],-100*[muA_d],100*[(ciA_d(2)-ciA_d(1))/2],'Marker','o','Color',anti_color);
    title(ax2,'Delay');

    % choice period: error increase (%) due to inactivation
    hold(ax3,'on');
    plot(ax3,[0 1],[0 0],'k');
    errorbar(ax3, [0.35],-100*[muP_c],100*[(ciP_c(2)-ciP_c(1))/2],'Marker','o','Color',pro_color);
    errorbar(ax3, [0.65],-100*[muA_c],100*[(ciA_c(2)-ciA_c(1))/2],'Marker','o','Color',anti_color);
    title(ax3,'Choice');

    % full trial: error increase (%) due to inactivation
    hold(ax4,'on');
    plot(ax4,[0 1],[0 0],'k');
    errorbar(ax4, [0.35],-100*[muP_f],100*[(ciP_f(2)-ciP_f(1))/2],'Marker','o','Color',pro_color);
    errorbar(ax4, [0.65],-100*[muA_f],100*[(ciA_f(2)-ciA_f(1))/2],'Marker','o','Color',anti_color);
    title(ax4,'Full trial');

    % full trial across rats
    hold(ax8,'on');
    plot(ax8,[0 1],[0 0],'k');
    plot(ax8,[0.35 0.65],-100*[Pro_effect Anti_effect],'k-');
    plot(ax8,0.35,-100*Pro_effect,'Marker','o','Color',pro_color);
    plot(ax8,0.65,-100*Anti_effect,'Marker','o','Color',anti_color);
    title(ax8,'Rats');
    
    %%% Post-processing
    ylabel(ax1,'%Error Increase');
    ylabel(ax8,'%Error Increase');
    set([ax1 ax2 ax3 ax4 ax8],'Xlim',[0.2 0.85]);
    set([ax1 ax2 ax3],'Ylim',[-7 11.7]);
    set(ax4,'Ylim',[-12 20]);
    set(ax8,'Ylim',[-15 35]);
    set([ax1 ax2 ax3 ax4 ax8],'XTick',[0.35 0.65]);
    set([ax1 ax2 ax3 ax4 ax8],'XTickLabel',{'' ''},'TickDir','out','TickLength',[0.025 0.01]);
    set([ax1 ax2 ax3 ax4 ax8],'Box','Off');

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

function y=pro_color
    % the color for Pro trials
    y=[13 102 1]/255;

end

function y=anti_color
    % the color for Anti trials
    y=[255 103 0]/255;

end
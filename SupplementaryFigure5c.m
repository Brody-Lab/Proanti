function [ ] = SupplementaryFigure5c( video_PA_auc, video_PA_auc_p)
% ExtendedDataFigure9c Summary of this function goes here
%   This function takes processed video data and related statitics 
%   input and plot it as EDF9c
%   First load video_PA_auc and video_PA_auc_p
%   Then run ExtendedDataFigure9c(video_PA_auc,video_PA_auc_p)

%   video_PA_auc            each row represents 1 session with good video
%                           recordings, each element in a row is the AUC
%                           value that differentiates head-angles between
%                           correct Pro and Anti trials during the task cue
%                           and delay (fixation) periods, calculated using
%                           ExtendedDataFigure9ab.m
%
%   video_PA_auc_p          p value for the AUC values in video_PA_auc,
%                           calculated using ExtendedDataFigure9ab.m
    
%% info and pre-processing
    
    bin_size = 0.005; %each element corresponds to 5 ms of video data
    sound_dur = 1; %task cue lasts for 1s, then 0.5 s of delay
    sound_dur_bin = sound_dur/bin_size;

    %%% only plot sig. diff. (p<0.01) results in this summary plot
    video_PA_auc(video_PA_auc_p>0.01) = 0.5; %set other points to chance 0.5
    new_auc = video_PA_auc(:,2:end-1); %crop the first and last datapoint
    

%% Plotting

    %%% Setup
    h = figure(2020009); clf;
    h.Renderer = 'opengl';
    set(2020009,'PaperPosition',[1 1 5 4]);
    ax =axes('Position',[0.2 0.2 0.6 0.4]);

    im = imagesc(abs(new_auc-0.5)+0.5,[0.5 1]);
    colorbar;
    hold on;
    plot([200 200],[0 size(video_PA_auc,2)],'w-','LineWidth',1);

    %%% Post-processing
    ylabel(ax,'Sessions with good videos');
    xlabel(ax,'Time from delay offset(s)');
    title(ax,'AUC (P<0.01) for head angles on Pro vs Anti trials');
    set(ax,'XTick',[1 100 200 298],'XTickLabel',{'-1.5','-1', '-0.5','0',},'TickDir','out','TickLength',[0.02 0.02]);
    set(ax,'Box','Off');
        
    %saveas...
    %keyboard;
    
end

function [video_PA_auc, video_PA_auc_p]=ExtendedDataFigure9ab_slim(video_processed)
%   This function takes processed video data as input and analyze/plot
%   video data for individual sessions, takes a long time;
%   Load video_processed;
%   Then run ExtendedDataFigure9ab_slim(video_processed);
%   save output video_PA_auc and video_PA_auc_p to plot EDF9c;
%   
%   input video_processed is a tructure that includes video data for all
%   the physiology sessions with good video recordings;
%   for each session,   condition  = trial types (Pro 1 versus Anti 2
%                                    correct trials);
%                       video_data = head angle data for the fixation
%                                    period in each trial, that includes 1s 
%                                    of cue and 0.5s of delay;
%                       time_x     = time to plot video_data (5 ms bin for 1.5s)

%% Setup

    figure(100); %this is to plot individual sessions
    set(100,'PaperPosition',[0.2,0.2,4,4]);

    pro_i_clr=[0 161 235]/255;
    pro_c_clr=[0 126 45]/255;
    anti_i_clr=[141 26 130]/255;
    anti_c_clr=[211 45 20]/255;
    clrs={pro_c_clr anti_c_clr  pro_i_clr anti_i_clr};
    ax_height=0.3;
    corner=[0.15 0.15]; 
    ax_width = 0.3;
        
    video_PA_auc = [];
    video_PA_auc_p = [];
    

%% Filter, analyze and save each session
    for sx=1:numel(video_processed.condition)
    
        x = video_processed.time_x{sx}; %for 1.5s (5ms/bin) that includes 1s cue and 0.5s delay
        y_all=video_processed.video_data{sx}; %head angle values (ipsi/contra) during x_all
        cnd = video_processed.condition{sx}; %1 = Pro; 2 = Anti        
                
        ax_handle = [];
        good_session = true;
        meta_y = [];
        auc = [];
        auc_p = [];
        n_cnd = unique(cnd);

        %%% Try to clean up data and get a sessio-wide mean for each time point
        [i,j]=find(y_all>prctile(y_all(:),97.5)|y_all<prctile(y_all(:),2.5));       
        exclude_idx = zeros(size(y_all,1),1);
        exclude_idx(unique(i))=1; %get rid of the big outlier frames
        new_y_all = y_all(~exclude_idx&(nanstd(y_all')<10)',:); %get rid of the noisy trials before averaging
    
        if size(new_y_all,1)>1
            mean_all = nanmean(new_y_all); %overall mean used for normalization

            for i = 1:numel(x)
                new_y_all(:,i) = new_y_all(:,i) - mean_all(i);
            end;

            clf;

            if isempty(ax_handle),
                ax_handle = axes('Position', [corner(1) corner(2) ax_width ax_height]);
            else
                set(ax_handle, 'Position', [corner(1) corner(2) ax_width ax_height]);
            end;
            axes(ax_handle); hold on;

            %%% Now try to anlayze Pro and Anti seperately
            for ci = 1:numel(n_cnd), %for Pro or Anti condition

                this_cnd = cnd==n_cnd(ci) & ~exclude_idx;
                y = y_all(this_cnd,:);

                good = ~all(isnan(y),2) & (nanstd(y')<10)'; %good trials mean within-trial s.d. < 10degree
                if sum(good)<25; %good session includes >25 correct good Pro & Anti trials
                    good_session = false;
                end
                y = y(good,:);

                for i = 1:numel(x)
                    y(:,i) = y(:,i) - mean_all(i); %mean subtraction normalization
                end;

                meta_y{ci} = y; %this is the data used for doing stats

                if isempty(y),
                    ymn(ci,:) = zeros(size(x));
                    yst(ci,:) = zeros(size(x));
                else
                    ymn(ci,:) = nanmean(y,1);
                    yst(ci,:) = nanstderr(y,1);
                end;
                % plot the averaged trace if you want to see individual session
                shadeplot(x, ymn(ci,:)-yst(ci,:), ymn(ci,:)+yst(ci,:), {clrs{ci},ax_handle,0.7});
                set(gca, 'XLim', [-1.5,0], 'YLim', [-50 50]);

            end;

            hold off;
            xlabel(['Time from End of Delay (sec)']);
            ylabel('degree + se');

            Anti_y = meta_y{2};
            Pro_y = meta_y{1};

            %%% ROC analysis to test headangles diff. between Pro and Anti?
            for boot_i = 1:numel(x)
                [AUC,AUC_p]=bootroc(Anti_y(:,boot_i),Pro_y(:,boot_i),1000);

                auc = [auc AUC];
                auc_p = [auc_p AUC_p];
            end

            h = ax_handle;

        else
            h=[];
            good_session = false;
            auc = [];
            auc_p=[];
        end
            
        if ~isempty(h)
            set(h(end),'YLim',[-10 10],'YTick',[-5 5]);

            ax3 = axes('Position',[0.15 0.6 0.3 0.3]);
            hold on;
            plot(x,new_y_all); %all the trials for that session
            set(ax3,'XLim',[-1.5 0]);

            ax2 = axes('Position',[0.6 0.15 0.3 0.3]);
            histogram(new_y_all); %histogram of all video data points

            if good_session
                video_PA_auc = [video_PA_auc ; auc];
                video_PA_auc_p = [video_PA_auc_p; auc_p];
                title(ax2,'Good Session');
                % save the image for individual good session
                % we used session id = 206090 in EDF9
            else
                title(ax2,'Bad Session');
            end
        else
        end
        
    end
    
    keyboard;
    
end

function [video_PA_auc, video_PA_auc_p]=SupplementaryFigure5ab(CD,SD,varargin)
%   This function takes raw spike and video data as input and analyze/plot
%   video data for individual sessions, takes a long time
%   Load CD_sc and SD_sc_tracking
%   Then run ExtendedDataFigure9ab(CD_sc,SD_sc_tracking)
%   save video_PA_auc and video_PA_auc_p to plot EDF9c

%% Setup

    %%%Setup for plotting
    figure(100); %this is to plot individual sessions
    set(100,'PaperPosition',[0.2,0.2,4,4]);

    pro_i_clr=[0 161 235]/255;
    pro_c_clr=[0 126 45]/255;
    anti_i_clr=[141 26 130]/255;
    anti_c_clr=[211 45 20]/255;

    %%%Setup for analysis
    opts.binsz=0.005;
    opts.wndw=1;
    opts.legend_pos=[];
    opts.font_size=10;
    opts.renderer='opengl';
    opts.clrs={pro_c_clr anti_c_clr  pro_i_clr anti_i_clr};
    opts.ax_width=0.4;
    opts.ha_krn = 1;
    opts.ha_height=0.3;
    opts.ha_y_lim=[-10 10];
    opts.post_mask=+inf;
    opts.errorbars=0;
    opts.ax_width=0.3;
    opts.x_label='End of Delay';
    opts.corner=[0.15 0.15];
    opts.pre=1.5;
    opts.post=0;
    video_PA_auc = [];
    video_PA_auc_p = [];

%% Filter analyze and save each session

    for sx=1:numel(SD.sessid)

        if ~isempty(SD.a{sx})
        these_cells=find(CD.sessid==SD.sessid(sx));
        timestamps = SD.a{sx}.ts;
        timestamps=timestamps(1:end-1);
        theta=SD.a{sx}.theta; %head angle values
        theta=theta(1:end-1);

        pd=SD.pd{sx};
        fields_to_vars(pd);
        peh=SD.peh{sx};

        [pd, peh]=fix_sizes_in_pd(pd,peh);
        fields_to_vars(pd);
        go_signal=extract_event(peh,'cpoke1(end,2)');
        %go_signal is the end of the light, sound ends 500ms before that.
        wfs=extract_event(peh,'wait_for_spoke(end,2)');
        %time of side poke

        %% get raster, mask and split into conditions
        bad_t=(wfs-cout)>10; %RT>10s are bad trials 

        refs1=[go_signal];
        S=zeros(size(refs1,1),1)+nan;

        inc_t= bad_t==0 & hits==1; %only include correct trials

        if ~isempty(these_cells)
                if CD.rr(these_cells(1))==1 % recorded on right
                    ipsi=sides=='r';
                    hv_flip=1;
                else
                    ipsi=sides=='l';
                    hv_flip=-1;
                end

                S(inc_t & pd.side_lights==1)=1; %Pro
                S(inc_t & pd.side_lights==-1)=2; %Anti


            good_t_S=~isnan(S) & ~isnan(refs1);
            nS=S(good_t_S);
            nrefs1_S=refs1(good_t_S);
            opts1=opts;        
            opts1.cnd=nS;

            clf;

            [ax1 all_values,all_x,good_session,auc,auc_p]=rasterHA(nrefs1_S,timestamps,hv_flip*theta,...
                'cnd',opts1.cnd,'ref_label',opts1.x_label,...
                'pre',opts1.pre,'post',opts1.post,'legend_on',0,...
                'ax_height',opts1.ha_height,'ax_width',opts1.ax_width,...
                'clrs',opts1.clrs,'corner',opts1.corner,'krn',opts1.ha_krn,'bin',opts1.binsz);
            
            if ~isempty(ax1)
            set(ax1(end),'YLim',opts1.ha_y_lim,'YTick',[-5 5]);
            title(ax1(end),SD.sessid(sx));

            ax3 = axes('Position',[0.15 0.6 0.3 0.3]);
            hold on;
            plot(all_x,all_values); %all the trials for that session
            set(ax3,'XLim',[-opts1.pre opts.post]);

            ax2 = axes('Position',[0.6 0.15 0.3 0.3]);
            histogram(all_values); %histogram of all video data points
            if good_session
                video_PA_auc = [video_PA_auc ; auc];
                video_PA_auc_p = [video_PA_auc_p; auc_p];
                title(ax2,'Good Session');
                % save the image for individual good session
                % we used session id = 206090 in EDF9
            else
                title(ax2,'Bad Session');
                %save the image for invidiual bad session

            end

            else
            end

        end
        end

    end
    
    keyboard;
    
end

function [h, new_y_all, x_all, good_session,auc,auc_p] = rasterHA(ref, cdtimes, cdvals, varargin)

    good_session = true;
    meta_y = [];
    auc = [];
    auc_p = [];
    corner=[]; % corner is a matlab function in 7.12 so using parseargs breaks.

    pairs = {'pre'			3; ...
         'post'			3; ...
         'bin'			0.10; ...
         'cnd'			1; ...
         'ax_handle'	[]; ...
         'legend_str'	''; ...
         'legend_on'    1; ...
         'renderer'		'opengl'; ...
         'ref_label'	'REF'; ...
         'labels_on'    1; ...
         'ax_height'	1; ...
         'corner'		[0.1 0.1]; ...
         'ax_width'		0.55; ...
         'post_mask'    +inf; ...
         'pre_mask'    -inf; ...
         'krn'          1; ...
         'clrs'         {'b','m','r','c','k','g','y',[1 0.5 0]};...
    }; parseargs(varargin, pairs);


    cdvals=imfilter(cdvals,krn);

    if isscalar(pre_mask)
        pre_mask=zeros(1,numel(ref))+pre_mask;
    elseif numel(pre_mask)~=numel(ref)
        fprintf(1,'numel(pre_mask) must equal num ref events or be scalar');
        return;
    end


    if isscalar(post_mask)
        post_mask=zeros(1,numel(ref))+post_mask;
    elseif numel(post_mask)~=numel(ref)
        fprintf(1,'numel(post_mask) must equal num ref events or be scalar');
        return;
    end

    if isscalar(cnd)
        cnd=ones(size(ref));
    end
    n_cnd = unique(cnd(~isnan(cnd)));

    num_trials = numel(ref);
    [y_all x_all]= cdraster(ref, cdtimes, cdvals, pre, post, bin);
    [y_all x_all] = maskraster(x_all,y_all,pre_mask,post_mask);

    [i,j]=find(y_all>prctile(y_all(:),97.5)|y_all<prctile(y_all(:),2.5));
    exclude_idx = zeros(size(y_all,1),1);
    exclude_idx(unique(i))=1; %get rid of the big outlier frames
    new_y_all = y_all(~exclude_idx&(nanstd(y_all')<10)',:); %get rid of the noisy trials before averaging
    
    if size(new_y_all,1)>1
    mean_all = nanmean(new_y_all); %overall mean used for normalization
    
    for i = 1:numel(x_all)
        new_y_all(:,i) = new_y_all(:,i) - mean_all(i);
    end;
        
    if isempty(ax_handle),
        ax_handle = axes('Position', [corner(1) corner(2) ax_width ax_height]);
    else
        set(ax_handle, 'Position', [corner(1) corner(2) ax_width ax_height]);
    end;
    
    axes(ax_handle); hold on;

    for ci = 1:numel(n_cnd), %for Pro or Anti condition
        
        this_cnd = cnd==n_cnd(ci) & ~exclude_idx;
        [y x] = cdraster(ref(this_cnd), cdtimes, cdvals, pre, post, bin);
        [y x] = maskraster(x,y,pre_mask(this_cnd),post_mask(this_cnd));

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

        % plot the averaged trace (only if you want to see individual
        % sessions)
		shadeplot(x, ymn(ci,:)-yst(ci,:), ymn(ci,:)+yst(ci,:), {clrs{ci},ax_handle,0.7});

        set(gca, 'XLim', [-pre,post], 'YLim', [-50 50]);

    end;

    hold off;

    if labels_on,
        xlabel(['Time from ' ref_label '(sec)']);
        ylabel('degree + se');

    end;

    Anti_y = meta_y{2};
    Pro_y = meta_y{1};
    
    %%% ROC analysis to see if headangles are sig. diff. between Pro and
    %%% anti trials across trials
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
end

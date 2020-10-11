clear
clc

load ../data_files/data_sc

cid=cid_sc;
CD=CD_sc;
SD=SD_sc;

% return
% clearvars -except cid CD SD
% clc



%to include a given neuron, I want to have at least min_num
%trials for each of the 4 conditions (pro-left, pro-right, 
%anti-left, anti-right)
min_num=25;


%%% aligned .8 s later
%%% let's have .2 after side poke => 1s after cout
%%%

%now align to stim out = 

%bin size
bin_size=0.25;
%centers of the time bins
% centers=-1.9:0.025:0.7;

% 0:sidepoke
% -0.8:cout

centers=-2.7:0.025:0.2;


z=1;
for ccx=1:numel(CD.cellid)
    [ccx numel(CD.cellid)]
    
    sx=find(SD.sessid==CD.sessid(ccx));
    
    pd=SD.pd{sx};
    peh=SD.peh{sx};
    [pd, peh]=fix_sizes_in_pd(pd,peh);
    fields_to_vars(pd);
    
    sidepoke = extract_event(peh,'wait_for_spoke(end,2)'); %beginning of task cue    
    cuestart = extract_event(peh,'cpoke1(end,1)'); %beginning of task cue
    
    side_rtime=sidepoke-cuestart;
    %%% if side poke took to long, discard trial
    ind=find(side_rtime>5);
    hits(ind)=0;
    
    
    ctx=pd.side_lights;
    
    
    goL=pd.sides=='l';
    goR=pd.sides=='r';
    
    
    if CD.rr(ccx)==1
        %%% right emisphere
        contra=goL;
        ipsi=goR;
    else
        %%% left emisphere
        contra=goR;
        ipsi=goL;
    end
    
    
    inc_t=hits==1 & cpv==0 & pd.csv==0 & ~isnan(pd.cout) ;
    inc_te=hits==0 & cpv==0 & pd.csv==0 & ~isnan(pd.cout) ;
    
    
    %%%%% CORRECT TRIALS
    
    proc= find(inc_t & ctx==1 & contra); %pro contra
    proi= find(inc_t & ctx==1 & ipsi); %pro ipsi
    
    antic= find(inc_t & ctx==-1 & contra); %anti contra
    antii= find(inc_t & ctx==-1 & ipsi); %anti ipsi
    
    
    
    
    %%%%% ERROR TRIALS - PRO/ANTI
    
    pro_err=(inc_te & ctx==1);
    anti_err=(inc_te & ctx==-1);
    
    
    
    %%%%% ERROR TRIALS - CHOICE
    
    contra_err=find(inc_te & contra);
    ipsi_err=find(inc_te & ipsi);
    
    
    
    
    % if there are less than min_num trials on any condition, skip this neuron
    mi=min([length(proc) length(proi) length(antic) length(antii)]);
    if(mi < min_num)
        continue;
    end
    
    
    %%%%% if there are more than min_num trials, subsample the trials
    ra=randperm(length(proc));
    proc=proc(ra(1:min_num));
    ra=randperm(length(proi));
    proi=proi(ra(1:min_num));
    ra=randperm(length(antic));
    antic=antic(ra(1:min_num));
    ra=randperm(length(antii));
    antii=antii(ra(1:min_num));
    
    
    
    
    
    %%%%%% GET SPIKE DATA
    ts=CD.ts{ccx};
    
    
    ref = sidepoke; %side poke
%     ref=cout; %target onset
    
    qy=nan(numel(hits),length(centers));    
    for tx=1:length(centers)
        qy(:,tx)=qcount(ts,ref+centers(tx)-bin_size/2,ref+centers(tx)+bin_size/2);
    end
  
    
    matsc(z,:,:,1,1)=qy(proc,:)';
    matsc(z,:,:,1,2)=qy(proi,:)';
    matsc(z,:,:,2,1)=qy(antic,:)';
    matsc(z,:,:,2,2)=qy(antii,:)';
    
    

    waves_sc{z}=CD.wave{ccx};

    z=z+1;

    
end

save ../data_files/matsc_sidepoke matsc  ...
    waves_sc centers bin_size
% neuron x time x trial x pro/anti x contra/ipsi




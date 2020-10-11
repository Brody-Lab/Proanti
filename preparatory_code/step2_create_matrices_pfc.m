clear
clc

load ../data_files/data_pfc

cid=cid_pfc;
CD=CD_pfc;
SD=SD_pfc;

% return
% clearvars -except cid CD SD
% clc



%to include a given neuron, I want to have at least min_num
%trials for each of the 4 conditions (pro-left, pro-right, 
%anti-left, anti-right)
min_num=25;

%bin size
bin_size=0.25;
%centers of the time bins
centers=-1.9:0.025:0.7;



z=1;
for ccx=1:numel(CD.cellid)
    [ccx numel(CD.cellid)]
    
    sx=find(SD.sessid==CD.sessid(ccx));
    
    pd=SD.pd{sx};
    peh=SD.peh{sx};
    [pd, peh]=fix_sizes_in_pd(pd,peh);
    fields_to_vars(pd);
    
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
    
    ref=cout; %target onset
    
    qy=nan(numel(hits),length(centers));    
    for tx=1:length(centers)
        qy(:,tx)=qcount(ts,ref+centers(tx)-bin_size/2,ref+centers(tx)+bin_size/2);
    end
  
    
    matpfc(z,:,:,1,1)=qy(proc,:)';
    matpfc(z,:,:,1,2)=qy(proi,:)';
    matpfc(z,:,:,2,1)=qy(antic,:)';
    matpfc(z,:,:,2,2)=qy(antii,:)';
    
    
    for j=1:length(centers)
        matpfc_err_ap{z,j,1}=qy(pro_err,j);
        matpfc_err_ap{z,j,2}=qy(anti_err,j);
    end
    
    
    for j=1:length(centers)
        matpfc_err_choice{z,j,1}=qy(contra_err,j);
        matpfc_err_choice{z,j,2}=qy(ipsi_err,j);
    end

    waves_pfc{z}=CD.wave{ccx};

    z=z+1;

    
end

save ../data_files/matpfc matpfc matpfc_err_ap ...
    matpfc_err_choice waves_pfc centers bin_size
% neuron x time x trial x pro/anti x contra/ipsi




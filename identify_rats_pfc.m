clear
clc

load data_files/data_pfc
load data_files/cellids_pfc


for iii=1:291
    
    ce=cellid(iii);
    
    ind=find([CD_pfc.cellid]==ce);
    
    se=CD_pfc.sessid(ind);
    
    
    ind2=find([SD_pfc.sessid]==se);
    
    
    ra{iii}=SD_pfc.ratname{ind2};
    
    
    
    
end


save data_files/ratti_pfc ra


clear
clc

load data_files/data_sc
load data_files/cellids

for iii=1:193
    
    ce=cellid(iii);
    
    ind=find([CD_sc.cellid]==ce);
    
    se=CD_sc.sessid(ind);
    
    
    ind2=find([SD_sc.sessid]==se);
    
    
    ra{iii}=SD_sc.ratname{ind2};
    
    
    
    
end


save data_files/ratti ra


clear
clc


load ../data_files/cid_sc
CD_sc=get_celldata(cid_sc);
SD_sc=get_sessdata(CD_sc.sessid);
SD_sc_tracking = get_sessdata(CD_sc.sessid,'do_tracking',true);
save ../data_files/data_sc cid_sc CD_sc SD_sc SD_sc_tracking


load ../data_files/cid_pfc
CD_pfc=get_celldata(cid_pfc);
SD_pfc=get_sessdata(CD_pfc.sessid);
save ../data_files/data_pfc cid_pfc CD_pfc SD_pfc



load ../data_files/FOF_cellid
CD_fof=get_celldata(cid_fof);
disp('getting sess data')
SD_fof=get_sessdata(CD_fof.sessid);
disp('saving sess data')
save ../data_files/data_fof cid_fof CD_fof SD_fof



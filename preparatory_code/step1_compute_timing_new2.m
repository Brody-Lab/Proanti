clear
clc

load ../data_files/data_sc

cid=cid_sc;
CD=CD_sc;
SD=SD_sc;




cout_rtime=[];
for ccx=1:length(SD.sessid)
    [ccx length(SD.sessid)]
    pd=SD.pd{ccx};
    peh=SD.peh{ccx};
    [pd, peh]=fix_sizes_in_pd(pd,peh);
    
    fields_to_vars(pd);

    
    ref2 = extract_event(peh,'cpoke1(end,1)'); %beginning of task cue
    
    ref=cout; %cpoke out
    
    
    ind=find(~isnan(ref));
    cout_rtime=[cout_rtime; ref(ind)-ref2(ind)];
    
    
end

cout_rtime=cout_rtime-1.5;

cout_rtime_bounded=cout_rtime(cout_rtime<1 & cout_rtime>=0);
figure;
hist(cout_rtime_bounded,30)
hold on

median_cout_rtime=median(cout_rtime);
plot([median_cout_rtime median_cout_rtime],ylim,'r')
hold on
title(['median=' num2str(median_cout_rtime)])
xlabel('cout reaction time (s)')
ylabel('fraction of trials')
set(gca,'TickDir','out')
box off




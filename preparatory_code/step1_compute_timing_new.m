clear
clc

load ../data_files/data_sc

cid=cid_sc;
CD=CD_sc;
SD=SD_sc;




cout_rtime=[];
sidepoke_rtime=[];
for ccx=1:length(SD.sessid)
    [ccx length(SD.sessid)]
    pd=SD.pd{ccx};
    peh=SD.peh{ccx};
    [pd, peh]=fix_sizes_in_pd(pd,peh);
    
    fields_to_vars(pd);

    
    ref2 = extract_event(peh,'cpoke1(end,1)'); %beginning of task cue
    
    
    
    
    ref3 = extract_event(peh,'wait_for_spoke(end,2)'); %beginning of task cue
    
    
    ref=cout; %cpoke out
    
    
    ind=find(~isnan(ref));
    cout_rtime=[cout_rtime; ref(ind)-ref2(ind)];
    
    
    
    sidepoke_rtime=[sidepoke_rtime; ref3(ind)-ref(ind)];
    
    
end

cout_rtime=cout_rtime-1.5;


sidepoke_rtime=sidepoke_rtime(sidepoke_rtime>=0 & sidepoke_rtime<3.5);
figure;  hist(sidepoke_rtime,30)
hold on
median_sidepoke_rtime=median(sidepoke_rtime);
plot([median_sidepoke_rtime median_sidepoke_rtime],ylim,'r')
hold on
title(['median=' num2str(median_sidepoke_rtime)])
xlabel('sidepoke reaction time (s)')
ylabel('fraction of trials')
set(gca,'TickDir','out')
box off


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




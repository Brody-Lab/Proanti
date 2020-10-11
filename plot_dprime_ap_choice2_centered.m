function [] = plot_dprime_ap_choice2_centered(centers,pop_use,neurtype)




%%% compute d primes
[dp_ap,~,dp_choice,~] = compute_dprimes_correct(pop_use);
[~,indmax]=max(abs(dp_ap),[],2);
[~,indsort]=sort(indmax);

%%% rank neurons
dp_ap=dp_ap(indsort,:);
dp_choice=dp_choice(indsort,:);

%%% plot
figure %%% pro vs anti
plot_dprime_results2_centered(centers,dp_ap,-1,1)
title([neurtype ' - pro/anti'])
a=[linspace(1,0,32) linspace(0,0,32)]' ;
b=[linspace(0,0,32) linspace(0,1,32)]' ;
c=[linspace(0,0,32) linspace(0,0,32)]' ;
co=[a b c];
colormap(co)
colorbar




figure %%% choice
plot_dprime_results2_centered(centers,dp_choice,-1,1)
title([neurtype ' - choice'])


a=[linspace(1,0,32) linspace(0,40/255,32)]' ;
b=[linspace(125/255,0,32) linspace(0,110/255,32)]' ;
c=[linspace(36/255,0,32) linspace(0,1,32)]' ;







co=[a b c];
colormap(co)
colorbar



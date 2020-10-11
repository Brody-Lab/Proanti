function [w,k] = svm_train(trainm,traind,cost)

trainm=trainm(:,:)';
traind=traind(:,:)';

data=[trainm ; traind];
groups=[ones(size(trainm,1),1); 2*ones(size(traind,1),1)];

model = svmtrain_new(groups,data,['-c ' num2str(cost) ' -t 0 -s 0 -q']);

w = model.SVs' * model.sv_coef; %http://www.csie.ntu.edu.tw/~cjlin/libsvm/faq.html#f804
k = -model.rho;

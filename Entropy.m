function ep=Entropy(labels)
%num=length(labels);
list=tabulate(labels);
distr=list(:,3);
di=distr(find(distr~=0))/100;
ep=-di'*log2(di);
end
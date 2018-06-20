function [n,ml]=mostlabel(X)
global label_num;
labels=cell2mat(X(:,end));
count=zeros(label_num,1);
num=size(labels,1);
for i=1:num
    label=labels(i);
    count(label)=count(label)+1;
end
[n,ml]=max(count);
end
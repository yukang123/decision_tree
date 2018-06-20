function [attri_rank,thresh]=choose_best(X,index)
% find the best attribute
global attr_info;
num=length(index);
labels_all=cell2mat(X(:,end));
gain_list=zeros(num,1);
thres_list=cell(num,1);
for i=1:num
    pos=index(i);
    if  attr_info(pos)==1  %continuous
        list_1=cell2mat(X(:,pos));
        [gain_list(i),thres_list{i}]=calc_gain(list_1,labels_all);
    else
        list_1=X(:,pos);
        gain_list(i)=cald_gain(list_1,labels_all);
        thres_list{i}='no';
    end
end
[~,rank]=max(gain_list);
attri_rank=index(rank);
thresh=thres_list{rank};
end
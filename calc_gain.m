function [gain,threshold]=calc_gain(list,labels)
D_all=Entropy(labels); %Ent(D)
num_all=length(list);
new_list=sort(unique(list));
num_uni=length(new_list);
if num_uni==1
    sum_1=D_all;
    threshold=new_list;
else
    gain_list=zeros(num_uni-1,1);
    for i=1:num_uni-1
        t=(new_list(i)+new_list(i+1))/2;
        ld_ind=find(list<=t);
        Dd_ind=Entropy(labels(ld_ind));
        lu_ind=find(list>t);
        Du_ind=Entropy(labels(lu_ind));
        gain_list(i)=length(ld_ind)*Dd_ind+length(lu_ind)*Du_ind;
        gain_list(i)=gain_list(i)/num_all;
    end
    [sum_1,index]=min(gain_list);
    threshold=(new_list(index)+new_list(index+1))/2;
end
gain=D_all-sum_1;
end
function gain=cald_gain(list,labels)
D_all=Entropy(labels); %Ent(D)
new_list=unique(list);
num_all=length(list);
pos_list=count_num(list,new_list);
num_attr=length(new_list);  %how many values
sum_1=0;
for i=1:num_attr
    label_i=labels(pos_list{i});
    sum_1=sum_1+Entropy(label_i)*length(label_i)/num_all;
end
gain=D_all-sum_1;
end

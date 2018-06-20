function pos_list=count_num(list,new_list)
num_all=length(list);
num_attr=length(new_list);
pos_list=cell(num_attr,1);
for i=1:num_all
    attr_i=list{i};
    for j=1:num_attr
        if strcmp(attr_i,new_list{j})
            break
        end
    end
    pos_list{j}(end+1)=i;
end
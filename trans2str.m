function out_list=trans2str(c_list)
out_list=cell(size(c_list));
for i=1:length(c_list)
    out_list{i}=num2str(c_list{i});
end
end
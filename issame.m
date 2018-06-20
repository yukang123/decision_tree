function state=issame(X,index)
global attr_info;
state=1;   %same assumption
for i=1:length(index)
    pos=index(i);
    if  attr_info(pos)==1
        list_all=cell2mat(X(:,pos));
    else
        list_all=X(:,pos);
    end
    if length(unique(list_all))~=1
        state=0;    %not same
        break
    end
end
end
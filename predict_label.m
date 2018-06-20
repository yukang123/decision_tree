function result=predict_label(x,initial_node)
global attr_info;
node=initial_node;
while (~isempty(node.snode))
    snodes=node.snode;
    node_num=length(snodes);
    atr_rank=snodes{1}.attribute;
    threshold=snodes{1}.threshold;
    x_atr=x{atr_rank};
    if attr_info(atr_rank)==0
        for i=1:node_num
            if strcmp(x_atr,snodes{i}.value)
                break
            end
        end  
        node=node.snode{i};
    else
        if  x_atr<=threshold
            for i=1:node_num
                if  strcmp('LOW',snodes{i}.value)
                    break
                end
            end
            node=node.snode{i};
        else
            for i=1:node_num
                if strcmp('HIGH',snodes{i}.value)
                    break
                end
            end
            node=node.snode{i};
        end       
    end
end
result=node.label;
end
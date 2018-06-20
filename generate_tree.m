function [node]=generate_tree(X,attr_list)
global attr_whole;
node=struct('label','null','attribute','null','threshold','null','value','null','snode',[]);
node.snode={};
[num_1,ml]=mostlabel(X);
if num_1==size(X,1)
    node.label=ml;
    return
end
index=find(attr_list==1);
if (sum(attr_list)==0)||(issame(X,index)==1)
    node.label=ml;
    return
end
%%
[attri_rank,thresh]=choose_best(X,index);
%%
if thresh=='no'    % discrete
    att_sit=attr_whole(attri_rank);
    att_sit=att_sit{:};
    sel_num=length(att_sit);
    att_list=X(:,attri_rank);
    cal_list=count_num(att_list, att_sit);  % split dataset
    for i=1:sel_num
        index_i=cal_list{i};
        son_node=struct('label','null','attribute','null','threshold','null','value','null','snode',[]);
        son_node.snode={};
        if isempty(index_i)     
            fprintf('a');
            %pause;
            son_node.label=ml; 
            son_node.attribute=attri_rank;
            son_node.threshold=thresh;
            son_node.value=att_sit{i};
            node.snode{i}=son_node;
            continue;
            %return;
        else
            inter_list=attr_list(:);
            inter_list(attri_rank)=0;
            inter_X=X(index_i,:);
            son_node=generate_tree(inter_X,inter_list);
            son_node.attribute=attri_rank;
            son_node.threshold=thresh;
            son_node.value=att_sit{i};
            node.snode{i}=son_node;
        end
    end
else
    att_list=cell2mat(X(:,attri_rank));
    index_up=find(att_list>thresh);
    index_down=find(att_list<=thresh);
    index_all={index_up,index_down};
    value_all={'HIGH','LOW'};
    for i=1:2
        index_i=index_all{i};
        son_node=struct('label','null','attribute','null','thershold','null','value','null','snode',[]);
        son_node.snode={};
        if isempty(index_i)  
            %fprintf('b');
            %pause;
            son_node.label=ml; 
            son_node.attribute=attri_rank;
            son_node.threshold=thresh;
            son_node.value=value_all{i};
            node.snode{i}=son_node;
            continue;
        else
            inter_list=attr_list(:);
            inter_X=X(index_i,:);
            son_node=generate_tree(inter_X,inter_list);
            son_node.attribute=attri_rank;
            son_node.threshold=thresh;
            son_node.value=value_all{i};
            node.snode{i}=son_node;
        end
    end    
end
    
end
%% read text and load data
clear
filename='watermelon.txt';
[X,label]=load_melon_data(filename);
%X=X(:,[5,2:4,1,6,end]);
sample_num=size(X,1);
attr_num=size(X,2)-1;
global label_num;
global attr_info;
global attr_whole;
global attr_inda;
label_num=2;
attr_whole=cell(attr_num,1);    % attribute list
% attr_info=ones(size(X,2)-1,1);  % is  continuous or discrete =1 continuous =0 discrete
% attr_inda=ones(size(X,2)-1,1);  % is  string or number =0 string =1 number
 attr_inda=[zeros(6,1);1;1]; 
 attr_info=[zeros(6,1);1;1];
% attr_inda=zeros(6,1); 
% attr_info=zeros(6,1);
for i=1:attr_num
    if attr_inda(i)==0
        attr_whole{i}=unique(X(:,i));
    else
        if attr_info(i)==0
            X(:,i)=trans2str(X(:,i));
            attr_whole{i}=unique(X(:,i));
        end
    end
end
%% generate tree
attr_list=ones(attr_num,1);
initial_node=generate_tree(X,attr_list);
%% predict on the whole dataset
result=zeros(sample_num,1);
for i=1:sample_num
    result(i)=predict_label(X(i,:),initial_node);
end
accuracy=sum(result==label)/sample_num;
%% compare validation
% index_1=[1,2,3,6,7,10,14,15,16,17];
% index_2=[4,5,8,9,11,12,13];
% X_train=X(index_1,:);
% X_test=X(index_2,:);
% label_train=label(index_1,:);
% label_test=label(index_2,:);
% initial_node_train=generate_tree(X_train,attr_list);
% result_test=zeros(length(label_test),1);
% for i=1:length(label_test)
%     result_test(i)=predict_label(X_test(i,:),initial_node_train);
% end
% accuracy_valid=sum(result_test==label_test)/length(label_test);
%% split into training dataset and test dataset
accuracy_test=zeros(10,1);
accuracy_train=zeros(10,1);
for j=1:10
rank=randperm(sample_num);
X_train=X(rank(1:10),:);
label_train=label(rank(1:10),:);
X_test=X(rank(11:end),:);
label_test=label(rank(11:end),:);
attr_list=ones(attr_num,1);
initial_node_train=generate_tree(X_train,attr_list);
result_test=zeros(length(label_test),1);
for i=1:length(label_test)
    result_test(i)=predict_label(X_test(i,:),initial_node_train);
end
accuracy_test(j)=sum(result_test==label_test)/length(label_test);
result_train=zeros(length(label_train),1);
for i=1:length(label_train)
    result_train(i)=predict_label(X_train(i,:),initial_node_train);
end
accuracy_train(j)=sum(result_train==label_train)/length(label_train);
end
figure(1);
plot(accuracy_test*100,'b-');ylim([0,100]);title('accuracy of test dataset(10 times split)');
xlabel('iteration times');ylabel('accuracy/%');
%% read text and load data
clear
filename='Iris_dataset.txt';
[X,label]=load_data(filename);
sample_num=size(X,1);
attr_num=size(X,2)-1;
% label=cell2mat(X(:,end));
global label_num;
global attr_info;
global attr_whole;
global attr_inda;
label_num=3;
attr_whole=cell(attr_num,1);    % attribute list
attr_info=ones(size(X,2)-1,1);  % is  continuous or discrete =1 continuous =0 discrete
attr_inda=ones(size(X,2)-1,1);  % is  string or number =0 string =1 number
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
%%  10-fold cross validation
Fold=10; 
index = crossvalind('Kfold', sample_num, Fold);
accuracy_test=zeros(Fold,1);
accuracy_train=zeros(Fold,1);
for i=1:Fold
    X_train=X(index~=i,:);
    X_test=X(index==i,:);
    label_train=label(index~=i,:);
    label_test=label(index==i,:);
    attr_list=ones(attr_num,1);
    initial_node_train=generate_tree(X_train,attr_list);
    accuracy_test(i)=validation(X_test,label_test, initial_node_train);
    accuracy_train(i)=validation(X_train,label_train, initial_node_train);
end
figure(1);
plot(accuracy_test*100,'b-');ylim([0,100]);title('accuracy of test dataset(10-fold validation)');
xlabel('iteration times');ylabel('accuracy/%');
figure(2);
plot(accuracy_train*100,'b-');ylim([0,100]);title('accuracy of train dataset(10-fold validation)');
xlabel('iteration times');ylabel('accuracy/%');
accuracy_av_test=mean(accuracy_test);
accuracy_av_train=mean(accuracy_train);
%% 70% 30% split into training dataset and test dataset
rank=randperm(sample_num);
X_train=X(rank(1:floor(0.7*sample_num)),:);
X_test=X(rank(floor(0.7*sample_num)+1:end),:);
label_train=label(rank(1:floor(0.7*sample_num)),:);
label_test=label(rank(floor(0.7*sample_num)+1:end),:);
attr_list=ones(attr_num,1);
initial_node_train=generate_tree(X_train,attr_list);
result_test=zeros(length(label_test),1);
for i=1:length(label_test)
    result_test(i)=predict_label(X_test(i,:),initial_node_train);
end
accuracy_test=sum(result_test==label_test)/length(label_test);
function accuracy=validation(X,label, initial_node)
% predict and calculate accuracy
num=length(label);
result=zeros(num,1);
for j=1:num
    result(j)=predict_label(X(j,:),initial_node);
end
accuracy=sum(result==label)/num;
end
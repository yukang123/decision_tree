function [X,label]=load_data(filename)
fidin=fopen(filename);
%C=textscan(fidin,'%3.1f%3.1f%3.1f%3.1f%s','delimiter',',');
C=textscan(fidin,'%f%f%f%f%s','delimiter',',');
num=C{end};
N=length(num);
label=zeros(N,1);
for i=1:N
    switch num{i}
        case 'Iris-virginica'
            label(i)=3;
        case 'Iris-setosa'
            label(i)=1;
        case 'Iris-versicolor'
            label(i)=2;        
    end    
end
X=cell(N,5);
for i=1:4
    X(:,i)=num2cell(C{i});
end    
X(:,end)=num2cell(label);
end

function [X,label]=load_melon_data(filename)
fidin=fopen(filename);
%C=textscan(fidin,'%3.1f%3.1f%3.1f%3.1f%s','delimiter',',');
C=textscan(fidin,'%d%s%s%s%s%s%s%f%f%s','delimiter',',');
num=C{end};
N=length(num);
label=zeros(N,1);
for i=1:N
    switch num{i}
        case 'ÊÇ  '
            label(i)=1;
        case '·ñ  '
            label(i)=2;    
    end    
end
X=cell(N,9);
for i=1:6
    abs=C(i+1);
    X(:,i)=abs{:};
end    
for i=7:8
    X(:,i)=num2cell(C{i+1});
end    
X(:,end)=num2cell(label);
end

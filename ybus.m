clc;
clear all;
close all;
cd('D:\6th Semester\Power System\Sessional Rashu Sir\Lab02')
a=xlsread('ybus')
[row,coloumn]=size(a);
resistance=a(:,3);
reactance=a(:,4);
img=reactance.*i;
Y=(1./img);
Y_add=zeros(4);
%for nondiagonal elements
for i=1:row
    for j=1:4
        if a (i,1)==0||a(i,2)==0
            a=0;
        elseif a(i,1)~=0 ||a(i,2)~=0
            Y_add(a(i,1),a(i,2))=-1/a(i,4);
            Y_add(a(i,2),a(i,1))=-1/a(i,4);
        end
    end
end
%for diagonal elements
for p=1:4
    for q=1:row
        if a(q,1)==p || a(q,2)==p
            Y_add(p,p)=(Y_add(p,p)+(1/a(q,4)));
        end
    end
end
YbusY=Y_add
     
            
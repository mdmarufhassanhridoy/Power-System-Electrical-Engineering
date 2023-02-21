clc             % clear the command window and homes the cursor
clear all       % remove items from MATLAB workspace and reset MuPAD engine
cd('D:\6th Semester\Power System\Sessional Rashu Sir\Lab05'); % changes the directory
A=xlsread('file');  % Reads value from excel file
B=A(:,1);
n=length(B);    % length of A is calculated
for j=1:n
    Z(A(j,1),A(j,2))=A(j,3)+A(j,4)*i; % Generates the impedance matrix
    Z(A(j,2),A(j,1))=A(j,3)+A(j,4)*i; % makes the matrix symmetric
end
Z;
m=length(Z);
for j=1:m
    for k=1:m
        if Z(j,k)==0;
            Z(j,k)=inf; % makes all the value inf where finds zero
        end
    end
end
Z
Y=ones(m)./Z;  % find the admittance
 
 
p=sum(Y,2); % summing the element in a row
for i=1:m
    for j=1:m
        if i~=j
            Y(i,j)=-Y(i,j);
        else
            Y(i,j)=p(i);
        end
    end
end
Y % finally Ybus matrix is found
 
cd('D:\6th Semester\Power System\Sessional Rashu Sir\Lab05');
data=xlsread('file2'); %to read the input file
j=3;
V=data(:,2);
V0=data(:,2);
P=data(:,3)-data(:,5); %to get the value of real power 
Q=data(:,4)-data(:,6); %to get the value of reactive power
ang=data(:,7); %to get the angle
V1=V;
Pg=data(:,3);%to get the value of generator bus
for w=1:100    
    z=V;
    for k=2:j
        yv1=0;
        yv2=0;
        for h=1:j
            yv2=yv2+Y(k,h)*V(h); %to find the product of Y bus and voltages
            if h~=k
                yv1=yv1+Y(k,h)*V(h); %to find the product of Y bus and voltages
            end
        end
        if Pg(k)~=0
            g(k)=imag(V(k)*(conj(yv2))); %to get the imaginary value
            S(k)=P(k)+1i*g(k); %to calculate the apparent power
        else S(k)=P(k)+1i*Q(k);
        end
        V(k)=(1/Y(k,k))*((conj(S(k))/conj(V(k)))-yv1); %to get the value of node voltages
        ang1(k)=angle(V(k));    %to get the angles
        ang2(k)=rad2deg(ang1(k)); %to convert the radian values to degrees
        if Pg(k)~=0
            V(k)=V0(k)*exp(1i*ang1(k)); 
        end
    end
        V1=abs(V);
         ang2=rad2deg(ang1);
    E=abs((V-z)/V);       
    if E<=10e-4
        break;   %to break the for loop
    end
    VLT1(w)=V1(1);
    VLT2(w)=V1(2); 
    VLT3(w)=V1(3); 
    ANGL1(w)=ang2(1); 
    ANGL2(w)=ang2(2); 
    ANGL3(w)=ang2(3);
end
VLT1=VLT1';   
ANGL1=ANGL1'; 
VLT2=VLT2';  % To show the value coloumn wise
ANGL2=ANGL2'; 
VLT3=VLT3'; 
ANGL3=ANGL3';
ITER=(1:w-1)';
table(ITER,VLT1,ANGL1,VLT2,ANGL2,VLT3,ANGL3) %to show the values in a table


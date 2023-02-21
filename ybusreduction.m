clc             
clear all      
cd('D:\6th Semester\Power System\Sessional Rashu Sir\Lab03');
z = xlsread('ybusreduction.xlsx');
n = length(z);
for j = 1:n
    Z(z(j,1),z(j,2)) = z(j,3)+z(j,4)*i; 
    Z(z(j,2),z(j,1)) = z(j,3)+z(j,4)*i; 
end
disp('Y bus impedance matrix is:');
disp(Z);
m = length(Z);
for j = 1:m
    for k = 1:m
        if Z(j,k) == 0;
            Z(j,k) = inf; 
        end
    end
end
Z;
Y = 1./Z;
p = sum(Y,2);
for i = 1:m
    for j = 1:m
        if i ~= j
            Y(i,j) = -Y(i,j);
        else
            Y(i,j) = p(i);
        end
    end
end
disp('Y bus admittance matrix is:');
disp(Y);
Lbus = input('Number of Load Buses: ');
for k = 1:Lbus
    Rbus = zeros(m-1); 
    for i = 1:m-1
        for j = 1:m-1
          Rbus(i,j) = Y(i,j)-((Y(i,m)*Y(m,j))/Y(m,m));
        end
    end
    Y = Rbus;  
    m = m-1; 
end
disp('Reduced Y bus admittance matrix is:');
disp(Y);


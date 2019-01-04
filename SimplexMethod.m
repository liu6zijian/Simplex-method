%根据运筹学老师教的单纯形算法，自己编的的程序
%clc,clear all
function danchunxing(A,B,C)
%
% A为方程组中变量的系数
% B为方程组右端项的值(列向量)
% C为目标函数中变量的系数(行向量)
%
% A=[0 5;6 2;1 1];B=[15 24 5]';C=[2 1];%该行可作为测试用例
[m,~]=size(A);%计算A的行数
A=[A eye(m)];%加入松弛变量
[~,n]=size(A);l=m;%构造含有松弛变量的系数
b=B;%常数项
Cb=zeros(m,1);%价值系数
Cj=[C Cb'];%
flag=1;%循环标志
while(flag)   
for i=1:n
    delta(i)=Cj(i)-sum(Cb.*A(:,i));
end
if all(delta<=0)
    fprintf('有最优解\n');
    flag=0;
    for i=1:n-m
        % if all(Cb==0)
        x(i)=b(find(Cb==Cj(i)));
    end
    x,fval=sum(x.*C)%计算最优值
else       
    [~,max_seat]=max(delta);%确定出基变量
    theta=b./A(:,max_seat);   
    for i=1:m %theta不取负值
        if theta(i)<0
            theta(i)=max(theta)+1;
        end
        [~,min_seat]=min(theta);%确定入基变量
        Cb(min_seat)=Cj(max_seat);
        Aa=A(min_seat,:)/A(min_seat,max_seat);
        b(min_seat)=b(min_seat)/A(min_seat,max_seat);
        A(min_seat,:)=Aa;
        for i=1:m
            AA(i,:)=A(i,:)-A(i,max_seat)*A(min_seat,:)*(i~=min_seat);
            b(i)=b(i)-A(i,max_seat)*b(min_seat)*(i~=min_seat);
        end
        A=AA;
    end
end
end
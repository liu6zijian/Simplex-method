%�����˳�ѧ��ʦ�̵ĵ������㷨���Լ���ĵĳ���
%clc,clear all
function danchunxing(A,B,C)
%
% AΪ�������б�����ϵ��
% BΪ�������Ҷ����ֵ(������)
% CΪĿ�꺯���б�����ϵ��(������)
%
% A=[0 5;6 2;1 1];B=[15 24 5]';C=[2 1];%���п���Ϊ��������
[m,~]=size(A);%����A������
A=[A eye(m)];%�����ɳڱ���
[~,n]=size(A);l=m;%���캬���ɳڱ�����ϵ��
b=B;%������
Cb=zeros(m,1);%��ֵϵ��
Cj=[C Cb'];%
flag=1;%ѭ����־
while(flag)   
for i=1:n
    delta(i)=Cj(i)-sum(Cb.*A(:,i));
end
if all(delta<=0)
    fprintf('�����Ž�\n');
    flag=0;
    for i=1:n-m
        % if all(Cb==0)
        x(i)=b(find(Cb==Cj(i)));
    end
    x,fval=sum(x.*C)%��������ֵ
else       
    [~,max_seat]=max(delta);%ȷ����������
    theta=b./A(:,max_seat);   
    for i=1:m %theta��ȡ��ֵ
        if theta(i)<0
            theta(i)=max(theta)+1;
        end
        [~,min_seat]=min(theta);%ȷ���������
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
function [Z] = init_Z3(X,lbd)
  
V = size(X, 1);%����ͼ��

n = size(X{1}, 2);%X�е�һ����Ԫ���������

D = lbd*ones(n,n);
%%
D = D + diag(ones(n,1));%diag(ones(n,1))���ɶԽ���Ϊ1��n*n�ĶԽǾ��󣨶Ⱦ���
for i=1:V
  D = D + X{i}'*X{i};%���򻯣�
end
D = inv(D);% D�������
% 
 Z = -D./diag(D)';%D��ÿһ�е�Ԫ�طֱ�������ĶԽ�Ԫ�أ�����һ��Ԫ�س��Ե�һ���Խ�Ԫ��
 Z = Z - diag(diag(Z));%Z�Ǿ���diag(Z)��ȡ���ǶԽ����ϵ�Ԫ�أ�diag(diag(Z))�ѶԽ�Ԫ����ɶԽǾ���
                       %Z - diag(diag(Z))��һ���Խ���Ԫ��Ϊ0�ľ���
% % Z = Z./sum(Z,1);
% 
 Z = (Z+Z')/2;%�Խ���Ϊ0�ĶԳƾ���
end

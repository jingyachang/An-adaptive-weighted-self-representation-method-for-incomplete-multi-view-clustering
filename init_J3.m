function [J] = init_J3(X)
  
V = size(X, 1);%����ͼ��

n = size(X{1}, 2);%X�е�һ����Ԫ���������

J = ones(n, n);
%%
% D = D + lbd*diag(ones(n,1));%diag(ones(n,1))���ɶԽ���Ϊ1��n*n�ĶԽǾ��󣨶Ⱦ���
% for i=1:V
%   D = D + X{i}'*X{i};%���򻯣�
% end
% D = inv(D);% D�������
% 
% Z = -D./diag(D)';%��D�������λ��
% Z = Z - diag(diag(Z));%Z�Ǿ���diag(Z)��ȡ���ǶԽ����ϵ�Ԫ�أ�diag(diag(Z))�ѶԽ�Ԫ����ɶԽǾ���
%                       %Z - diag(diag(Z))��һ���Խ���Ԫ��Ϊ0�ľ���
% % Z = Z./sum(Z,1);
% 
% Z = (Z+Z')/2;%�Խ���Ϊ0�ĶԳƾ���
end
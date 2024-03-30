function [J] = init_J3(X)
  
V = size(X, 1);%多视图数

n = size(X{1}, 2);%X中第一个单元数组的列数

J = ones(n, n);
%%
% D = D + lbd*diag(ones(n,1));%diag(ones(n,1))生成对角线为1的n*n的对角矩阵（度矩阵）
% for i=1:V
%   D = D + X{i}'*X{i};%正则化，
% end
% D = inv(D);% D的逆矩阵
% 
% Z = -D./diag(D)';%对D的逆矩阵单位化
% Z = Z - diag(diag(Z));%Z是矩阵diag(Z)提取得是对角线上的元素，diag(diag(Z))把对角元素组成对角矩阵
%                       %Z - diag(diag(Z))是一个对角线元素为0的矩阵
% % Z = Z./sum(Z,1);
% 
% Z = (Z+Z')/2;%对角线为0的对称矩阵
end
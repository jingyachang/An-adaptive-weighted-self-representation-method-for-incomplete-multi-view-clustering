function [obj, term1, term2, term31, term41] = cal_obj3(X, Z, J,W, lbd,gamma,alpha)

V = size(X, 1);%多视图数

% global alpha;
% global gamma;
% %gamma =1000;
%模型第1部分的值F范数的平方
term1 = 0;
for i=1:V
    tmp = X{i}*W{i}'-X{i}*Z*W{i}';
    term1 = term1 + sum(sum(tmp.^2));
end
%模型第2部分的值F范数的平方
term2 = sum(sum(Z.^2));
%模型第4部分的值F范数的平方
tmp3 = J-Z;
term31 = sum(sum(tmp3.^2));
%模型第3部分的值核范数
tmp4 = svd(Z);
term41 = sum(tmp4);
%目标函数
obj = term1 + (lbd/2)*term2 + (alpha/2)*term31 + gamma*term41;

end

function[objz]=objz3(Z,J,lbd,gamma,alpha)
%模型第2部分的值F范数的平方
term2 = sum(sum(Z.^2));
%模型第4部分的值F范数的平方
tmp3 = J-Z;
term31 = sum(sum(tmp3.^2));
%模型第3部分的值核范数
tmp4 = svd(Z);
term41 = sum(tmp4);
objz=(lbd/2)*term2 + (alpha/2)*term31 + gamma*term41;
end
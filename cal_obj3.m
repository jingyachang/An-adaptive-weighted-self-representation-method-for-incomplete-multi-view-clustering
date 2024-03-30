function [obj, term1, term2, term31, term41] = cal_obj3(X, Z, J,W, lbd,gamma,alpha)

V = size(X, 1);%����ͼ��

% global alpha;
% global gamma;
% %gamma =1000;
%ģ�͵�1���ֵ�ֵF������ƽ��
term1 = 0;
for i=1:V
    tmp = X{i}*W{i}'-X{i}*Z*W{i}';
    term1 = term1 + sum(sum(tmp.^2));
end
%ģ�͵�2���ֵ�ֵF������ƽ��
term2 = sum(sum(Z.^2));
%ģ�͵�4���ֵ�ֵF������ƽ��
tmp3 = J-Z;
term31 = sum(sum(tmp3.^2));
%ģ�͵�3���ֵ�ֵ�˷���
tmp4 = svd(Z);
term41 = sum(tmp4);
%Ŀ�꺯��
obj = term1 + (lbd/2)*term2 + (alpha/2)*term31 + gamma*term41;

end

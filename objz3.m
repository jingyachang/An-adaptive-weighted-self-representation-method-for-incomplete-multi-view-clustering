function[objz]=objz3(Z,J,lbd,gamma,alpha)
%ģ�͵�2���ֵ�ֵF������ƽ��
term2 = sum(sum(Z.^2));
%ģ�͵�4���ֵ�ֵF������ƽ��
tmp3 = J-Z;
term31 = sum(sum(tmp3.^2));
%ģ�͵�3���ֵ�ֵ�˷���
tmp4 = svd(Z);
term41 = sum(tmp4);
objz=(lbd/2)*term2 + (alpha/2)*term31 + gamma*term41;
end
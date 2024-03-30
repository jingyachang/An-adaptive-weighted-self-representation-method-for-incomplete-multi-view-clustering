function [U] = baseline_spectral_onkernel3(K,numClust)

D = diag(sum(K,1)+eps);%�Ծ���k����ÿһ����� %�ڶ���
inv_sqrt_D = sqrt(inv(abs(D)));%��D^(-1/2)
L = inv_sqrt_D*K*inv_sqrt_D;%���öԳƱ�׼����L=D^(-1/2)*��D-W��*D^(-1/2) %������
%L = inv(D) * K;
L = (L+L')/2;
%sum(sum(L-L'));
% now do an eigen-decomposition of L
%fprintf('doing eigenvalue decomp...\n');
opts.disp = 0;
[U,V] = eigs(L,numClust,'LA',opts );% numClust���������ֵ��Ŀ ;'lr' ����ʵ����ֵ���֣�opts ʹ�ýṹ��ָ��ѡ��;
                                   %����������˹�����ǰnumclust����xiao��da������ֵ��Ӧ����������
                                   %���Ĳ��͵��岽
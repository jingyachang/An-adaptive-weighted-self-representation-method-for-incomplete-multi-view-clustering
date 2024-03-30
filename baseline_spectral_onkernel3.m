function [U] = baseline_spectral_onkernel3(K,numClust)

D = diag(sum(K,1)+eps);%对矩阵k进行每一列求和 %第二步
inv_sqrt_D = sqrt(inv(abs(D)));%求D^(-1/2)
L = inv_sqrt_D*K*inv_sqrt_D;%采用对称标准化求L=D^(-1/2)*（D-W）*D^(-1/2) %第三步
%L = inv(D) * K;
L = (L+L')/2;
%sum(sum(L-L'));
% now do an eigen-decomposition of L
%fprintf('doing eigenvalue decomp...\n');
opts.disp = 0;
[U,V] = eigs(L,numClust,'LA',opts );% numClust计算的特征值数目 ;'lr' 最大的实特征值部分；opts 使用结构体指定选项;
                                   %计算拉普拉斯矩阵的前numclust个从xiao到da的特征值对应的特征向量
                                   %第四步和第五步
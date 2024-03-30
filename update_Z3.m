 function [Z] = update_Z3(X,Z,J,lbd,gamma,alpha)
n = size(X{1}, 2);%400维
tao= gamma/(alpha+lbd);
% tao=0.05;
sigma = 18;%
itermax=250;
y1= zeros(n,1);%列向量
Y1= diag(y1);
for ii = 1:itermax
    % singular value threshold operation
    P=(alpha/(lbd+alpha))*((1/alpha)*Y1+J);%进行特征值分解的部分
    [U, S, V] = svd(P, 'econ'); %这一步求得特征值
   S = sign(S).* max(abs(S) - tao, 0);%abs(S)
    Z = U*S*V';
%     objz=objz3(Z,J,lbd,gamma,alpha)
    y1=y1-sigma*(diag(Z));
    Y1= diag(y1);%对角元素全是y的元素，非对角为零
    % computer error
    error= norm(-diag(Z),2);%/norm(diag(Z),'fro' );约束条件的范数之差除以右侧的范数
    if error<0.005
        break;
    end
%     y1=y1-sigma*(diag(Z));
%     Y1= diag(y1);%对角元素全是y的元素，非对角为零
end



% function [Z] = update_Z3(X,Z,J,lbd,gamma,alpha)
% Single value thresholding algorithm，SVT
% function：求解如下模型
%                  min  ||U||*
%               s.t. P(U-M) = 0
% 其中，U是恢复后得到的低秩矩阵；M是观测矩阵
% input：观测矩阵M,观测元素位置矩阵P,参数gamma(奇异值缩紧步长),sigma
% output：输出恢复后的矩阵Z,迭代次数iterations
% n = size(X{1}, 2);%列
% M= Z-diag(diag(Z));%对角元素为零的矩阵
% epsilon= 1e3;%迭代终止阈值
% 
% iterations = 0;%迭代次数
% global gamma
% global alpha
% tao= gamma/(alpha+lbd);
% sigma = 1.76;%步长1~2%1.78
% itermax=15;
% k0= 655;%655
% Y1= k0*sigma*M;% 辅助矩阵Y初始化
% Y1= k0*sigma*M;% 辅助矩阵Y初始化
% if nargin < 3
%     T =  sqrt(n1*n2);
% end
% if nargin < 4
%     delta = 1;
% end
% if nargin < 5
%     itermax = 200 ;
% end
% if nargin < 6
%     tol = 1e-7;
% end
% 
% 
% 
% 
% % epsilon= 1e3;%迭代终止阈值
% 
% %Single value thresholding algorithm，SVT
% % function：求解如下模型
% %                  min  ||U||*
% %               s.t. P(U-M) = 0
% % 其中，U是恢复后得到的低秩矩阵；M是观测矩阵
% % input：观测矩阵M,观测元素位置矩阵P,参数gamma(奇异值缩紧步长),sigma
% % output：输出恢复后的矩阵Z,迭代次数iterations
% % iterations = 0;%迭代次数
% % global gamma
% % global alpha
% 
% % k0= 1100;%655
% % y1=diag(Z);
% 
% % Y1= k0*sigma*M;% 辅助矩阵Y初始化
% % if nargin < 3
% %     T =  sqrt(n1*n2);
% % end
% % if nargin < 4
% %     delta = 1;
% % end
% % if nargin < 5
% %     itermax = 200 ;
% % end
% % if nargin < 6
% %     tol = 1e-7;
% % end
% % for ii = 1:itermax
% %     % singular value threshold operation
% %     P=lbd/(lbd+alpha)*(J+Y1/lbd);%进行特征值分解的部分
% %     [U, S, V] = svd(P, 'econ'); %这一步求得特征值都很小
%     S = sign(S) .* max(abs(S) - tao, 0);
%     Z = U*S*V';
%     M= Z-diag(diag(Z));%对角元素为零的矩阵
%     % update auxiliary matrix Y
%     Y1 = Y1 + sigma*(M-Z);
%    
% %     Y = P.*Y ;
%     % computer error
%     error= norm((M-Z),'fro' )/norm(M,'fro' );
%     if error<0.001
%         break;
%     end
%     % update iterations
% %     iterations = ii ;
% end


% while epsilon>1e-3
%     %奇异值紧缩
%     P=lbd/(lbd+alpha)*(J+Y1/lbd);%进行特征值分解的部分
%     Z = SVD( gamma,P );
%     %更新辅助矩阵Y
%     Y1 = Y1 + sigma* (M-Z);
%     %计算阈值
%     epsilon= norm((M-X),'fro' )/norm(M,'fro' );
%     %更新迭代次数
%     iterations = iterations + 1;
% end
% end


% function [Z] = update_Z(J,X,Y1,Z,lbd)
% %[m,k]=size(J);
% n = size(X{1}, 2);%列
% %n2 = size(X{1}, 1);%行
% E=1e-3;%容忍度
% global gamma
% global alpha
% %gamma=1000;%相当于τ
% changliang = 1;
% % sigma = 1.2*n/k;%步长
% % sigma1();
% %global Y;
% %Y=zeros(n,n);%拉格朗日乘子矩阵
% % P{1}=lbd/(lbd+alpha)*(J+Y/lbd);%进行特征值分解的部分
% %[Z] = init_Z(X,lbd);
% M= Z-diag(diag(Z));%对角元素为零的矩阵
% % sigma1(n);
% %s=0;
% %r=[];s=[];
% r=1;%Z未迭代前的秩=1,%r{1}=r{0}开始
% % P{1}=(lbd/(lbd+alpha))*(J+Y/lbd);
% %     [U,S,V] = svd(P{1});
% %     sigma1=diag(S);%返回S中主对角元素的列向量， 只有一个特征值是非常大的，其他不超9
% kmax1=200;
% % s2=max(size(sigma1));
% % for d=1:s2
% % Zopt=(sigma1(d)-gamma)*U(:,d)*V(:,d)';
% % end
% flag=1;
% for g=2:kmax1
%     s=r+1;
%     P{g}=(lbd/(lbd+alpha))*(J+Y1/lbd);
% %     [U,S,V] = lansvd(P{g-1},s,'L');%p{1}=p{0}开始
% %     sigma1=diag(S);%返回S中主对角元素的列向量     %sigma k=siama k-1开始
% %     s1=length(sigma1);%2
%         while flag
%             [U,S,V] = lansvd(P{g-1},s,'L');%p{1}=p{0}开始
%             sigma1=diag(S);%返回S中主对角元素的列向量     %sigma k=siama k-1开始
%             s1=length(sigma1);%2
%             s=s+changliang;
%             if sigma1(s-changliang)<= gamma
%            flag=0;
%             end
%         end
%             for kl=1:s1
%                 r=find((sigma1(kl)>gamma)==max(sigma1(kl)>gamma));%r{2}=r{1}开始
%             % Zopt=(sigma1(j)-gamma)*U(:,j)*V(:,j)';
%             RG=length(r);
%             for h=1:RG
%                 Zopt=sum((sigma1(kl)-gamma)*U(:,kl)'*V(:,kl))
%             end
%             end
%          
%         for i=1:n
%         for q=1:n
%             if norm(Zopt-M,'fro')/norm(M,'fro') <= E
%                 Y1(i,q)= Y1(i,q)+ sigma*(M(i,q)-Zopt(i,q));
%             end
%         end
%         end
%       
%     
% %     s1=max(size(sigma1));
% %     for kl=2:s1
% %         r(g) =find((sigma1(kl)>gamma)==max(sigma1(kl)>gamma));%r{2}=r{1}开始
% %        % Zopt=(sigma1(j)-gamma)*U(:,j)*V(:,j)';
% %        RG=size(r);
% %        for h=1:RG
% %         Zopt=Zopt+sum((sigma1(kl)-gamma)*U(:,kl)*V(:,kl)');
% %        end
% %     end
% %     RG=size(r);
% %     for h=1:RG
% %         Zopt=Zopt+sum((sigma1(kl)-gamma)*U(:,kl)*V(:,kl)');
% %     end
% %     for i=1:n
% %         for q=1:n
% %             if norm(Z-M,'fro')/norm(M,'fro') <= E
% %                 Y(i,q)= Y(i,q)+ sigma*(M(i,q)-Z(i,q));
% %             end
% %         end
% end
%    Z=Zopt;
% end
% 
% 
%     
%     
%     
%     
%     
%     
% % for h=1:q
% % [U,S,V]=svd(J{h});
% % dS=diag(S);
% % n1=size(dS);
% % for i=1:n1
% %     a(i)=dS(i)- gamma/(alpha+lbd);
% %     b(i)=max(0,a(i));
% % %Z = U*diag(max(0,a(i)))*V ;
% % end
% % end
% % Z = U*diag(b)*V ;
% % Z1= Z - diag(diag(Z));
% % J1= J1+ sigma*(Z1-Z);

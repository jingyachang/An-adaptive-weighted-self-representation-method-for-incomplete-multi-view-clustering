 function [Z] = update_Z3(X,Z,J,lbd,gamma,alpha)
n = size(X{1}, 2);%400ά
tao= gamma/(alpha+lbd);
% tao=0.05;
sigma = 18;%
itermax=250;
y1= zeros(n,1);%������
Y1= diag(y1);
for ii = 1:itermax
    % singular value threshold operation
    P=(alpha/(lbd+alpha))*((1/alpha)*Y1+J);%��������ֵ�ֽ�Ĳ���
    [U, S, V] = svd(P, 'econ'); %��һ���������ֵ
   S = sign(S).* max(abs(S) - tao, 0);%abs(S)
    Z = U*S*V';
%     objz=objz3(Z,J,lbd,gamma,alpha)
    y1=y1-sigma*(diag(Z));
    Y1= diag(y1);%�Խ�Ԫ��ȫ��y��Ԫ�أ��ǶԽ�Ϊ��
    % computer error
    error= norm(-diag(Z),2);%/norm(diag(Z),'fro' );Լ�������ķ���֮������Ҳ�ķ���
    if error<0.005
        break;
    end
%     y1=y1-sigma*(diag(Z));
%     Y1= diag(y1);%�Խ�Ԫ��ȫ��y��Ԫ�أ��ǶԽ�Ϊ��
end



% function [Z] = update_Z3(X,Z,J,lbd,gamma,alpha)
% Single value thresholding algorithm��SVT
% function���������ģ��
%                  min  ||U||*
%               s.t. P(U-M) = 0
% ���У�U�ǻָ���õ��ĵ��Ⱦ���M�ǹ۲����
% input���۲����M,�۲�Ԫ��λ�þ���P,����gamma(����ֵ��������),sigma
% output������ָ���ľ���Z,��������iterations
% n = size(X{1}, 2);%��
% M= Z-diag(diag(Z));%�Խ�Ԫ��Ϊ��ľ���
% epsilon= 1e3;%������ֹ��ֵ
% 
% iterations = 0;%��������
% global gamma
% global alpha
% tao= gamma/(alpha+lbd);
% sigma = 1.76;%����1~2%1.78
% itermax=15;
% k0= 655;%655
% Y1= k0*sigma*M;% ��������Y��ʼ��
% Y1= k0*sigma*M;% ��������Y��ʼ��
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
% % epsilon= 1e3;%������ֹ��ֵ
% 
% %Single value thresholding algorithm��SVT
% % function���������ģ��
% %                  min  ||U||*
% %               s.t. P(U-M) = 0
% % ���У�U�ǻָ���õ��ĵ��Ⱦ���M�ǹ۲����
% % input���۲����M,�۲�Ԫ��λ�þ���P,����gamma(����ֵ��������),sigma
% % output������ָ���ľ���Z,��������iterations
% % iterations = 0;%��������
% % global gamma
% % global alpha
% 
% % k0= 1100;%655
% % y1=diag(Z);
% 
% % Y1= k0*sigma*M;% ��������Y��ʼ��
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
% %     P=lbd/(lbd+alpha)*(J+Y1/lbd);%��������ֵ�ֽ�Ĳ���
% %     [U, S, V] = svd(P, 'econ'); %��һ���������ֵ����С
%     S = sign(S) .* max(abs(S) - tao, 0);
%     Z = U*S*V';
%     M= Z-diag(diag(Z));%�Խ�Ԫ��Ϊ��ľ���
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
%     %����ֵ����
%     P=lbd/(lbd+alpha)*(J+Y1/lbd);%��������ֵ�ֽ�Ĳ���
%     Z = SVD( gamma,P );
%     %���¸�������Y
%     Y1 = Y1 + sigma* (M-Z);
%     %������ֵ
%     epsilon= norm((M-X),'fro' )/norm(M,'fro' );
%     %���µ�������
%     iterations = iterations + 1;
% end
% end


% function [Z] = update_Z(J,X,Y1,Z,lbd)
% %[m,k]=size(J);
% n = size(X{1}, 2);%��
% %n2 = size(X{1}, 1);%��
% E=1e-3;%���̶�
% global gamma
% global alpha
% %gamma=1000;%�൱�ڦ�
% changliang = 1;
% % sigma = 1.2*n/k;%����
% % sigma1();
% %global Y;
% %Y=zeros(n,n);%�������ճ��Ӿ���
% % P{1}=lbd/(lbd+alpha)*(J+Y/lbd);%��������ֵ�ֽ�Ĳ���
% %[Z] = init_Z(X,lbd);
% M= Z-diag(diag(Z));%�Խ�Ԫ��Ϊ��ľ���
% % sigma1(n);
% %s=0;
% %r=[];s=[];
% r=1;%Zδ����ǰ����=1,%r{1}=r{0}��ʼ
% % P{1}=(lbd/(lbd+alpha))*(J+Y/lbd);
% %     [U,S,V] = svd(P{1});
% %     sigma1=diag(S);%����S�����Խ�Ԫ�ص��������� ֻ��һ������ֵ�Ƿǳ���ģ���������9
% kmax1=200;
% % s2=max(size(sigma1));
% % for d=1:s2
% % Zopt=(sigma1(d)-gamma)*U(:,d)*V(:,d)';
% % end
% flag=1;
% for g=2:kmax1
%     s=r+1;
%     P{g}=(lbd/(lbd+alpha))*(J+Y1/lbd);
% %     [U,S,V] = lansvd(P{g-1},s,'L');%p{1}=p{0}��ʼ
% %     sigma1=diag(S);%����S�����Խ�Ԫ�ص�������     %sigma k=siama k-1��ʼ
% %     s1=length(sigma1);%2
%         while flag
%             [U,S,V] = lansvd(P{g-1},s,'L');%p{1}=p{0}��ʼ
%             sigma1=diag(S);%����S�����Խ�Ԫ�ص�������     %sigma k=siama k-1��ʼ
%             s1=length(sigma1);%2
%             s=s+changliang;
%             if sigma1(s-changliang)<= gamma
%            flag=0;
%             end
%         end
%             for kl=1:s1
%                 r=find((sigma1(kl)>gamma)==max(sigma1(kl)>gamma));%r{2}=r{1}��ʼ
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
% %         r(g) =find((sigma1(kl)>gamma)==max(sigma1(kl)>gamma));%r{2}=r{1}��ʼ
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

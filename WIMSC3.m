function [Z, obj] = WIMSC3(X, Im, k, lbd,gamma,alpha)

V = size(X, 1);

n = size(X{1}, 2);
max_iter = 100;
% global gamma
% global alpha
% gamma =1000;
% alpha=500;
%beta = ones(V,1)/V;
for i=1:V
    X{i}(:,Im{i}) = 0;%����������ǽ���ͼŪ��ȱʧ������%ʹ��Բ���Ž���ֵ���������������磬C{1,1} ����һ�� 1��3  ��ֵ���� [1 2 3]��ʹ��Բ���ŷ��ʸ������ĵڶ���Ԫ�ء�C{1,1}(1,2)
end

[Z] = init_Z3(X,lbd);

%[J] = init_J(X);
[W] =update_W3(X);
%[Y1] = init_Y1(X,Z,k);
[J]=init_Z3(X,lbd);%rand(n);
%data_path = 'D:\�о�������\����ͼ\IMSR���д���\IMSR-code_release-main\IMSR���ݼ�\';
% BJ3=cal_obj3(X, Z, J,W, lbd,gamma,alpha)
%data_name = 'orlRnSp';
%load([data_path, data_name],'weight');
%W = weight';
t = 0;
flag = 1;
while flag
    %% update W 
   % [W] = update_W(X);
%    n = size(X{1}, 2);
% V = size(X, 1);%����ͼ��
% base1=zeros(n);
% for i=1:V
%     base1=base1+(X{i}'*X{i})*J*(W{i}'*W{i});
% end
% base2=base1+(alpha/2)*J;
% base3=reshape(base2,[n*n,1]);
    %% update J
    [J] = update_J3(X, Z, W,alpha,J);
%      J1=vec(J);
%      BJ=cal_obj3(X, Z, J,W, lbd,gamma,alpha)

    %% update X
    [X] = update_X3(X, Im, J,W);
%     BJ1=cal_obj3(X, Z, J,W, lbd,gamma,alpha)

    %% update W 
    [W] = update_W3(X);
%     BJ2=cal_obj3(X, Z, J,W, lbd,gamma,alpha)

    %% update Z
    [Z] = update_Z3(X,Z,J,lbd,gamma,alpha);
%     BJ3=cal_obj3(X, Z, J,W, lbd,gamma,alpha)

%     [Z] = update_Z(J,X,Y1,Z,lbd);
%    % % update Y 
%     [Y1] = update_Y1(X,Z,Y1);
%     %% update X
%     [X] = update_X(X, Im, J,W);
%     %% update W 
%     [W] = update_W(X);
    %% cal obj
    t = t+1;
    [obj(t),~,~,~] = cal_obj3(X, Z, J,W, lbd,gamma,alpha);
    if t>=2 && (abs((obj(t-1)-obj(t))/(obj(t)))<1e-3 || t>max_iter)
%     if t==20
        flag =0;
    end
end
  
end
%  function base= applyMoler(J1)
% base1=zeros(n);
% for i=1:V
%     base1=base1+(X{i}'*X{i})*J*(W{i}'*W{i});
% end
% base2=base1+(alpha/2)*J;
% base=reshape(base2,[n*n,1]);
%  end

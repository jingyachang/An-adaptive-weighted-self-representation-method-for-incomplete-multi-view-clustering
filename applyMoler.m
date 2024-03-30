% function base= applyMoler(j)
% base=j;
% base=reshape
% end
% 
% function base3= update_base3(X,W,J,alpha)
% n = size(X{1}, 2);
% V = size(X, 1);%多视图数
% base1=zeros(n);
% for i=1:V
%     base1=base1+(X{i}'*X{i})*J*(W{i}'*W{i});
% end
% base2=base1+(alpha/2)*J;
% base3=reshape(base2,[n*n,1]);
% end
 function base= applyMoler(base3)
base=base3;

% X = update_X3(X, Im, J,W);
% n = size(X{1}, 2);
% J=reshape(base,[n,n]);
% % n = size(X{1}, 2);
% V = size(X, 1);%多视图数
% base1=zeros(n);
% for i=1:V
%     base1=base1+(X{i}'*X{i})*J*(W{i}'*W{i});
% end
% base2=base1+(alpha/2)*J;
% base=reshape(base2,[n*n,1]);
end
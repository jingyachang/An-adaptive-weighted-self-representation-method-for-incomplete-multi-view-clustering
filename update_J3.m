function [J] = update_J3(X, Z, W,alpha,J)
 V = size(X, 1);%多视图数

n = size(X{1}, 2);%400维

J1=reshape(J,[n*n,1]);
function base= applyMoler(J1)
% base=J1;
J2=reshape(J1,[n,n]);%这里的J2=J；
base1=zeros(n);
for g=1:V
    base1=base1+X{g}'*X{g}*J2*W{g}'*W{g};
end
base2=base1+(alpha/2)*J2;
base=reshape(base2,[n*n,1]);
end

C=zeros(n);
for i=1:V
    C=C+(X{i}'*X{i})*(W{i}'*W{i});
end
C1=C+(alpha/2)*Z;
c=reshape(C1,[n*n,1]);
tol = 1e-4;
maxit = 300;

[j,flag2,rr2,ro2,]= pcg(@applyMoler,c,tol,maxit,[],[],J1);%自己预定义初始j0=base3,然后让applyMoler的y=base3
J=reshape(j,[n,n]);%最终输出的全零矩阵
end


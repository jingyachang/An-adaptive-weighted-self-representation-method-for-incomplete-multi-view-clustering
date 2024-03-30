function [X] = update_X3(X, Im, J,W)
 V = size(X, 1);%多视图数
n = size(X{1}, 2);

%求出论文中每个视图对应得B1_i
for j=1:V
    Io{j} = setdiff([1:n], Im{j});
    B2{j} = W{j}'*W{j} - J*W{j}'*W{j} - W{j}'*W{j}*J' + J*W{j}'*W{j}*J';
% Io{j} = setdiff([1:n], Im{j});%setdiff(A,B) 返回 A 中存在但 B 中不存在的行
%                                   %求出未缺少的列（行）
end
% % B2{1}(isnan(B2{1})==1)=0;%把缺失值设置为零
% % B2{2}(isnan(B2{2})==1)=0;
% % B2{3}(isnan(B2{3})==1)=0;%把缺失值设置为零
% % % B2{4}(isnan(B2{4})==1)=0;
% % %求出每个视图对应得B1_i的特征值矩阵和酉矩阵
[U11,S11,V11]= svd(B2{1}(Im{1},Im{1}));
[U22,S22,V22]= svd(B2{2}(Im{2},Im{2}));
% [U33,S33,V33]= svd(B2{3}(Im{3},Im{3}));
% [U44,S44,V44]= svd(B2{4}(Im{4},Im{4}));
%求出每个视图对应得X{i}^{(mm)},公式（20）
X{1}(:,Im{1}) = -X{1}(:,Io{1})*B2{1}(Io{1},Im{1})*(V11*pinv(S11)*U11');
X{2}(:,Im{2}) = -X{2}(:,Io{2})*B2{2}(Io{2},Im{2})*(V22*pinv(S22)*U22');
% X{3}(:,Im{3}) = -X{3}(:,Io{3})*B2{3}(Io{3},Im{3})*(V33*pinv(S33)*U33');
% X{4}(:,Im{4}) = -X{4}(:,Io{4})*B2{4}(Io{4},Im{4})*(V44*pinv(S44)*U44');
% for i=1:V
%     %Io{i} = setdiff([1:n], Im{i});
%     %Im{i} = setdiff([1:n], Io{i});
%     X{i}(:,Im{i}) = -X{i}(:,Io{i})*B2{i}(Io{i},Im{i})*(V11*pinv(S11)*U11'+V22*pinv(S22)*U22');  
% end

end


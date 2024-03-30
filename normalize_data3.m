function [ProcessData]=normalize_data3(X)

nView = length(X);
nSmp = size(X{1},2);

ProcessData = cell(nView, 1);
for i = 1:nView %原先是v
	Xi = X{i}+1e-12;
	for j = 1:nSmp  %原先是i
	    % ProcessData{v}(:,i) = Xv(:,i) ./ max(1e-12,norm(Xv(:,i)));
	    ProcessData{i}(:,j) = Xi(:,j) ./ sqrt(Xi(:,j)'*Xi(:,j));
	end
end
function [W] = init_W3(X)
data_path = 'C:\Users\GDRC-DZ\Documents\MATLAB\AWSR_code\AWSR数据集\';
%  data_name = '100Leaves';
%  data_name = 'still-2-mtv';%1*2
%  data_name = 'buaaRnSp';%2视图
%  data_name = 'olympics_3view';%2视图
%  data_name = 'Yale';
data_name = 'BBCSport4';%4视图4*1
%  data_name = 'orlRnSp';%2视图

load([data_path, data_name], 'data','per');
%   X = data';%其他是1*3
  X = data;%BBCSport是4*1
V = size(X, 1);

n = size(X{1}, 2);
% n1 = size(X{1}, 1);
missing_ratios = [0.1:0.1:0.5];%损失率

iters = 10;

for iter = 1:iters
    for mr = 5:5%length(missing_ratios)%1：1，把每个缺失率的初始矩阵求出
        
       % fprintf('\n data_name: %s, missing rate: %.1f, iter: %d', data_name, missing_ratios(mr), iter);
       
        for i=1:size(per{mr}{iter},2)
            %将元胞数组索引括在花括号中。例如，C{2,1} 返回元胞数组 {'one','two'}。使用花括号访问该元胞数组中的第二个元胞的内容。C{2,1}{1,2}
             Im{i} = find(per{mr}{iter}(:,i)==0);
            % Io{i} = find(per{mr}{iter}(:,i)~=0);
              
        end
%        for j=1:V 
%            Io{j} = setdiff([1:n], Im{j});
%            X{j}(:,Im{j})==  0;
%            W1{j}(:,Im{j}) =X{j}(:,Im{j}); 
%          
%             X{j}(:,Io{j}) == 1;
%             W1{j}(:,Io{j}) =X{j}(:,Io{j}); 
           for j=1:V  
            Io{j} = setdiff([1:n], Im{j});
            X{j}(:,Im{j}) = 0;
            W{j}(:,Im{j}) =X{j}(:,Im{j}); 
            X{j}(:,Io{j}) = 1;
            W{j}(:,Io{j}) =X{j}(:,Io{j}); 
           end
%          for j=1:V
%               W{i}=X{i}*per;
%          end

%             for j=1:V
%             X{j}(:,Im{j}) = 0;%这里的作用是将视图弄成缺失的数据
%             X{j}(:,Io{j}) = 1;
%             end
%             W{j}(:,Im{i}) =X{j}(:,Im{i}); 
%             W{j}(:,Io{i}) =X{j}(:,Io{i}); 
         
%        end
   end  

end 
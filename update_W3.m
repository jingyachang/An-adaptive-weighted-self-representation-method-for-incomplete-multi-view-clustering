function [W] = update_W3(X)
V = size(X, 1);

n = size(X{1}, 2);%列
n1 = size(X{1}, 1);%行
m = size(X{2}, 2);%列
m1 = size(X{2}, 1);%行
%   m11 = size(X{3}, 2);%列
%  m12 = size(X{3}, 1);%行
%  m21 = size(X{3}, 2);%列
% m22 = size(X{3}, 1);%行

%for i=1:V
    for j=1:n1
        for k=1:n
            if X{1}(j,k)==0
                W{1}(j,k)=0;
            else
                W{1}(j,k)=1;
            end
        end
    end
%end
   for g=1:m1
        for h=1:m
            if X{2}(g,h)==0
                W{2}(g,h)=0;
            else
                W{2}(g,h)=1;
            end
        end
   end
  
%    for g1=1:m12
%         for h1=1:m11
%             if X{3}(g1,h1)==0
%                 W{3}(g1,h1)=0;
%             else
%                 W{3}(g1,h1)=1;
% %             end
%         end
%    end
% % % % % 
%    for g2=1:m22
%         for h2=1:m21
%             if X{4}(g2,h2)==0
%                 W{4}(g2,h2)=0;
%             else
%                 W{4}(g2,h2)=1;
%             end
%         end
%    end
end
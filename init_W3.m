function [W] = init_W3(X)
data_path = 'C:\Users\GDRC-DZ\Documents\MATLAB\AWSR_code\AWSR���ݼ�\';
%  data_name = '100Leaves';
%  data_name = 'still-2-mtv';%1*2
%  data_name = 'buaaRnSp';%2��ͼ
%  data_name = 'olympics_3view';%2��ͼ
%  data_name = 'Yale';
data_name = 'BBCSport4';%4��ͼ4*1
%  data_name = 'orlRnSp';%2��ͼ

load([data_path, data_name], 'data','per');
%   X = data';%������1*3
  X = data;%BBCSport��4*1
V = size(X, 1);

n = size(X{1}, 2);
% n1 = size(X{1}, 1);
missing_ratios = [0.1:0.1:0.5];%��ʧ��

iters = 10;

for iter = 1:iters
    for mr = 5:5%length(missing_ratios)%1��1����ÿ��ȱʧ�ʵĳ�ʼ�������
        
       % fprintf('\n data_name: %s, missing rate: %.1f, iter: %d', data_name, missing_ratios(mr), iter);
       
        for i=1:size(per{mr}{iter},2)
            %��Ԫ�������������ڻ������С����磬C{2,1} ����Ԫ������ {'one','two'}��ʹ�û����ŷ��ʸ�Ԫ�������еĵڶ���Ԫ�������ݡ�C{2,1}{1,2}
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
%             X{j}(:,Im{j}) = 0;%����������ǽ���ͼŪ��ȱʧ������
%             X{j}(:,Io{j}) = 1;
%             end
%             W{j}(:,Im{i}) =X{j}(:,Im{i}); 
%             W{j}(:,Io{i}) =X{j}(:,Io{i}); 
         
%        end
   end  

end 
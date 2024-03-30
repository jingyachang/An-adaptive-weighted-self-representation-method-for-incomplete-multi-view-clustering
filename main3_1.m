clear
clc
warning off %消除警告提示

 proj_path = 'C:\Users\GDRC-DZ\Documents\MATLAB\';
%proj_path = 'D:\研究生论文\多视图\IMSR运行代码\';
addpath(genpath(proj_path));
%matlab没有分层的概念，所以将其他子文件夹的数据添加到主程序目录在程序前添加代码：addpath(genpath(pwd));

data_path = 'D:\MATLAB\AWSR_code\AWSR数据集\';

 %  data_name = '100Leaves';
% data_name = 'BBCSport4';%4视图
%load([data_path, data_name], 'truth', 'data');%下载[data_path, data_name],文件中的 'data', 'truth', 'per'
 %X = data'; %BBCSport4
% X = data;
%%%%%%%%%%%%%%%%%%%%my_ORL
load('my_ORL.mat');
X{1}=X1;X{2}=X2;X{3}=X3;
truth=gt;
% %%%%%%%%%%%%%%%%%%%
 Y = truth - min(truth) + 1; 
%W = weight';
k = length(unique(Y));%unique(Y)筛除向量中的重复值，产生的结果按升序排列；Y是一个数组，那么返回的是A不重复的行。数组C的行是按顺序排列的。
V = size(X, 2);%多视图数

n = size(X{1},2);%单元数组X{1}的列数；{}用于cell型的数组（就是前面讲的单元数组）的分配或引用
%n1 = size(X{1}, 1);
X = normalize_data3(X);% normalize data，自定义的正则化函数

iters = 10;
for iter = 1:iters
%     for mr = 1:length(missing_ratios)
%         fprintf('\n data_name: %s, missing rate: %.1f, iter: %d', data_name, missing_ratios(mr), iter); 
%         for i=1:size(per{mr}{iter},2)
%             %将元胞数组索引括在花括号中。例如，C{2,1} 返回元胞数组 {'one','two'}。使用花括号访问该元胞数组中的第二个元胞的内容。C{2,1}{1,2}
%             Im{i} = find(per{mr}{iter}(:,i)==0);
%         end
%         % parameters
%         
%          lbd_set = 2.^(-10:2:10);%;BBCSport
%          gamma_set = 2.^(2.5:1:4.5);%3.6
%         alpha_set = 2.^(7.3:0.1:8);%5.7
        lbd_set = 2.^(-3:1:0);%;% my_ORL
        gamma_set = 2.^(2:1:4);
        alpha_set =2.^(6.7:0.05:6.85);%5.7
%           lbd_set =2^(-2.2);%:2:10);%:0.1:-1.6);%;% 100Leaves
%         gamma_set = 2^(3.1);%:1:4);9
%         alpha_set = 2^(7.6);%:0.1:8);%590

        for il = 1:length(lbd_set)%1
%         for il = 1:length(lbd_set)%行数或列数的较大值
             for ig = 1:length(gamma_set)%3
                for ik=1:length(alpha_set)
                % algorithm WIMSC(X, Im, k, lbd, gamma, alpha)
%                 [Ztmp, objtmp] = WIMSC3(X, Im, k, lbd_set(il));
                  [Ztmp, objtmp]=WIMSC3_1(X,k, lbd_set(il),gamma_set(ig),alpha_set(ik));
                % cal res
%                 objz=objz3(Z,J,lbd,gamma,alpha);
                Ztmp = (abs(Ztmp)+abs(Ztmp'))/2; %拉普拉斯矩阵
                [Utmp] = baseline_spectral_onkernel3(Ztmp , k);%聚类分配
                iters_eval = 1; % set to reduce the randomness of k-means
                for i=1:1
                    [ytmp] = my_lite_kmeans(Utmp, k);%在文件eval
%                     length(ytmp)
%                     length(Y)
                    [evals(i,:)] = my_eval_y(ytmp, Y);%计算ACC，NMI,PUR,涉及了eval的全部文件
 
                end
                eval = mean(evals,1);
                fprintf('\nil: %d,ig: %d,ik: %d, acc: %.4f, nmi: %.4f, pur: %.4f', il,ig,ik, eval(1), eval(2), eval(3)); 
               % end fprintf('\nil: %d, ig: %d,ik: %d, acc: %.4f, nmi: %.4f, pur: %.4f', il, eval(1)); 
                end
             end

        end
end

    %end

%end

clear
clc
warning off %����������ʾ

 proj_path = 'C:\Users\GDRC-DZ\Documents\MATLAB\';
%proj_path = 'D:\�о�������\����ͼ\IMSR���д���\';
addpath(genpath(proj_path));
%matlabû�зֲ�ĸ�����Խ��������ļ��е�������ӵ�������Ŀ¼�ڳ���ǰ��Ӵ��룺addpath(genpath(pwd));

data_path = 'D:\MATLAB\AWSR_code\AWSR���ݼ�\';

 %  data_name = '100Leaves';
% data_name = 'BBCSport4';%4��ͼ
%load([data_path, data_name], 'truth', 'data');%����[data_path, data_name],�ļ��е� 'data', 'truth', 'per'
 %X = data'; %BBCSport4
% X = data;
%%%%%%%%%%%%%%%%%%%%my_ORL
load('my_ORL.mat');
X{1}=X1;X{2}=X2;X{3}=X3;
truth=gt;
% %%%%%%%%%%%%%%%%%%%
 Y = truth - min(truth) + 1; 
%W = weight';
k = length(unique(Y));%unique(Y)ɸ�������е��ظ�ֵ�������Ľ�����������У�Y��һ�����飬��ô���ص���A���ظ����С�����C�����ǰ�˳�����еġ�
V = size(X, 2);%����ͼ��

n = size(X{1},2);%��Ԫ����X{1}��������{}����cell�͵����飨����ǰ�潲�ĵ�Ԫ���飩�ķ��������
%n1 = size(X{1}, 1);
X = normalize_data3(X);% normalize data���Զ�������򻯺���

iters = 10;
for iter = 1:iters
%     for mr = 1:length(missing_ratios)
%         fprintf('\n data_name: %s, missing rate: %.1f, iter: %d', data_name, missing_ratios(mr), iter); 
%         for i=1:size(per{mr}{iter},2)
%             %��Ԫ�������������ڻ������С����磬C{2,1} ����Ԫ������ {'one','two'}��ʹ�û����ŷ��ʸ�Ԫ�������еĵڶ���Ԫ�������ݡ�C{2,1}{1,2}
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
%         for il = 1:length(lbd_set)%�����������Ľϴ�ֵ
             for ig = 1:length(gamma_set)%3
                for ik=1:length(alpha_set)
                % algorithm WIMSC(X, Im, k, lbd, gamma, alpha)
%                 [Ztmp, objtmp] = WIMSC3(X, Im, k, lbd_set(il));
                  [Ztmp, objtmp]=WIMSC3_1(X,k, lbd_set(il),gamma_set(ig),alpha_set(ik));
                % cal res
%                 objz=objz3(Z,J,lbd,gamma,alpha);
                Ztmp = (abs(Ztmp)+abs(Ztmp'))/2; %������˹����
                [Utmp] = baseline_spectral_onkernel3(Ztmp , k);%�������
                iters_eval = 1; % set to reduce the randomness of k-means
                for i=1:1
                    [ytmp] = my_lite_kmeans(Utmp, k);%���ļ�eval
%                     length(ytmp)
%                     length(Y)
                    [evals(i,:)] = my_eval_y(ytmp, Y);%����ACC��NMI,PUR,�漰��eval��ȫ���ļ�
 
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

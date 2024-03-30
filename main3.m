clear
clc
warning off %����������ʾ

 proj_path = 'C:\Users\GDRC-DZ\Documents\MATLAB\';
%proj_path = 'D:\�о�������\����ͼ\IMSR���д���\';
addpath(genpath(proj_path));
%matlabû�зֲ�ĸ�����Խ��������ļ��е�������ӵ�������Ŀ¼�ڳ���ǰ��Ӵ��룺addpath(genpath(pwd));

%data_path = 'C:\Users\GDRC-DZ\Documents\MATLAB\AWSR_code\AWSR���ݼ�\';
data_path = 'D:\MATLAB\AWSR_code\AWSR���ݼ�\';

%  data_name = 'still-2-mtv';
% data_name = 'buaaRnSp';%2��ͼ
 %  data_name = '100Leaves';%3��ͼ
% data_name = 'Yale';
   data_name = 'olympics_3view';%2��ͼ
% data_name = 'BBCSport4';%4��ͼ
% data_path = 'D:\�о�������\����ͼ\IMSR���д���\IMSR���ݼ�\';
%   data_name = 'orlRnSp';%2��ͼ
load([data_path, data_name], 'data', 'truth', 'per');%����[data_path, data_name],�ļ��е� 'data', 'truth', 'per'
% X = data'; 
 X = data;
Y = truth - min(truth) + 1; 
%W = weight';
k = length(unique(Y));%unique(Y)ɸ�������е��ظ�ֵ�������Ľ�����������У�Y��һ�����飬��ô���ص���A���ظ����С�����C�����ǰ�˳�����еġ�
V = size(X, 1);%����ͼ��

n = size(X{1},2);%��Ԫ����X{1}��������{}����cell�͵����飨����ǰ�潲�ĵ�Ԫ���飩�ķ��������
%n1 = size(X{1}, 1);
X = normalize_data3(X);% normalize data���Զ�������򻯺���
% global alpha
% alpha=300;
% global gamma
% gamma=75;
% global Y1
% Y1=ones(n,n);
missing_ratios = [0.1:0.1:0.5];%��ʧ��

iters = 10;
for iter = 1:iters
    for mr = 1:length(missing_ratios)
        fprintf('\n data_name: %s, missing rate: %.1f, iter: %d', data_name, missing_ratios(mr), iter); 
        for i=1:size(per{mr}{iter},2)
            %��Ԫ�������������ڻ������С����磬C{2,1} ����Ԫ������ {'one','two'}��ʹ�û����ŷ��ʸ�Ԫ�������еĵڶ���Ԫ�������ݡ�C{2,1}{1,2}
            Im{i} = find(per{mr}{iter}(:,i)==0);
        end
        % parameters
%  %%%%%%%%%Olympics       
        lbd_set = 2.^(-1.8:0.1:-1.7);%;% olympics_3view
        gamma_set = 2.^(3.1:0.2:3.5);%2
        alpha_set = 2.^(7.2:0.1:8);%8
% % %%%%%%%%%%%%%Leaves
%         lbd_set = 2.^(-2.3:0.1:-1.6);%;
%         gamma_set = 2.^(3.1:0.2:3.6);%3.6
%         alpha_set = 2.^(7.4:0.1:8);%5.7
%%%%%%%%%%%ORL
%         lbd_set = 2.^(-2.9:0.1:-1.7);%;% 
%         gamma_set = 2.^(3.1:0.2:3.6);%3.6
%         alpha_set = 2.^(7.3:0.1:8);%5.7
        for il = 2:2%length(lbd_set)%1
%         for il = 1:length(lbd_set)%�����������Ľϴ�ֵ
             for ig = 1:length(gamma_set)%3
                for ik=1:length(alpha_set)
                % algorithm WIMSC(X, Im, k, lbd, gamma, alpha)
%                 [Ztmp, objtmp] = WIMSC3(X, Im, k, lbd_set(il));
                  [Ztmp, objtmp]=WIMSC3(X, Im, k, lbd_set(il),gamma_set(ig),alpha_set(ik));
                % cal res
%                 objz=objz3(Z,J,lbd,gamma,alpha);
                Ztmp = (abs(Ztmp)+abs(Ztmp'))/2; %������˹����
                  figure(1); imagesc(Ztmp);colorbar;
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

end



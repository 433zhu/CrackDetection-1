%% ��ʼ������ȡͼƬ
clear;
close all;
load('crackforest.mat');
%maxF1 = 0.7063;
pics = 118;
Pr = zeros(1,pics);
Re = zeros(1,pics);
F1 = zeros(1,pics);
tic;
for No = 1:pics
% No = 4;
Im = crackIm{No};
GT = crackGT{No};
% imwrite(Im,['.\Result\source',num2str(No),'.png'],'png');
% imwrite(GT,['.\Result\GT',num2str(No),'.png'],'png');
% figure;imshow(Im);

%% Ԥ����
Im = preproce(Im);
% figure;imshow(Im);

%% ȷ�����ڷֲ����ֵ
thresh = Layer(Im);
% thresh = Layer2(Im);

%% �ӵײ㿪ʼ��������ӿ�������
base = CenDistance(Im,thresh);                          %��ÿ����ͬ������Ϊ���ģ���������Χ����������
% base = DenFilter(Im,thresh);
% figure;imshow(base);

%% ͼ�����
output = postproce(base,Im);

%% ����ָ��
% figure;imshow(output);
% figure;imshow(GT);
% [Pr, Re, F1] = score(output,GT);                            
% imwrite(output,['.\Result\output',num2str(No),'.png'],'png');
[Pr(No), Re(No), F1(No)] = score(output,GT);

end
list = [Pr;Re;F1];
nanmean(F1)
toc;
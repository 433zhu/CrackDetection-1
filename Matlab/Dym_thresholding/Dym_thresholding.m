%% ��ʼ������ȡͼƬ
clear;
close all;
load('crackforest.mat');                        %����CrackForest���ݿ�
%����
% maxF1 = 7103;
cof = 0.72;
block_size = 9;
numL = 8;
pics = 118;
Pr = zeros(1,pics);
Re = zeros(1,pics);
F1 = zeros(1,pics);
tic;
for No = 1:pics
% No = 1;
Im = crackIm{No};                               %��ȡͼƬ
GT = crackGT{No};                               %��ȡGroundTruth
% Im = imread('2017.jpg');
% Im = im2double(rgb2gray(Im));
[M,N] = size(Im);
% figure;imshow(Im);
% imwrite(Im,['.\Result\source',num2str(No),'.png'],'png');

%% Ԥ����
Im = preproce(Im);                              %���������ȱ�������ǿ�Աȶ�
% figure;imshow(Im);
% imwrite(Im,['.\Result\source',num2str(No),'.png'],'png');

%% ��̬��ֵ����
template = fspecial('average',2 * block_size + 1);
meanIm = imfilter(Im, template); %��19*19��������ƽ��ֵ��Ϊ�ֲ���Ϣ
% figure;imshow(cof * meanIm);
% imwrite(meanIm,['.\Result\mean',num2str(No),'.png'],'png');
output = Im < cof * meanIm;                     %���Ҷ�С�ھֲ���ֵʱ����Ϊ���ѷ���ɵ�
% figure;imshow(output);
% imwrite(output,['.\Result\filtered',num2str(No),'.png'],'png');

%% ����
output = bwmorph(output,'bridge',Inf);
output = imclose(output,strel('disk',2));       %���������������̬ѧ�Ž�

[L,num] = bwlabel(output);                      %����������������
region = regionprops(L,'MajorAxisLength');
leng = cat(1, region.MajorAxisLength);
[leng,index] = sort(leng,'descend');
output = zeros(size(Im));
if length(leng) > numL
    j = 1;
    while j < numL
        if sum(leng(1:j)) > 1.2 * max([M,N])
            for i = 1:j
                output(L == index(i)) = 1;
            end
            break;
        else
            j = j + 1;
        end
    end
    if j == numL
        for i = 1:j
            output(L == index(i)) = 1;
        end
    end
else
    output = base;
end

output = FinalFilter(output);                   %ȥ��Բ��ָ���������ȥ���ţ�
% imwrite(output,['.\Result\output',num2str(No),'.png'],'png');

%% ����ָ��
% figure;imshow(output);
% figure;imshow(GT);
% [Pr, Re, F1] = score(output,GT);

[Pr(No), Re(No), F1(No)] = score(output,GT);    %������Ϊ��׼����Pr,Re��F1
end
list = [Pr;Re;F1];
result = nanmean(F1)
time = toc / 118
% if result > maxF1
%     maxF1 = result;
%     cof_choose = cof;
%     block_choose = block_size;
%     numL_choose = numL;
% end
% end
% end
% end

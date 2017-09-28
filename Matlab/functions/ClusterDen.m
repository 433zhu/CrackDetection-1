function base = ClusterDen(Im,thresh)
numlayer = length(thresh);                      %���õĲ���
layer{1} = Im < thresh(1);                      %��1��㣬Ҳ�ǻ�����
base = layer{1};
% [L{1},numL] = bwlabel(base);                        %��ǻ����������
% siz = numel(Im);
% numL = numL/siz;
% if numL < 6*10^(-4)
%     thresh = thresh(2:numlayer);
%     numlayer = 4;
%     layer{1} = Im < thresh(1);                      %��1��㣬Ҳ�ǻ�����
%     base = layer{1};
%     L{1} = bwlabel(base);                           %��ǻ����������
% end
for i = 2:numlayer
    layer{i} = Im < thresh(i) & Im >= thresh(i - 1);    %����ÿһ��㣬������������ֵ֮��ĵ�
%     L{i} = bwlabel(layer{i});                           %���ÿһ�������
    base = base + layer{i};                             %ԭ�в������һ��ĵ�
    [L{i},num] = bwlabel(base);                         %��base���
    D = regionprops(L{i},'Centroid');                   %���������������
    Centoridnew = cat(1, D.Centroid);                   %��¼������������
    ClusterDen = zeros(num,1);
    NumPos = 10 - i;
    for j = 1:num
        CluCen = Centoridnew(j,:);                      %��ȡ������������
        
        %������ȡ����Ҫ���������
        rad = 2;                                        %����뾶
        basepad = padarray(base, [rad rad], 0, 'both'); %����账��ͼ���Ա��������
        neibo = basepad(round(CluCen(2)):round(CluCen(2) + 2 * rad),round(CluCen(1)):round(CluCen(1) + 2 * rad));   %��ȡ���ĵ�Ķ�Ӧ�뾶����������
        while(sum(neibo(:)) < NumPos)                       %�������������������ĵ���С���趨ֵ�����������εı߳��ٴ���ȡ����
            rad = rad + 1;
            basepad = padarray(base, [rad rad], 0, 'both');
            neibo = basepad(round(CluCen(2)):round(CluCen(2) + 2 * rad),round(CluCen(1)):round(CluCen(1) + 2 * rad));
        end
        
        %������ӦԲ������Ҫ��ĵ�ĸ�����ֱ���ﵽ�趨ֵ
        [I,J] = find(neibo);
        distance = sqrt((I - (rad + 1)) .^ 2 + (J - (rad + 1)) .^ 2);%���������������ڵ㵽���ĵ�ľ���
        count = sum(distance <= rad);                               %�����ľ���С�ھ���뾶�ĵ����
        while(count < NumPos)
            rad = rad + 1;
            basepad = padarray(base, [rad rad], 0, 'both');
            neibo = basepad(round(CluCen(2)):round(CluCen(2) + 2 * rad),round(CluCen(1)):round(CluCen(1) + 2 * rad));
            [I,J] = find(neibo);
            distance = sqrt((I - (rad + 1)) .^ 2 + (J - (rad + 1)) .^ 2);
            count = sum(distance <= rad);
        end
        
        %�ж��Ƿ�Ϊ�ѷ�����
        ClusterDen(j) = 1/rad;                  %�����ܶȣ�����Ϊ��С�뾶�ĵ���
        if ClusterDen(j) < 0.05 * 1.3 ^ i
            base(L{i} == j) = 0;
        end
    end
%     figure;hist(ClusterDen);
end
% TP = sum(sum(base & GT));
% FP = sum(sum(base & ~GT));
% FN = sum(sum(~base & GT));
% Pr = TP/(TP + FP)
% Re = TP/(TP + FN)
% F1 = 2 * Pr * Re/(Pr + Re)
% figure;imshow(base);
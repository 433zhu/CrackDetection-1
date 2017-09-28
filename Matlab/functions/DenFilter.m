function base = DenFilter(Im,thresh)
rad = 5;
field = Circular(rad);
numlayer = length(thresh);                      %���õĲ���
layer{1} = Im < thresh(1);                      %��1��㣬Ҳ�ǻ�����
base = layer{1};
[L{1},numL] = bwlabel(base);                           %��ǻ����������
% siz = numel(Im);
% numL = numL/siz;
% if numL < 6*10^(-4)
%     thresh = thresh(2:numlayer);
%     numlayer = 4;
%     layer{1} = Im < thresh(1);                      %��1��㣬Ҳ�ǻ�����
%     base = layer{1};
%     [L{1},numL] = bwlabel(base);                           %��ǻ����������
% end
basepad = padarray(base, [rad rad], 0, 'both');
D = regionprops(L{1},'Centroid');                %���������������
Centorid = cat(1, D.Centroid); 
for j = 1:numL
    CluCen = Centorid(j,:);
    neibo = basepad(round(CluCen(2)):round(CluCen(2) + 2 * rad),round(CluCen(1)):round(CluCen(1) + 2 * rad));
    den = sum(sum(neibo & field));
    if den < 4
        base(L{1} == j) = 0;
    end
end
% imwrite(base,['.\CrackForestPlot\Den\base',num2str(1),'.jpg'],'jpg');
for i = 2:numlayer
    layer{i} = Im < thresh(i) & Im >= thresh(i - 1);    %����ÿһ��㣬������������ֵ֮��ĵ�
%     imwrite(layer{i},['.\CrackForestPlot\Den\layer',num2str(i),'.jpg'],'jpg');
    base = base + layer{i};                             %ԭ�в������һ��ĵ�
%     imwrite(base,['.\CrackForestPlot\Den\base',num2str(i),'.jpg'],'jpg');
    basepad = padarray(base, [rad rad], 0, 'both');
    [L{i},numL] = bwlabel(base);                         %��base���
    D = regionprops(L{i},'Centroid');                   %���������������
    Centorid = cat(1, D.Centroid); 
    for j = 1:numL
        CluCen = Centorid(j,:);
        neibo = basepad(round(CluCen(2)):round(CluCen(2) + 2 * rad),round(CluCen(1)):round(CluCen(1) + 2 * rad));
        den = sum(sum(neibo & field));
        if den < 5
            base(L{i} == j) = 0;
        end
    end
%     imwrite(base,['.\CrackForestPlot\Den\filtered',num2str(i),'.jpg'],'jpg');
%     figure;imshow(base);
end
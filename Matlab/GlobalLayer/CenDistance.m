function base = CenDistance(Im,thresh)
numlayer = length(thresh);
layer = cell(1,numlayer);
L = cell(1,numlayer);
layer{1} = Im < thresh(1);                      %��1��㣬Ҳ�ǻ�����
base = layer{1};
L{1} = bwlabel(base);                           %��ǻ����������
D = regionprops(L{1},'Centroid','Boundingbox','MajorAxisLength');                %���������������
Centorid = cat(1, D.Centroid); 
Boundingbox = cat(1, D.BoundingBox);
for i = 2:numlayer
    layer{i} = Im < thresh(i) & Im >= thresh(i - 1);    %����ÿһ��㣬������������ֵ֮��ĵ�
    L{i} = bwlabel(layer{i});                           %���ÿһ�������
    D = regionprops(L{i},'Centroid');                   %���������������
    Centoridnew = cat(1, D.Centroid);                   %��һ�������
    layertemp = zeros(size(Im));
    for k = 1:size(Centoridnew,1)                        %�����һ��ĵ����������������Ͻ���������е㵽������
        for j = 1:size(Centorid,1)
            if norm(Centoridnew(k,:) - Centorid(j,:)) <= 2*max(Boundingbox(j,3),Boundingbox(j,4))
                layertemp(L{i} == k) = 1;
                break;
            end
        end
    end
    base = base + layertemp;                            %���»�����
    L{1} = bwlabel(base);                           %��ǻ����������
    D = regionprops(L{1},'Centroid','Boundingbox','MajorAxisLength');               %���������������
    Centorid = cat(1, D.Centroid);
    Boundingbox = cat(1, D.BoundingBox);
end
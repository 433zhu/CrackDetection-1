function output = CrackSearch(input,Im)
[M,N] = size(input);
output = input;
[L,num] = bwlabel(input);
R = 10;
count = 0;
for i = 1:num
    % ���ҵ�һ���ѷ�㣨���ϣ�
    [x,y] = find(L == i,1);
    while x - R > 0  && y - R > 0 && x + R <= M && y + R <= N
        % ���ѷ��Ϊ���Ļ��ֳ�block
        subblock = Im(x - R:x + R,y - R:y + R);
        % ���block����ֵ��Ϣ
        meanblock = imfilter(subblock, 1/100 * ones(10,10));
        bwtemp = subblock < 0.66 * meanblock;
        % ͨ����ֵ�õ��µĶ�ֵblock
        outtemp = output(x - R:x + R,y - R:y + R) | bwtemp;
        if sum(sum(outtemp - output(x - R:x + R,y - R:y + R))) == 0
            break;
        else
            % ����µĶ�ֵblock���������ص㣬��Ѷ˵��λ������Ϊ�µ����ģ��ظ����ϲ���
%             figure;
%             imshow(pixeldup(subblock,8));
%             figure;
%             imshow(output(x - R:x + R,y - R:y + R));
%             figure;
%             imshow(outtemp);
%             if count == 0
%                 imwrite(pixeldup(subblock,8), 'subblock.png', 'png');
%                 imwrite(pixeldup(output(x - R:x + R,y - R:y + R),8), 'outpre.png', 'png');
%                 imwrite(pixeldup(outtemp,8), 'outpost.png', 'png');
%             end
            output(x - R:x + R,y - R:y + R) = outtemp;
            [x1,y1] = find(outtemp,1);
            x = x1 + x - R;
            y = y1 + y - R;
%             if count == 0
%                 imwrite(pixeldup(output(x - R:x + R,y - R:y + R),8), 'outnext.png', 'png');
%                 count = count + 1;
%             end
%             figure;
%             imshow(output(x - R:x + R,y - R:y + R));
        end
    end
    [x,y] = find(L == i,1,'last');
    while x - R > 0  && y - R > 0 && x + R <= M && y + R <= N
        subblock = Im(x - R:x + R,y - R:y + R);
        meanblock = imfilter(subblock, 1/100 * ones(10,10));
        bwtemp = subblock < 0.66 * meanblock;
        outtemp = output(x - R:x + R,y - R:y + R) | bwtemp;
        if sum(sum(outtemp - output(x - R:x + R,y - R:y + R))) == 0
            break;
        else
            output(x - R:x + R,y - R:y + R) = outtemp;
            [x1,y1] = find(outtemp,1,'last');
            x = x1 + x - R;
            y = y1 + y - R;
        end
    end
end
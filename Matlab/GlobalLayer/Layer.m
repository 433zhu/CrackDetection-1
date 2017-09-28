function thresh = Layer(Im)
iter = 6;                                       %��������
numlayer = 5;                                   %ʹ�ò���
thresh = zeros(1,iter);                         
thresh(1) = graythresh(Im);                     %ȡȫ����ֵ��Ϊ��ʼֵ
Imtemp = Im;
for redo = 1:iter                               %������ֵ����
    bw = Imtemp > thresh(redo);                 %��ֵ��
    Imtemp(bw) = thresh(redo);                  %����ֵȡ��������ֵ������
    thresh(redo + 1) = graythresh(Imtemp);      %��ȡȫ����ֵ
end
thresh = fliplr(thresh);                        %ˮƽ��תthresh����
thresh = thresh(1:numlayer);                    %ȡǰ�漸����Ϊ�о�����Ϊ��ԭʼȫ����ֵʱ�Ѿ���������
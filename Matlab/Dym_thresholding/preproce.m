function result = preproce(Im)
%% ȥ�������ȱ���
A=imresize(Im,[256 256]);
blocks=blkproc(A,[32,32],@estibackground);%�ֿ鴦��
background=imresize(blocks,size(Im),'bilinear');%˫���Բ�ֵ��������
A=imresize(A,size(Im));
A=imsubtract(A,background); %У����

%% ��ǿ�Աȶ�
Im = A;
Itop = imtophat(Im,strel('disk',15));           %��ñ�任
Ibottom = imbothat(Im,strel('disk',15));        %��ñ�任
Im = Itop - Ibottom;                            %��ñ���ñ֮�����ǿ�Աȶ�
result = Im + abs(min(min(Im)));                %��ǿ�Աȶ�ͼ��ƫ��������Ҷ�����ƫ��
function output = postproce(base,Im)
output = base;

%% ����Բ��ָ����ĺ����С����ͨ��
output = FinalFilter(output);
output = bwareaopen(output,50);

%% �����߽�����
output(:,1:5) = 0;
output(:,end-4:end) = 0;
output(1:5,:) = 0;
output(end-4:end,:) = 0;

%% �Ե�ǰ�ѷ�Ϊ��׼��������ֵ�����������
output = CrackSearch(output,Im);

%% ��̬ѧ�����������Ӻ�����С������������õ��Ĵ�������
output = bwmorph(output,'bridge',Inf);
output = imclose(output,strel('disk',2));
output = bwareaopen(output,10);
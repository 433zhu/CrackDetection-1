%imfreqfilt����    �ԻҶ�ͼ�����Ƶ���˲�
%����I             �����ʱ��ͼ��
%����ff            Ӧ�õ���ԭͼ��ȴ��Ƶ���˾�
%�ú����ο�����ͨMATLAB����ͼ������ʶ�𡷵�����
function out=imfreqfilt(I,ff)
if((ndims(I)==3)&&size(I,3)==3)
    I=rbg2gray(I);
end
f=fft2(double(I));
s=fftshift(f);
out=s.*ff;
out=ifftshift(out);
out=ifft2(out);
out=abs(out);
out=out/max(out(:));

%file:SaveSpace.m
%������ͼ���Կ�Ϊ��λ�����ڿռ������Ϊ���ܺ�����ص������ڿռ�׼��
function embed_image = SaveSpace( origin , blocksize )

[M,N] = size(origin);
number = (M*N)/blocksize;


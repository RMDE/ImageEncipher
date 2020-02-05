%file:SaveSpace.m
%对整个图像以块为单位进行腾空间操作，为加密后的像素调整做腾空间准备
function embed_image = SaveSpace( origin , blocksize )

[M,N] = size(origin);
number = (M*N)/blocksize;


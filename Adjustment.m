%file: Adjustment.m
%to adjust the MSB of pixel in adjustment area in order to keep the Thumbnail the same
%origin: the image after saving space and encipher progress
%value: store the average pixel in every block of the original image
%MSB: the number of every bit in adjustment area used for adjustment
function AjImage = Adjustment( origin , blocksize , value , MSB)

A = origin;
[M,N] = size(origin);
m = M/blocksize;
n = N/blocksize;
for i = 1 : m
    for j = 1 : n
        x = (i-1)*blocksize+1;
        y = (j-1)*blocksize+1;
        AjImage = Adjust(AjImage,blocksize,x,y,MSB,value(i,j));
    end
end

end
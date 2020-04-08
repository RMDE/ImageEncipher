 %file: Adjustment.m
%to adjust the MSB of pixel in adjustment area in order to keep the Thumbnail the same
%origin: the image after saving space and encipher progress
%value: store the average pixel in every block of the original image
%MSB: the number of every bit in adjustment area used for adjustment
function AjImage = Adjustment( origin , blocksize , value , MSB)

AjImage = origin;
[M,N] = size(AjImage);
m = M/blocksize;
n = N/blocksize;
sum = 0;
for i = 1 : m
    for j = 1 : n
        x = (i-1)*blocksize+1;
        y = (j-1)*blocksize+1;
        [AjImage,x] = Adjust(AjImage,blocksize,x,y,MSB,value(i,j));
        sum = sum+x;
    end
end
sum

end
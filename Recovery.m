%file: Recovery.m
%to recover the image 
%origin: the image after decipher progress
%blocksize: size of block
%MSB: the number of every bit in adjustment area used for adjustment
function ReImage = Recovery( origin , blocksize , MSB )

ReImage = origin;
[M,N] = size(origin);
m = M/blocksize;
n = N/blocksize;
for i = 1 : m
    for j = 1 : n
        x = (i-1)*blocksize+1;
        y = (j-1)*blocksize+1;
        ReImage = Extraction(ReImage,blocksize,MSB);
    end
end


end
%file:SaveSpace.m
%save the MSB of adjustment area pixel in order to adjust
%origin: original image    blocksize: size of block
%MSB: the number of every bit in adjustment area used for adjustment
%count: the max number of elements in EN1
function [embed_image,Cap,DATA] = reserve( origin , blocksize , MSB , count, bits)

embed_image = origin;
[M,N] = size(origin);
m = M/blocksize;
n = N/blocksize;
DATA = [];%store the all message of every block to embedding
Cap = 0;

%collecting the embedding message
for i = 1 : m
    for j = 1 : n
        x = (i-1)*blocksize+1;
        y = (j-1)*blocksize+1;
        [data,embed_image,capacity] = Embed1(embed_image,blocksize,x,y,MSB,count);
        [~,l] = size(DATA);
        [~,len] = size(data);
        DATA(l+1:l+len) = data(1:len);
        Cap = Cap + capacity;
    end
end

%embedding the data to the whole image
index = 1;
[~,len] = size(DATA)

end

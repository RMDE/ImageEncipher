%file:SaveSpace.m
%save the MSB of adjustment area pixel in order to adjust
%origin: original image    blocksize: size of block
%MSB: the number of every bit in adjustment area used for adjustment
%count: the max number of elements in EN1
function embed_image = SaveSpace( origin , blocksize , MSB , count)

embed_iamge = origin;
[M,N] = size(origin);
m = M/blocksize;
n = N/blocksize;
for i = 1 : m
    for j = 1 : n
        x = (i-1)*blocksize+1;
        y = (j-1)*blocksize+1;
        embed_image = Embedding(embed_image,blocksize,x,y,MSB,count);
    end
end


end

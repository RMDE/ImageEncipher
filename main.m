%file: main.m
%%the main function of the project
origin = imread("original.jpg");
[M,N] = size(origin);

blocksize = 16;
MSB = 1;
count = 78;
key = 1;


m = M/blocksize;
n = N/blocksize;
values = [];%store the original average pixel of every block
t = 1;%means the length+1 of values
for i = 1 : m
    for j = 1 : n
        sub = origin(i:blocksize-1,j:blocksize-1);
        value(t) = mean2(sub);
        t = t+1;
    end
end
embed_image = SaveSpaec( origin , blocksize , MSB , count)
AjImage = Adjustment( embed_image , values , MSB)
EnImage = Encipher( AjImage , key ) %encipher
DeImage = Encipher( EnImage , key ) %decipher
ReImage = Recovery( DeImage , blocksize , MSB ) 
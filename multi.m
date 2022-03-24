% file: multi-embed.m
% multi data hiding by DE
origin = imread("original.png",'png');
[M,N] = size(origin);
blocksize = 8;
MSB = 2;
count = 20000;
key = 1;
m = M/blocksize;
n = N/blocksize;
values = zeros(m,n);%store the original average pixel of every block
sub1 = zeros(blocksize);
sub2 = zeros(blocksize);
sub3 = zeros(blocksize);
for i = 1 : m
    for j = 1 : n
        x = (i-1)*blocksize+1;
        y = (j-1)*blocksize+1;
        sub1(1:blocksize,1:blocksize) = origin(x:x+blocksize-1,y:y+blocksize-1);
        values(i,j) = mean2(sub1);
    end 
end
tic

bits = Select(origin,blocksize,MSB);

[~,length] = size(bits);
index = 1;
while index <= length
    [embed_image,cap,DATA] = reserve( origin , blocksize , MSB , count, bits);
    [~,l] = size(DATA);
    index2 = index+(cap-l);
    if index2 > length
        index2 = length;
    end
    data = [];
    [~,x] = size(DATA);
    data(1:x) = DATA(:);
    data(x+1:x+index2-index+1) = bits(index:index2);
    embed_image = Room(embed_image,blocksize,data);
    index = index2+1;
end
EnImage = Encipher( embed_image , key); %encipher
[AjImage,s] = Adjustment( EnImage , blocksize , values , MSB);
toc
DeImage = Encipher( AjImage , key); %decipher
ReImage = Recover( DeImage , blocksize , MSB);
imwrite(AjImage,"reserve.png","png");

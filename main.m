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
values = zeros(m,n);%store the original average pixel of every block
sub = zeros(blocksize);
for i = 1 : m
    for j = 1 : n
        sub(1:blocksize,1:blocksize) = origin(i:i+blocksize-1,j:j+blocksize-1);
        values(i,j) = mean2(sub);
    end 
end

embed_image = SaveSpace( origin , blocksize , MSB , count);
EnImage = Encipher( embed_image , key ); %encipher
AjImage = Adjustment( EnImage , blocksize , values , MSB);
DeImage = Encipher( AjImage , key ); %decipher
ReImage = Recovery( DeImage , blocksize , MSB );
imwrite(AjImage,'result.png','png');
imwrite(ReImage,'recover.png','png');


rev_origin = origin;
rev_adj = origin;

res_values = zeros(m,n);%store the original average pixel of every block
for i = 1 : m
    for j = 1 : n
        sub(1:blocksize,1:blocksize) = AjImage(i:i+blocksize-1,j:j+blocksize-1);
        res_values(i,j) = mean2(sub);
%         rev_adj(i:i+blocksize-1,j:j+blocksize-1) = uint8(res_values(i,j));
%         rev_origin(i:i+blocksize-1,j:j+blocksize-1) = uint8(values(i,j));
    end 
end

% imwrite(rev_origin,'rev_origin.png','png');
% imwrite(rev_adj,'rev_adj.png','png');

%caculate the difference between origin image and AjImage
sum = double(0);
for i = 1 : m
    for j = 1 : n
        t = abs(res_values(i,j)-values(i,j))/values(i,j);
        sum = sum+t;
    end
end
difference = sum/(m*n)



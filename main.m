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
t = 1;%means the length+1 of values
for i = 1 : m
    for j = 1 : n
        sub = origin(i:blocksize-1,j:blocksize-1);
        values(i,j) = mean2(sub);
        t = t+1;
    end 
end
embed_image = SaveSpace( origin , blocksize , MSB , count);
EnImage = Encipher( embed_image , key ); %encipher
AjImage = Adjustment( EnImage , blocksize , values , MSB);
DeImage = Encipher( AjImage , key ); %decipher

origin(81:96,49:64)
DeImage(81:96,49:64)

ReImage = Recovery( DeImage , blocksize , MSB );


origin(1:16,1:16)
% embed_image(1:16,1:16)
% EnImage(1:16,1:16)
% AjImage(1:16,1:16)
% DeImage(1:16,1:16)
ReImage(1:16,1:16)
% subplot(1,3,1);
% imshow(origin);
% title('original image');
% subplot(1,3,2);
% imshow(AjImage);
% title('after adjustment');
 imwrite(AjImage,'result.png','png');
% subplot(1,3,3);
% imshow(ReImage);
 imwrite(ReImage,'recover.png','png');


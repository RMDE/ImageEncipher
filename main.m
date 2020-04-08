%file: main.m
%%the main function of the project
origin = imread("original.jpg");
[M,N] = size(origin);
blocksize = 16;
MSB = 1;
count = 20000;
key = 1;
m = M/blocksize;
n = N/blocksize;
values = zeros(m,n);%store the original average pixel of every block
sub = zeros(blocksize);
for i = 1 : m
    for j = 1 : n
        x = (i-1)*blocksize+1;
        y = (j-1)*blocksize+1;
        sub(1:blocksize,1:blocksize) = origin(x:x+blocksize-1,y:y+blocksize-1);
        values(i,j) = mean2(sub);
    end 
end


embed_image = SaveSpace( origin , blocksize , MSB , count);
EnImage = Encipher( embed_image , key ); %encipher
AjImage = Adjustment( EnImage , blocksize , values , MSB);
DeImage = Encipher( AjImage , key ); %decipher
ReImage = Recovery( DeImage , blocksize , MSB );
imwrite(EnImage,"cipher.png",'png');
imwrite(AjImage,'result.png','png');
imwrite(ReImage,'recover.png','png');

% res_values = zeros(m,n);%store the original average pixel of every block
% for i = 1 : m
%     for j = 1 : n
%         x = (i-1)*blocksize+1;
%         y = (j-1)*blocksize+1;
%         sub(1:blocksize,1:blocksize) = AjImage(x:x+blocksize-1,y:y+blocksize-1);
%         res_values(i,j) = mean2(sub);
%     end 
% end
% 
% 
% %caculate the difference between origin image and AjImage
% sum = double(0);
% for i = 1 : m
%     for j = 1 : n
%         t = abs(res_values(i,j)-values(i,j))/values(i,j);
%         sum = sum+t;
%     end
% end
% difference = sum/(m*n)



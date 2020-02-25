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
for i = 1 : m
    for j = 1 : n
        sub = origin(i:i+blocksize-1,j:j+blocksize-1);
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

res_values = zeros(m,n);%store the original average pixel of every block
for i = 1 : m
    for j = 1 : n
        sub = AjImage(i:i+blocksize-1,j:j+blocksize-1);
        res_values(i,j) = mean2(sub);
    end 
end

%caculate the difference between origin image and AjImage
sum = double(0);
for i = 1 : m
    for j = 1 : n
        t = abs(res_values(i,j)-values(i,j))/values(i,j);
        sum = sum+t;
    end
end
difference = sum/(m*n)

%generate the trump
% values = image(values);
% res_values = image(res_values);
% imwrite(values,'rev_origin.png','png');
% imwrite(res_values,'rev_result.png','png');

%file: apple.m
%%to encrypt the apple image
whole = imread("apple.png","png");
[M,N,C] = size(whole);
blocksize = 32;
MSB = 1;
count = 20000;
key = 1;
m = M/blocksize;
n = N/blocksize;
values = zeros(m,n);%store the original average pixel of every block
sub1 = zeros(blocksize);
result1 = whole;
result2 = whole;
for chanal = 1 : C
    origin = whole(:,:,chanal);
for i = 1 : m
    for j = 1 : n
        x = (i-1)*blocksize+1;
        y = (j-1)*blocksize+1;
        sub1(1:blocksize,1:blocksize) = origin(x:x+blocksize-1,y:y+blocksize-1);
        values(i,j) = mean2(sub1);
    end 
end

embed_image = SaveSpace( origin , blocksize , MSB , count);
EnImage = Encipher( embed_image , key); %encipher
[AjImage,s] = Adjustment( EnImage , blocksize , values , MSB);
whole(:,:,chanal) = AjImage(:,:,1);
end
imwrite(whole,"apple-res.png","png");

for chanal = 1 : C
for i = 1 : m
        for j = 1 : n
            x = (i-1)*blocksize+1;
            y = (j-1)*blocksize+1;
            sub1(1:blocksize,1:blocksize) = whole(x:x+blocksize-1,y:y+blocksize-1,chanal);
            value1 = mean2(sub1);
            for p = x : x+blocksize-1
                for q = y : y+blocksize-1
                    result1(p,q,chanal) = value1;
                end
            end
        end 
end
end
imwrite(result1,"thumbnail.png","png");

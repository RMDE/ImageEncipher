%file:Embedding.m
%function: transfer the pmg image into gray png image with suitable size
SamplePath1 =  "D:\Project\detection\ori\";  %存储图像的路径
blocksize = 16;
MSB = 1;
xxx = "16x16,1"
count = 20000;
key = 1;
%遍历路径下每一幅图像
for photo=1:1000
    filename = strcat(SamplePath1,num2str(photo),".png")
    origin = imread(filename,'png');
    [M,N] = size(origin);
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

    embed_image = SaveSpace( origin , blocksize , MSB , count);
    EnImage = Encipher( embed_image , key); %encipher
    [AjImage,s] = Adjustment( EnImage , blocksize , values , MSB);
    name = strcat("D:\Project\detection\",xxx,"\res\",num2str(photo),".png");
    imwrite(AjImage,char(name),'png');

    result1 = origin;
    result2 = origin;
    % result3 = origin;
    for i = 1 : m
        for j = 1 : n
            x = (i-1)*blocksize+1;
            y = (j-1)*blocksize+1;
            sub1(1:blocksize,1:blocksize) = AjImage(x:x+blocksize-1,y:y+blocksize-1);
            sub2(1:blocksize,1:blocksize) = origin(x:x+blocksize-1,y:y+blocksize-1);
            value1 = mean2(sub1);
            value2 = mean2(sub2);
            for p = x : x+blocksize-1
                for q = y : y+blocksize-1
                    result1(p,q) = value1;
                    result2(p,q) = value2;
                end
            end
        end 
    end
    name1 = strcat("D:\Project\detection\",xxx,"\ori-th\",num2str(photo),".png");
    name2 = strcat("D:\Project\detection\",xxx,"\res-th\",num2str(photo),".png");
    imwrite(result1,char(name2),'png');
    imwrite(result2,char(name1),'png');
    % imwrite(result3,"cipher-th.png","png");
end
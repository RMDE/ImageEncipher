for no = 1 : 18
    name = strcat("gray\",num2str(no),".png")
    origin = imread(name,"png");
    [M,N] = size(origin);
    blocksize = 16;
    MSB = 2;
    count = 3000000;
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
    [AjImage,s] = Adjustment( EnImage , blocksize , values , MSB);
%     origin = imresize(origin,[768,1024]);
%     if (size(size(origin))== [1,3])
%         origin = rgb2gray(origin);
%         size(origin)
%     end
%     imwrite(origin,strcat("gray\",num2str(no),".png"),"png");
    imwrite(AjImage,strcat("gray-res\",num2str(no),".png"),"png");
end
sum = double(0);
for mm =1:50
    a='origin\body\';
    b=".jpg";
    c=num2str(mm);
    name=strcat(a,c,b);
    origin=imread(name,"jpg");
    
    a='origin\body\';
    b=".png";
    c=num2str(mm);
    res=strcat(a,c,b);
    imwrite(origin,res,'png');
    
end

% for photo = 1:28
%     name = strcat("eva\",num2str(photo),".png");
%     whole=imread(name,"png");
%     res = whole;
%     [M,N,C] = size(whole);
%     blocksize = 16;
%     MSB = 2;
%     count = 20000;
%     key = 1;
%     m = M/blocksize;
%     n = N/blocksize;
%     values = zeros(m,n);%store the original average pixel of every block
%     origin = whole(:,:,1);
%     sub = zeros(blocksize);
%     for channel = 1 : C
%         origin(:,:,1) = whole(:,:,channel);
%         for i = 1 : m
%             for j = 1 : n
%                 x = (i-1)*blocksize+1;
%                 y = (j-1)*blocksize+1;
%                 sub(1:blocksize,1:blocksize) = origin(x:x+blocksize-1,y:y+blocksize-1);
%                 values(i,j) = mean2(sub);
%             end 
%         end
%         embed_image = SaveSpace( origin , blocksize , MSB , count);
%         EnImage = Encipher( embed_image , key); %encipher
%         [AjImage,s] = Adjustment( EnImage , blocksize , values , MSB);
%         res(:,:,channel) = AjImage(:,:,1);
%     end
%     imwrite(res,strcat("ave\",num2str(photo),".png"),'png');
% end
%file: main.m
%%the main function of the project
origin = imread("original.png",'png');
[M,N] = size(origin);
blocksize = 16;
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
embed_image = SaveSpace( origin , blocksize , MSB , count);
EnImage = Encipher( embed_image , key); %encipher
[AjImage,s] = Adjustment( EnImage , blocksize , values , MSB);
toc
DeImage = Encipher( AjImage , key); %decipher
ReImage = Recovery( DeImage , blocksize , MSB);
for i = 1 : 1 : M
    for j = 1 : 1 : N
        if origin(i,j) ~= ReImage(i,j)
            i,j
            break;
        end
    end
end
imwrite(embed_image,"room.png","png");
imwrite(EnImage,"cipher.png",'png');
imwrite(AjImage,"result.png",'png');
imwrite(DeImage,"decipher.png","png");
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
% %caculate the difference between origin image and AjImage
% sum = 0;
% for i = 1 : m
%     for j = 1 : n
%         t = abs(res_values(i,j)-values(i,j));
%         if t <= 5
%             sum = sum+1;
%         end
%     end
% end
% % difference = sum/(m*n)
% result1 = origin;
% result2 = origin;
% % result3 = origin;
% for i = 1 : m
%         for j = 1 : n
%             x = (i-1)*blocksize+1;
%             y = (j-1)*blocksize+1;
%             sub1(1:blocksize,1:blocksize) = AjImage(x:x+blocksize-1,y:y+blocksize-1);
%             sub2(1:blocksize,1:blocksize) = origin(x:x+blocksize-1,y:y+blocksize-1);
%             sub3(1:blocksize,1:blocksize) = EnImage(x:x+blocksize-1,y:y+blocksize-1);
%             value1 = mean2(sub1);
%             value2 = mean2(sub2);
%             value3 = mean2(sub3);
%             for p = x : x+blocksize-1
%                 for q = y : y+blocksize-1
%                     result1(p,q) = value1;
%                     result2(p,q) = value2;
% %                     result3(p,q) = value3;
%                 end
%             end
%         end 
%     end
% imwrite(result1,"thumbnail.png",'png');
% imwrite(result2,"origin-th.png",'png');
% imwrite(result3,"cipher-th.png","png");


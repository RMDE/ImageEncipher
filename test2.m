% % x = imread("origin-th.png","png");
% % y = imread("thumbnail.png","png");
% % [M,N] = size(x);
% % dif = double(0);
% % for i = 1:M
% %     for j = 1:N
% %         p = double(x(i,j));
% %         q = double(y(i,j));
% %         s = double(abs(p-q));
% %         dif = dif + s/double(x(i,j));
% %     end
% % end
% % dif = dif/double((M*N))
% 
% %file: main.m
% %%the main function of the project
% whole = imread("apple.png","png");
% [M,N,C] = size(whole);
% blocksize = 32;
% MSB = 2;
% count = 20000;
% key = 1;
% m = M/blocksize;
% n = N/blocksize;
% values = zeros(m,n);%store the original average pixel of every block
% sub1 = zeros(blocksize);
% sub2 = zeros(blocksize);
% for chanal = 1 : C
%     origin = whole(:,:,chanal);
% for i = 1 : m
%     for j = 1 : n
%         x = (i-1)*blocksize+1;
%         y = (j-1)*blocksize+1;
%         sub1(1:blocksize,1:blocksize) = origin(x:x+blocksize-1,y:y+blocksize-1);
%         values(i,j) = mean2(sub1);
%     end 
% end
% 
% embed_image = SaveSpace( origin , blocksize , MSB , count);
% EnImage = Encipher( embed_image , key); %encipher
% [AjImage,s] = Adjustment( EnImage , blocksize , values , MSB);
% whole(:,:,chanal) = AjImage(:,:);
% end
% imwrite(whole,"apple-res.png","png");
% 
% 


% Img=imread('dream\dream-.png');
% BW = Img;
% R=BW(:,:,1);
% [REDcounts,x] = imhist(R);
% G=BW(:,:,2);
% [Greencounts,y] = imhist(R);
% B=BW(:,:,3);
% [Bluecounts,z] = imhist(R);
% figure;
% subplot(131);imhist(R);title('Red');
% subplot(132);imhist(G);title('Green');
% subplot(133);imhist(B);title('Blue');

%file: main.m
%%the main function of the project
for pic = 1:20
whole = imread(strcat("temp\",num2str(pic),".jpeg"),"jpeg");
[M,N,C] = size(whole);
blocksize = 16;
MSB = 2;
count = 20000;
key = 1;
m = M/blocksize;
n = N/blocksize;
values = zeros(m,n);%store the original average pixel of every block
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
whole(:,:,chanal) = AjImage(:,:);
end

imwrite(whole,strcat("temp\res-",num2str(pic),".png"),"png");
end

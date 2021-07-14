origin = imread("dec-sub1.png","png");
subimg = imread("me.png","png");
[M,N] = size(origin);
blocksize = 128;
imresize(subimg,[blocksize,blocksize]);
size(subimg)
MSB = 2;
for i = 1 :32
    for j = 1 :32
        for x = i*4-3 : i*4
            for y = j*4-3 : j*4
                subimg(x,y) = origin(i,j);
            end
        end
        
%         subimg(i,j) = origin(blocksize*2+i,j);
%         subimg(i,j) = origin(M-blocksize*1+i,N-blocksize+j);
    end
end
imwrite(subimg,"dec-sub1(b).png","png");
% ori = imread("dec-sub6.png","png");
% value = ori(1,1);
% [M,N] = size(ori);
% for i = 1 : M
%     ori(i,2) = unifrnd (0,255);
%     ori(i,N-1) = unifrnd (0,255);
% end
% for i = 1 : N
%     ori(2,i) = unifrnd (0,255);
%     ori(M-1,i) = unifrnd (0,255);
% end
% imwrite(ori,"dec-sub6.png","png");
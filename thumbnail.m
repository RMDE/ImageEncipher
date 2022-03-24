% for photo = 1:28
%     name = strcat("eva\flower(64,2)",".png");
%     origin = imread(name,"png");
%     [M,N,C] = size(origin);
%     blocksize = 64;
%     m = M/blocksize;
%     n = N/blocksize;
%     values = 0;%store the original average pixel of every block
%     sub = zeros(blocksize);
%     result = origin;
%     for channel = 1 : C
%         for i = 1 : m
%             for j = 1 : n
%                 x = (i-1)*blocksize+1;
%                 y = (j-1)*blocksize+1;
%                 sub(1:blocksize,1:blocksize) = origin(x:x+blocksize-1,y:y+blocksize-1,channel);
%                 values = mean2(sub);
%                 for p = x : x+blocksize-1
%                     for q = y : y+blocksize-1
%                         result(p,q,channel) = values;
%                     end
%                 end
%             end 
%         end
%     end
%     res = strcat("eva/t-flower(64,2)",".png");
%     imwrite(result,res,'png');
% end


blocksize = 8;
sum = double(0);
difference = double(0);
str = ['head\','bust\','body\'];
for subx = 2:2
    a1 = 'origin\';
    a1 = strcat(a1,str(subx*5+1:(subx+1)*5));
    a2 = 'thumbnail\';
    a2 = strcat(a2,str(subx*5+1:(subx+1)*5));
for mm =1:60
    b=".png";
    c=num2str(mm);
    name=strcat(a1,c,b);
    origin=imread(name,"png");
    [M,N] = size(origin);
    m = M/blocksize;
    n = N/blocksize;
    sub = zeros(blocksize);
    result = origin;
    for i = 1 : m
        for j = 1 : n
            x = (i-1)*blocksize+1;
            y = (j-1)*blocksize+1;
            sub(1:blocksize,1:blocksize) = origin(x:x+blocksize-1,y:y+blocksize-1);
            values = mean2(sub);
            for p = x : x+blocksize-1
                for q = y : y+blocksize-1
                    result(p,q) = values;
                end
            end
        end 
    end
    b=".png";
    c=num2str(mm);
    res=strcat(a2,c,b);
    imwrite(result,res,'png');
end
end

sum = double(0);
difference = double(0);
str = ['head\','bust\','body\'];
for subx = 2:2
    a1 = 'result\';
    a1 = strcat(a1,str(subx*5+1:(subx+1)*5));
    a2 = 'result2\';
    a2 = strcat(a2,str(subx*5+1:(subx+1)*5));
for mm =1:60
    b=".png";
    c=num2str(mm);
    name=strcat(a1,c,b);
    origin=imread(name,"png");
    [M,N] = size(origin);
    m = M/blocksize;
    n = N/blocksize;
    sub = zeros(blocksize);
    result = origin;
    for i = 1 : m
        for j = 1 : n
            x = (i-1)*blocksize+1;
            y = (j-1)*blocksize+1;
            sub(1:blocksize,1:blocksize) = origin(x:x+blocksize-1,y:y+blocksize-1);
            values = mean2(sub);
            for p = x : x+blocksize-1
                for q = y : y+blocksize-1
                    result(p,q) = values;
                end
            end
        end 
    end
    b=".png";
    c=num2str(mm);
    res=strcat(a2,c,b);
    imwrite(result,res,'png');
end
end
% 
% sum = double(0);
% difference = double(0);
% str = ['head\','bust\','body\'];
% level = double(0);
% level2 = double(0);
% for subx = 2:2
%     a1 = 'thumbnail\';
%     a1 = strcat(a1,str(subx*5+1:(subx+1)*5));
%     a2 = 'result2\';
%     a2 = strcat(a2,str(subx*5+1:(subx+1)*5));
% for mm =1:60
%     b=".png";
%     c=num2str(mm);
%     name=strcat(a1,c,b);
%     x=imread(name,"png");
%     name2=strcat(a2,c,b);
%     y=imread(name2,"png");
%     level = level + ssim(x,y);
%     level2 = level2 + psnr(x,y);
% %     [M,N] = size(x);
% %     dif = double(0);
% %     for i = 1:M
% %         for j = 1:N
% %             p = double(x(i,j));
% %             q = double(y(i,j));
% %             s = double(abs(p - q));
% %             if( p == 0 )
% % %                 p = 1;
% %                 continue;
% %             end
% %             dif = dif + s/double(p);
% %         end
% %     end
% %     dif = dif/double(M*N);
% %     level = level + dif;
% end
% end
% level = level/60.0
% level2 = level2/60.0

% whole = imread("flower.png","png");
% [M,N,C] = size(whole);
% blocksize =16;
% MSB = 2;
% count = 20000;
% key = 1;
% m = M/blocksize;
% n = N/blocksize;
% values = zeros(m,n);%store the original average pixel of every block
% sub1 = zeros(blocksize);
% sub2 = zeros(blocksize);
% result1 = whole;
% for chanal = 1:C
% for i = 1 : m
%         for j = 1 : n
%             x = (i-1)*blocksize+1;
%             y = (j-1)*blocksize+1;
%             sub1(1:blocksize,1:blocksize) = whole(x:x+blocksize-1,y:y+blocksize-1,chanal);
%             value1 = mean2(sub1);
%             for p = x : x+blocksize-1
%                 for q = y : y+blocksize-1
%                     result1(p,q,chanal) = value1;
%                 end
%             end
%         end 
% end
% end
% imwrite(result1,"thumbnail.png","png");
% % imwrite(result1,"ave.png","png");
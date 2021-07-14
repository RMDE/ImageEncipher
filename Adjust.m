%file: Adjust.m
%to adjust the MSB of pixel in adjustment area in order to keep the Thumbnail the same
%origin: the image after saving space and encipher progress
%(x,y): the start location of block
%value: store the average pixel in every block of the original image
%MSB: the number of every bit in adjustment area used for adjustment
function [AjImage,success] = Adjust(origin,blocksize,x,y,MSB,value)

%first: calculate the low (8-MSB) bit of all pixel --> sum 
%store the all adjustment area location in locationx and locationy
AjImage = origin;
success = 1;
locationx = [];
locationy = [];
len = 1;
success=0;
locationx(len:len+blocksize-1) = x:x+blocksize-1;
locationy(len:len+blocksize-1) = y;
len = len+blocksize;
locationx(len:len+blocksize-1) = x:x+blocksize-1;
locationy(len:len+blocksize-1) = y+blocksize-1;
len = len+blocksize;
locationx(len:len+blocksize-3) = x;
locationy(len:len+blocksize-3) = y+1:y+blocksize-2;
len = len+blocksize-2;
locationx(len:len+blocksize-3) = x+blocksize-1;
locationy(len:len+blocksize-3) = y+1:y+blocksize-2;
len = len+blocksize-3;
sub = origin(x+1:x+blocksize-2,y+1:y+blocksize-2);
Sum = double(sum(sub(:)));
for i = 1 : len
    t = Calcu(origin(locationx(i),locationy(i)),MSB);
    Sum = Sum+double(t);
end
[~,limit] = size(locationx);
for i = 1 : limit
    AjImage(locationx(i),locationy(i)) = Calcu(origin(locationx(i),locationy(i)),MSB);
end
diff = blocksize*blocksize*value - Sum;
if diff < 0
    return ;
end
number = Generate(MSB);
[~,count] = size(number);
chan = zeros(1,count);
for i = 1 : count
    res = floor(diff / number(i));
    if res > limit
        res = limit;
    end
    chan(i) = res;
    diff = diff - res * number(i);
    if diff < 0
        break;
    end 
end

for j = 1 : count
    for i = 1 : chan(j)
        AjImage(locationx(i),locationy(i));
        AjImage(locationx(i),locationy(i)) = AjImage(locationx(i),locationy(i)) + number(j);
        AjImage(locationx(i),locationy(i));
    end
end
sub = AjImage(x:x+blocksize-1,y:y+blocksize-1);
s = double(sum(sub(:)));
difference = abs(s-blocksize*blocksize*value);
end


% %second: calculate the difference between 'current' and blocksize*blocksize*value
% number = Generate(MSB);
% difference = blocksize*blocksize*value-Sum %generally the former must bigger than the later
% 
% %third: search to find the perfect result
% if difference<number(1)
%     for i = 1 :len
%         AjImage(locationx(i),locationy(i)) = Calcu(origin(locationx(i),locationy(i)),MSB);
%     end
%     return;
% end
% [~,count] = size(number);
% num = zeros(1,count);%store the number of every value in number
% state = 0; 
% if count == 1
%     for p = 1 : len
%         s = Sum+number(1)*p;
%         difference = abs(s-blocksize*blocksize*value);
%         if difference < number(1)/2 
%             num(1) = p;
%             state = 1;
%             break;
%         end
%     end
%     if state == 0
%         num(1) = 4*blocksize-4;
%         s= Sum+number(1)*(4*blocksize-4);
%     end
%     for i = 1 : num(1)
%         AjImage(locationx(i),locationy(i))=Calcu(origin(locationx(i),locationy(i)),MSB)+number(1);
%     end
%     for i = num(1)+1 : len
%        AjImage(locationx(i),locationy(i))=Calcu(origin(locationx(i),locationy(i)),MSB);
%     end 
% elseif count == 3
%     for p = len : -1 : 0
%         for q = len-p : -1 : 0
%             for r = len-p-q : -1 : 0
%                 s = Sum+number(1)*p+number(2)*q+number(3)*r;
%                 difference = abs(s-blocksize*blocksize*value);
%                 if difference < number(1)
%                     num(1) = p;
%                     num(2) = q;
%                     num(3) = r;
%                     state = 1;
%                     break;
%                 end
%             end
%             if state == 1
%                 break;
%             end
%         end
%         if state == 1
%             break;
%         end
%     end
%     if state == 0
%         num(1) = 0;
%         num(2) = 0;
%         num(3) = 4*blocksize-4;
%         s = Sum+number(3)*(4*blocksize-4);
%     end
%     for i = 1 : num(1)
%         AjImage(locationx(i),locationy(i)) = uint8(Calcu(origin(locationx(i),locationy(i)),MSB)+number(1));
%     end
%     for i = num(1)+1 : num(1)+num(2)
%         AjImage(locationx(i),locationy(i)) = uint8(Calcu(origin(locationx(i),locationy(i)),MSB)+number(2));
%     end
%     for i = num(1)+num(2)+1 : num(1)+num(2)+num(3)
%         AjImage(locationx(i),locationy(i)) = uint8(Calcu(origin(locationx(i),locationy(i)),MSB)+number(3));
%     end 
%     for i = num(1)+num(2)+num(3)+1 : len
%         AjImage(locationx(i),locationy(i)) = Calcu(origin(locationx(i),locationy(i)),MSB);
%     end
% elseif count == 7
%     for x = 0 : len
%         for y = 0 : len-x
%             for z = 0 : len-x-y
%                 for p = 0 : len-x-y-z
%                     for q = 0 : len-x-y-z-p
%                         for r = 0 : len-x-y-z-p-q
%                             for n = 0 : len-x-y-z-p-q-r
%                                 s = Sum+number(1)*x+number(2)*y+number(3)*z+number(4)*p+number(5)*q+number(6)*r+number(7)*n;
%                                 difference = abs(s-blocksize*blocksize*value);
%                                 if difference < number(1)/2 
%                                     num(1) = x;
%                                     num(2) = y;
%                                     num(3) = z;
%                                     num(4) = p;
%                                     num(5) = q;
%                                     num(6) = r;
%                                     num(7) = n;
%                                     state = 1;
%                                     break;
%                                 end
%                             end
%                             if state == 1
%                                 break;
%                             end
%                         end
%                         if state == 1
%                             break;
%                         end
%                     end
%                     if state == 1
%                         break;
%                     end
%                 end
%                 if state == 1
%                     break;
%                 end
%             end
%             if state == 1
%                 break;
%             end
%         end
%         if state == 1
%             break;
%         end
%     end
%     if state == 0
%         num(1) = 0;
%         num(2) = 0;
%         num(3) = 0;
%         num(4) = 0;
%         num(5) = 0;
%         num(6) = 0;
%         num(7) = 4*blocksize-4;
%         s = Sum+number(7)*(4*blocksize-4);
%     end
%     for i = 1 : num(1)
%         AjImage(locationx(i),locationy(i))=Calcu(origin(locationx(i),locationy(i)),MSB)+number(1);
%     end
%     for i = num(1)+1 : num(2)
%         AjImage(locationx(i),locationy(i))=Calcu(origin(locationx(i),locationy(i)),MSB)+number(2);
%     end
%     for i = num(1)+num(2)+1 : num(1)+num(2)+num(3)
%         AjImage(locationx(i),locationy(i))=Calcu(origin(locationx(i),locationy(i)),MSB)+number(3);
%     end
%     for i = num(1)+num(2)+num(3)+1 : num(1)+num(2)+num(3)+num(4)
%         AjImage(locationx(i),locationy(i))=Calcu(origin(locationx(i),locationy(i)),MSB)+number(4);
%     end
%     for i = num(1)+num(2)+num(3)+num(4)+1 : num(1)+num(2)+num(3)+num(4)+num(5)
%         AjImage(locationx(i),locationy(i))=Calcu(origin(locationx(i),locationy(i)),MSB)+number(5);
%     end
%     for i = num(1)+num(2)+num(3)+num(4)+num(5)+1 : num(1)+num(2)+num(3)+num(4)+num(5)+num(6)
%         AjImage(locationx(i),locationy(i))=Calcu(origin(locationx(i),locationy(i)),MSB)+number(6);
%     end
%     for i = num(1)+num(2)+num(3)+num(4)+num(5)+num(6)+1 : num(1)+num(2)+num(3)+num(4)+num(5)+num(6)+num(7)
%         AjImage(locationx(i),locationy(i))=Calcu(origin(locationx(i),locationy(i)),MSB)+number(7);
%     end
%     for i = num(1)+num(2)+num(3)+num(4)+num(5)+num(6)+num(7)+1 : len
%        AjImage(locationx(i),locationy(i))=Calcu(origin(locationx(i),locationy(i)),MSB);
%     end 
% end
% difference = abs(s-blocksize*blocksize*value)
% if difference<blocksize*blocksize*5
%     success = 1;

% end
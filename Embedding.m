%file:Embedding.m
%origin: the original image   blocksize: the size of block
%x,y: the start location of block
%MSB: the number of every bit in adjustment area used for adjustment
%count: the max number of elements in EN1
function [data,SubImage,capacity] = Embedding( origin, blocksize, x, y, MSB, count)
SubImage=origin;
capacity = 0;
%select the highest MSB bits of each pixel in adjustment area
bits = []; %store the highest MSB bits of pixels in adjustment area
bit = [];
for i = x : x+blocksize-1
    bit = Get(bit,origin(i,y),MSB); 
end
for i = x : x+blocksize-1
    bit = Get(bit,origin(i,y+blocksize-1),MSB);
end
for j = y+1 : y+blocksize-2
    bit = Get(bit,origin(x,j),MSB);
end
for j = y+1 : y+blocksize-2
    bit = Get(bit,origin(x+blocksize-1,j),MSB);
end
if MSB == 1
    bits=bit;
end
if MSB == 2
    a = 4*blocksize-4;
    bits(1:a) = bit(1:2:2*a-1);
    bits(a+1:2*a) = bit(2:2:2*a);
end
if MSB == 3
    a = 4*blocksize-4;
    bits(1:a) = bit(1:3:3*a-2);
    bits(a+1:2*a) = bit(2:3:3*a-1);
    bits(2*a+1:3*a) = bit(3:3:3*a);
end
%1-divide all pixel into different sets: EZ & EN1 & EN2 & CN & NC
%2-generate the lacation-map MAP
%3-store the lowest bit of each pixel in EN2 and CN  
%EZ: h=0 || h=-1 used as expandable
%EN1: expandable and used as expandable
%EN2: expandable but used as changable
%CN: changable and used as changable
%NC: not changable and never use
SORT = zeros(blocksize,blocksize);%to store the kind of the pixel NC: 0; EZ&EN1: 1; EN2&CN: 2;
MAP = zeros(blocksize-2,(blocksize-2)/2);%MAP: store the location map to tell which pixel used as expandable
LSB = [];%LSB: store the lowest bit of each pixel used as changable 
sum = 0; %calculate the number of elements in EN1 at present 
num = 0; %store the size of P
for i = x+1 : 1 : x+blocksize-2
    for j = y+1 : 2 : y+blocksize-2
        l = floor(double(uint16(origin(i,j))+uint16(origin(i,j+1)))/2);
        h = double(double(origin(i,j))-double(origin(i,j+1)));
        min = 2*(255-l);
        b = 2*l+1;
        if( b < min )
            min = b;
        end
        if h==0 || h==-1
            SORT(i-x,j-y) = 1;
            MAP(i-x,floor((j-y+1)/2)) = 1;
        elseif abs(2*h+1) < min
            if sum < count
                SORT(i-x,j-y) = 1;
                MAP(i-x,floor((j-y+1)/2)) = 1;
                sum = sum+1;
            else
                SORT(i-x,j-y) = 2;
                t = Dec2bin(h);
                if h~=1 && h~=-2
                    num=num+1;
                    [~,len]=size(t);
                    LSB(num) = t(len)-'0';
                end
            end
        elseif abs(2*floor(h/2)+1) < min
            SORT(i-x,j-y) = 2;
            t = Dec2bin(h);
            if h~=1 && h~=-2 %as such value could br determined by location map
                num=num+1;
                [~,len]=size(t);
                LSB(num) = t(len)-'0';
            end
        end
    end
end
%encoding the MAP into L (using 01111110 as the ending of the data)
%when meet five and more than five '1' ,use 0 in the ending of '11111'
L = [];
MAP=MAP';
MAP=MAP(:);
MAP=MAP'; %to change the MAP to unidimensional matrix

%embedding bit in L & LSB $ bits into embedding area: EZ & EN1 & EN2 & CN
%in EZ & EN1: the h`=2*h+bit
%in EN2 & CN: the h`=2*(h/2)+bit
%l=(x+y)/2  h=x-y (as x and y are two pixel's value)
%x`=l+(h`+1)/2  y`=l-(h`)/2
%if there are more than len bits spare space, we embed 01111...1 in the end
data=[];
MAP = Encode(MAP);
[~,len1] = size(MAP);
data(1:len1) = MAP(1:len1);
[~,len2] = size(LSB);
data(len1+1:len1+len2) = LSB(1:len2);
bits = Encode(bits);
[~,len3] = size(bits);
data(len1+len2+1:len1+len2+len3) = bits(1:len3);
no=1; %means the index of data to embed

for i = x+1 : 1 : x+blocksize-2
    for j = y+1 : 2 : y+blocksize-2
        if SORT(i-x,j-y) == 0
            continue;
        end
        l = floor(double(uint16(origin(i,j))+uint16(origin(i,j+1)))/2);
        h = double(double(origin(i,j))-double(origin(i,j+1)));
        if SORT(i-x,j-y) == 1 %expandable
            hh = 2*h;
            capacity = capacity+1;
        elseif SORT(i-x,j-y) == 2 %changable
            hh = 2*floor(h/2);
            capacity = capacity+1;
        else
            hh = h;
        end
        no = no+1;
        SubImage(i,j) = uint8(l+floor((hh+1)/2));
        SubImage(i,j+1) = uint8(l-floor(hh/2));
    end
end


end
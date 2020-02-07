%file:Embedding.m
%origin: the original image   blocksize: the size of block
%x,y: the start location of block
%MSB: the number of every bit in adjustment area used for adjustment
%count: the max number of elements in EN1
function SubImage = Embedding( origin, blocksize, x, y, MSB, count)

SubImage=origin;
%select the highest MSB bits of each pixel in adjustment area
bits = []; %store the highest MSB bits of pixels in adjustment area
for i = x : x+blocksize-1
    bits = Get(bits,origin(i,y),MSB); 
end
for i = x : x+blocksize-1
    bits = Get(bits,origin(i,y+blocksize-1),MSB);
end
for j = y+1 : y+blocksize-2
    bits = Get(bits,origin(x,j),MSB);
end
for j = y+1 : y+blocksize-2
    bits = Get(bits,origin(x+blocksize-1,j),MSB);
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
spaceroom=0;
for i = x+1 : 1 : x+blocksize-2
    for j = y+1 : 2 : y+blocksize-2
        l = floor((origin(i,j)+origin(i,j+1))/2);
        h = origin(i,j)-origin(i,j+1);
        min = 2*(255-l);
        b = 2*l+1;
        if( b < min )
            min = b;
        end
        if h==0 || h==-1
            SORT(i,j) = 1;
            MAP(i-x,floor(j/2)) = 1;
            spaceroom = spaceroom+1;
        elseif abs(2*h+1) < min
            if sum < count
                SORT(i,j) = 1;
                MAP(i-x,floor(j/2)) = 1;
                sum = sum+1;
            else
                SORT(i,j) = 2;
                t = Dec2bin(h);
                if h~=1 && h~=-2
                    num=num+1;
                    [~,len]=size(t);
                    LSB(num) = t(len)-'0';
                end
            end
            spaceroom = spaceroom+1;
        elseif abs(2*floor(h/2)+1) < min
            SORT(i,j) = 2;
            t = Dec2bin(h);
            if h~=1 && h~=-2 %as such value could br determined by location map
                num=num+1;
                [~,len]=size(t);
                LSB(num) = t(len)-'0';
            end
            spaceroom = spaceroom+1;
        end
    end
end

%encoding the MAP into L (using 01111110 as the ending of the data)
%when meet five and more than five '1' ,use 0 in the ending of '11111'
L = [];
MAP=MAP';
MAP=MAP(:);
MAP=MAP'; %to change the MAP to unidimensional matrix
[~,len] = size(MAP);
n = 1;
i = 1;
tem = [1,1,1,1,1];
while i <= len
    if i+4<=len 
        if MAP(i:i+4)==tem(1:5)
            L(n:n+4) = MAP(i:i+4);
            L(n+5) = 0;
            n = n+6;
            i = i+5;
            continue;
        end
    end
    L(n) = MAP(i);
    n = n+1;
    i = i+1;
end
L(n:n+7) = [0,1,1,1,1,1,1,0];

%embedding bit in L & LSB $ bits into embedding area: EZ & EN1 & EN2 & CN
%in EZ & EN1: the h`=2*h+bit
%in EN2 & CN: the h`=2*(h/2)+bit
%l=(x+y)/2  h=x-y (as x and y are two pixel's value)
%x`=l+(h`+1)/2  y`=l-(h`)/2
%if there are more than len bits spare space, we embed 01111...1 in the end
[~,len1] = size(L);
data(1:len1) = L(1:len1);
[~,len2] = size(LSB);
data(len1+1:len1+len2) = LSB(1:len2);
[~,len3] = size(bits);
data(len1+len2+1:len1+len2+len3) = bits(1:len3);
[~,datalen]=size(data);
if spaceroom > datalen %have extra spare space
    data(datalen+1:spaceroom) = 1;
end
no=1; %means the index of data to embed
for i = x+1 : 1 : x+blocksize-2
    for j = y+1 : 2 : y+blocksize-2
        if SORT(i,j) == 0
            continue;
        end
        l = floor((origin(i,j)+origin(i,j+1))/2);
        h = origin(i,j)-origin(i,j+1);
        if SORT(i,j) == 1 %expandable
            hh = 2*h+data(no);
        elseif SORT(i,j) == 2 %changable
            hh = 2*floor(h/2)+data(no);
        end
        no = no+1;
        SubImage(i,j) = l+floor((hh+1)/2);
        SubImage(i,j+1) = l-floor(hh/2);
    end
end


end
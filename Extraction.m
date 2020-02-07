%file: Extration.m
% to extrate the message the is embedded (MSB of pixel in adjustment area)
%origin: the image after decipher   
%blocksize: the size of block
%x,y: the start location of block
%MSB: the number of every bit in adjustment area used for adjustment
function ExImage = Extraction( origin, blocksize, x, y, MSB )

ExImage = origin;
%divide all pixel into two different sets: CH & NC 
%(whether it is changable)
%CH: EZ & EN & CN --- changable
%NC: not changable
SORT = zeros(blocksize,blocksize);%to store the kind of pixel CH:1, NC:0
data = [];%store the embedded message
no = 0; %means the number of elements in data
for i = x+1 : 1 : x+blocksize-2
    for j = y+1 : 2 :y+blocksize-2
        l = floor((origin(i,j)+origin(i,j+1))/2);
        h = origin(i,j)-origin(i,j+1);
        min = 2*(255-l);
        b = 2*l+1;
        if b < min
            min = b;
        end
        if abs(2*floor(h/2)+1) < min %changable
            SORT(i,j) = 1;
            no = no+1;
            a = Dec2bin(h);
            [~,len] = size(a);
            data(no) = a(len)-'0'; %the lowest of h is the embedded message
        end
    end
end

%dipose the embedded message 'data'
%the construction of data:location-map 01111110 LSB-of-EN2&CN MSB 01111...1
index = 1;
flag = 0;
temp = [0,1,1,1,1,1,1,0];
while flag == 0
   if data(index:index+7) == temp
      flag = index+7; %the end of location-map + 01111110 
   end
end

%decoding the location-map to original construction
MAP = [];
temp = [1,1,1,1,1,0]
i = 1;%index in data
no = 1;%index in MAP
while i <= (flag-8)
    if data(i:i+5)==temp
        MAP(no:no+4) = temp(1:5);
        no = no+5;
        i = i+6;
    else
        MAP(no) = data(i);
        no = no+1;
        i = i+1;
    end
end


%recover the embedding area to original area before embedding
infono = flag+1;%the index of LSB
for i = x+1: 1 : x+blocksize-2
    for j = y+1: 2 : y+blocksize-2
        l = floor((origin(i,j)+origin(i,j+1))/2);
        hh = origin(i,j)-origin(i,j+1);
        if MAP((i-1)*blocksize+j)==1
            h = floor(hh/2);
        else
            if 0 <= hh <= 1
                h = 1;
            elseif -2 <= hh <= -1
                h = -2;
            else
                h = 2*floor(hh/2)+data(infono);
                infono = infono+1;
            end
        end
        
    end
end
            
            
data     

end
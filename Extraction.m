%file: Extration.m
% to extrate the message the is embedded (MSB of pixel in adjustment area)
%origin: the image after decipher   
%blocksize: the size of block
%x,y: the start location of block
%MSB: the number of every bit in adjustment area used for adjustment
function ExImage = Extraction( origin, blocksize, x, y, MSB ,data )

ExImage = origin;

%decode the message 'data'
%flag means the end of the locate-map
data = Decode(data,blocksize);
flag = (blocksize-2)*(blocksize-2)/2;
MAP(1:flag) = data(1:flag);

%recover the embedding area to original area before embedding
infono = flag+1;%the index of LSB
count=0;
for i = x+1: 1 : x+blocksize-2
    for j = y+1: 2 : y+blocksize-2
        l = floor(double(uint16(origin(i,j))+uint16(origin(i,j+1)))/2);
        hh = double(double(origin(i,j))-double(origin(i,j+1)));
        t = (i-x-1)*((blocksize-2)/2)+(j-y+1)/2;
        min = 2*(255-l);
        b = 2*l+1;
        if( b < min )
            min = b;
        end
        if abs(2*floor(hh/2)+1)<min
            if MAP(t)==1
                h = floor(hh/2);
            else   
                if 0<=hh && hh<=1
                    h = 1;
                elseif -2<=hh && hh<=-1
                    h = -2;
                else
                    h = 2*floor(hh/2)+data(infono);
                    count = count+1;
                    infono = infono+1;
                end
            end
        end
        ExImage(i,j) = l+floor((h+1)/2);
        ExImage(i,j+1) = l-floor(h/2);
    end
end

%%recover the MSB of pixel in adjustment area
%the start of MSB index in data is infono now
for i = x : x+blocksize-1
    ExImage(i,y) = Put(origin(i,y),data,infono,MSB);
    infono = infono+MSB;
end
for i = x : x+blocksize-1
    ExImage(i,y+blocksize-1) = Put(origin(i,y+blocksize-1),data,infono,MSB);
    infono = infono+MSB;
end
for j = y+1 : y+blocksize-2
    ExImage(x,j) = Put(origin(x,j),data,infono,MSB);
    infono = infono+MSB;
end
for j = y+1 : y+blocksize-2
    ExImage(x+blocksize-1,j) = Put(origin(x+blocksize-1,j),data,infono,MSB);
    infono = infono+MSB;
end

end
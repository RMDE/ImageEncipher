function DATA =  Select(origin,blocksize,MSB)
[M,N] = size(origin);
m = M/blocksize;
n = N/blocksize;
num = 4*blocksize-4
DATA = [];
for p = 1 : m
    for q = 1 : n
        x = (p-1)*blocksize+1;
        y = (q-1)*blocksize+1;
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
        [~,len] = size(DATA);
        if MSB == 1
            bits=bit;
            DATA(len+1:len+num) = bits(:);
        end
        if MSB == 2
            a = 4*blocksize-4;
            bits(1:a) = bit(1:2:2*a-1);
            bits(a+1:2*a) = bit(2:2:2*a);
            DATA(len+1:len+num*2) = bits(:);
        end
        if MSB == 3
            a = 4*blocksize-4;
            bits(1:a) = bit(1:3:3*a-2);
            bits(a+1:2*a) = bit(2:3:3*a-1);
            bits(2*a+1:3*a) = bit(3:3:3*a);
            DATA(len+1:len+num*3) = bits(:);
        end
    end
end
DATA = Encode(DATA);
size(DATA)
end
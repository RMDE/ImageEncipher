%file:Decode.m
%to decoding the encoded message
function res = Decode( data , blocksize)

[~,length] = size(data);
i = uint16(1);%the index of data
res = [];
sum = 0;%store the sum of num in order to judge the end of the locate-map
j = uint16(1);%index of res
while sum < ((blocksize-2)*(blocksize-2))/2 %locate-map
   num = uint16(data(i)*64+data(i+1)*32+data(i+2)*16+data(i+3)*8+data(i+4)*4+data(i+5)*2+data(i+6));%calculate the number 
   sum = sum+num;
   res(j:j+num-1) = data(i+7);
   i = i+8;
   j = j+num;  
end
bit = [];
sum = 0;
p = uint16(length);
q = 1;
while sum < 2*(4*blocksize-4) %MSB of the adjustment area 
    num = data(p-1)+data(p-2)*2+data(p-3)*4+data(p-4)*8+data(p-5)*16+data(p-6)*32+data(p-7)*64;
    sum = sum+num;
    bit(q:q+num-1) = data(p);
    p = p-8;
    q = q+num;
end
bit = fliplr(bit);
% bits = bit;
a = 4*blocksize-4;
bits(1:2:2*a-1) = bit(1:a);
bits(2:2:2*a) = bit(a+1:2*a);
[~,n] = size(bits);
if i<=p
    res(j:j+p-i) = data(i:p);
end
[~,len] = size(res);
res(len+1:len+n) = bits(1:n);

end
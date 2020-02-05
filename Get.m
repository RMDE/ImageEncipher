%file:Get.m
%get the MSB of pixel and store it into bits
function bits = Get( bits, pixel, MSB )
b = dec2bin(pixel);
[~,n] = size(b);
if n < 8
    t = b;
    b(1:8-n) = '0';
    b(8-n+1:8) = t(1:n);
end
[~,len] = size(bits);
b = b(1:MSB);
bits(len+1:len+MSB) = b(1:MSB)-'0'; 
end
%file: Put.m
%to cover the MSB of pixel with MSB in data
function cover = Put( pixel , data , infono , MSB)

cover = dec2bin(pixel);
[~,n] = size(cover);
if n < 8
    t = cover;
    cover(1:8-n) = '0';
    cover(8-n+1:8) = t(1:n);
end
cover(1:MSB) = data(infono:infono+MSB-1)+'0';
cover = bin2dec(cover);

end
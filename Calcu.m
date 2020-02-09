%file: Calcu.m
%to calculate the low (8-MSB) bit of the pixel
function res = Calcu( pixel , MSB)


bits = dec2bin(pixel);
[~,len] = size(bits);
if len < (8-MSB)
    res = pixel;
else
    bits = bits(len+MSB-7:len);
    res = bin2dec(bits);
end

end
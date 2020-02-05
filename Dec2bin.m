%file:Dec2bin.m
%change from function dec2bin
%adding: the solution of negative integer
function bits = Dec2bin( number )
bit=[];
if number > 0
    bits = dec2bin(number);
elseif number == 0
    bits = 0;
else
    bit = Get(bit,-number,8);
    for i = 1 : 8
        if bit(i) == 0
            bits(i) = '1';
        else
            bits(i) = '0';
        end
    end
    bit = bin2dec(bits);
    bits= dec2bin(bit+1);
end
end
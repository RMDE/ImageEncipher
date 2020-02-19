%file:Chg2bin.m
%change the number ( < 128 ) to bits
function bits = Chg2bin( number )

if number == 0
    bits = [0,0,0];
else
    bits(7) = rem(number,2);
    number = floor(number/2);
    bits(6) = rem(number,2);
    number = floor(number/2);
    bits(5) = rem(number,2);
    number = floor(number/2);
    bits(4) = rem(number,2);
    number = floor(number/2);
    bits(3) = rem(number,2);
    number = floor(number/2);
    bits(2) = rem(number,2);
    number = floor(number/2);
    bits(1) = rem(number,2);
end

end
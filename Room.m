%file:SaveSpace.m
%save the MSB of adjustment area pixel in order to adjust
%origin: original image    blocksize: size of block
%MSB: the number of every bit in adjustment area used for adjustment
%count: the max number of elements in EN1
function embed_image = Room( origin , blocksize , DATA)
[~,len] = size(DATA);
embed_image = origin;
[M,N] = size(origin);
m = M/blocksize;
n = N/blocksize;
index = 1;
for i = 1 : m
    for j = 1 : n
        x = (i-1)*blocksize+1;
        y = (j-1)*blocksize+1;
        
        for p = x+1 : 1 : x+blocksize-2
            for q = y+1 : 2 : y+blocksize-2
                l = floor(double(uint16(embed_image(p,q))+uint16(embed_image(p,q+1)))/2);
                h = double(double(embed_image(p,q))-double(embed_image(p,q+1)));
                min = 2*(255-l);
                b = 2*l+1;
                if( b < min )
                    min = b;
                end
                if abs(2*floor(h/2)+1)<min && index<=len
                    hh = h+DATA(index);
                    index = index+1;
                    embed_image(p,q) = uint8(l+floor((hh+1)/2));
                    embed_image(p,q+1) = uint8(l-floor(hh/2));
                end
            end
        end
        
    end
end

end

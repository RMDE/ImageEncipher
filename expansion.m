%file: expansion.m
%%caculate the capacity of the encrypted image using difference expansion
origin = imread("result.png");
[M,N] = size(origin);
blocksize = 1024;
m = M/blocksize;
n = N/blocksize;
num = 0;
for p = 1:m
    for q =1:n
        x = (p-1)*blocksize+1;
        y = (q-1)*blocksize+1;
        for i = x+1 : 1 : x+blocksize-2
            for j = y+1 : 2 : y+blocksize-2
                l = floor(double(uint16(origin(i,j))+uint16(origin(i,j+1)))/2);
                h = double(double(origin(i,j))-double(origin(i,j+1)));
                min = 2*(255-l);
                b = 2*l+1;
                if( b < min )
                    min = b;
                end
                if h==0 || h==-1
                    num = num+1;
                elseif abs(2*h+1) < min
                   num = num+1;
                elseif abs(2*floor(h/2)+1) < min
                    num=num+1;
                end
            end
        end
    end
end
num




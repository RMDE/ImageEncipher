%file: Recovery.m
%to recover the image 
%origin: the image after decipher progress
%blocksize: size of block
%MSB: the number of every bit in adjustment area used for adjustment
function ReImage = Recover( origin , blocksize , MSB )

ReImage = origin;
[M,N] = size(origin);
m = M/blocksize;
n = N/blocksize;
%divide all pixel into two different sets: CH & NC 
%(whether it is changable)
%CH: EZ & EN & CN --- changable
%NC: not changable
DATA = zeros(1,((blocksize-2)*(blocksize-2))/2*m*n);%store the embedded message
no = 0; %means the number of elements in data
for i = 1 : m
    for j = 1 : n
        x = (i-1)*blocksize+1;
        y = (j-1)*blocksize+1;
        
        for p = x+1 : 1 : x+blocksize-2
            for q = y+1 : 2 : y+blocksize-2
                l = floor((origin(p,q)+origin(p,q+1))/2);
                h = double(double(origin(p,q))-double(origin(p,q+1)));
                min = 2*(255-l);
                b = 2*l+1;
                if b < min
                    min = b;
                end
                if abs(2*floor(h/2)+1) < min %changable
                    no = no+1;
                    a = Dec2bin(h);
                    [~,len] = size(a);
                    DATA(no) = a(len)-'0'; %the lowest of h is the embedded message
                end
            end
        end
    end
end


%calculate every block's data according to the DATA
board =zeros(1,m*n);
mess = zeros(1,((blocksize-2)*(blocksize-2))/2*m*n);
j = 1;%index of board
i = 1;%index of DATA
no = 1;%index of mess
temp = [1,1,1,1,1,1,1,1,0];
ending = [0,1,1,1,1,1,1,1,1,1,0];

while j <= m*n
   if DATA(i:i+10) ==  ending(1:11)
       board(j) = no-1;
       j = j+1;
       i = i+11;
   elseif DATA(i:i+8) == temp(1:9)
       mess(no:no+7) = temp(1:8);
       no = no+8;
       i = i+9;
   else
       mess(no) = DATA(i);
       no = no+1;
       i = i+1;
   end
end

b = 0;
for i = 1 : m
    for j = 1 : n
        data = [];
        x = (i-1)*blocksize+1;
        y = (j-1)*blocksize+1;
        t = (i-1)*m+j;
        a = uint32(board(t));
        if t > 1
            b = uint32(board(t-1));
        end
        data(1:a-b) = mess(b+1:a); 
        ReImage = Extraction(ReImage,blocksize,x,y,MSB,data);
    end
end


end
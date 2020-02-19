%file: Encode.m
%using run-length code to compress the embedded message 
function res = Encode( data )

[~,length] = size(data);
i = 1;%the index of data
count = 0;%to store the number of '0' or '1'
res = [];%store the compression result, every progress result in one byte and the LSB is the type of number counted('0' or '1')
l = 1;%index of res
flag = 0;%means the number now to calculate is '0'
while i < length
    if data(i)==0
        while i<=length && data(i)==0 && count<127  %calculate the number of '0'
            count = count+1;
            i = i+1;
        end
        flag = 0;
    elseif data(i)==1
        while i<=length && data(i)==1 && count<127  %calculate the number of '0'
            count = count+1;
            i = i+1;
        end
        flag = 1;
    end
    t = Chg2bin(count);
    res(l:l+6) = t(1:7);
    res(l+7) = flag;
    l = l+8;
    count = 0;
end
        

end
%file:Insert.m
%first: encode the 'data' -- when meeting '11111111' then add a '0' in the end
%second: adding '01111111110' to the end of the data
function DATA = Insert( data , DATA )

[~,len] = size(data);
[~,index] = size(DATA); 
index = index+1;
temp = [1,1,1,1,1,1,1,1,0];
ending = [0,1,1,1,1,1,1,1,1,1,0];
i=1;%index of data
while i <= len
    if (i+7)<=len 
        if data(i:i+7)==temp(1:8)
            DATA(index:index+8) = temp(1:9);
            index = index+9;
            i = i+8;
            continue;
        end
    end
    DATA(index) = data(i);
    index = index+1;
    i = i+1;
end
DATA(index:index+10) = ending(1:11);
end
%file: Generate.m
%to generate all possible 2**MSB value
%because the MSB must smaller than four, so here using enumeration to save time
function number = Generate(MSB)

% if MSB==1
%     number = [128];
% elseif MSB==2
%     number = [64,128,192];
% elseif MSB==3
%     number = [32,64,96,128,160,192,224];

if MSB == 1
    number = [128];
elseif MSB == 2
    number = [128,64];
elseif MSB == 3
    number = [128,64,32];
elseif MSB == 4
    number = [128,64,32,16];
elseif MSB == 5
    number = [128,64,32,16,8];
elseif MSB == 6
    number = [128,64,32,16,8,4];
elseif MSB == 7
    number = [128,64,32,16,8,4,2];
end
end

%file: Generate.m
%to generate all possible 2**MSB value
%because the MSB must smaller than four, so here using enumeration to save time
function number = Generate(MSB)

if MSB==1
    number = [128];
elseif MSB==2
    number = [64,128,192];
elseif MSB==3
    number = [32,64,96,128,160,192,224];

end
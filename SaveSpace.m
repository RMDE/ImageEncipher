%file:SaveSpace.m
%save the MSB of adjustment area pixel in order to adjust
function embed_image = SaveSpace( origin , blocksize )

[M,N] = size(origin);
number = (M*N)/blocksize;


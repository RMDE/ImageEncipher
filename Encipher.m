%file: Encipher.m
%to encipher the image after the saving space progress
%origin: the image after saving space progress
%key: the sub key to generate the stream key to encipher
%using  key expansion function
function EnImage = Encipher( origin , key )

[M,N] = size(origin);
rng('default');
rng(key);
stream = uint8(randi(256,M,N)-1);
x = size(stream);
EnImage = bitxor(origin,stream);

end
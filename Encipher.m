%file: Encipher.m
%to encipher the image after the saving space progress
%origin: the image after saving space progress
%key: the sub key to generate the stream key to encipher
%using  key expansion function
function EnImage = Encipher( origin , key )

[M,N] = size(origin);
rng('default');
rng(key);
stream = randi(255,M,N);
EnImage = bitxor(origin,stream);

end
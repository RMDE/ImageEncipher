%file: Encipher.m
%to encipher the image after the saving space progress
%origin: the original image
%key: the sub key to generate the stream key to encipher
%using  key expansion function
function EnImage = Encipher( origin , key )

EnImage = bitxor(origin,key);

end
for mm =1:3
    b=".png";
    c=num2str(mm);
    name=strcat("eva\me",c,b)
    origin=imread(name,"png");
    [M,N] = size(origin);
    AjImage = imresize(origin,2);
    b=".png";
    c=num2str(mm);
    res=strcat("eva\me",c,b);
    imwrite(AjImage,res,'png');
end
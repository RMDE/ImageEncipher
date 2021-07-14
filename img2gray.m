% sum = double(0);
% str = ['head\','bust\','body\'];
% for sub = 2:2
%     a1 = 'origin\';
%     a1 = strcat(a1,str(sub*5+1:(sub+1)*5));
% for mm =1:60
%     b=".png";
%     c=num2str(mm);
%     name=strcat(a1,c,b);
%     origin=imread(name,"png");
%     [m,n,p] = size(origin);
%     if(mod(m,128)~=0 || mod(n,128)~=0)
%         name
%     end
%     if (size(size(origin))== [1,3])
%         gray = rgb2gray(origin);
%         size(gray)
%         imwrite(gray,name,'png');  
%     end
% end
% end
% 
origin=imread("me.png","png");
    if (size(size(origin))== [1,3])
        gray = rgb2gray(origin);
        size(gray)
        imwrite(gray,"me.png",'png');  
    end
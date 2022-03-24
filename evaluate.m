% sum = 0;
% str = ['head\','bust\','body\'];
% for sub = 0:2
%     a1 = 'origin\';
%     a1 = strcat(a1,str(sub*5+1:(sub+1)*5));
%     a2 = 'result2\';
%     a2 = strcat(a2,str(sub*5+1:(sub+1)*5));
%     for mm =1:50
%         b=".png";
%         c=num2str(mm);
%         name=strcat(a1,c,b);
%         ori=dir(name);
%         size1=ori.bytes/1024/1024;
%         b=".png";
%         c=num2str(mm);
%         name=strcat(a2,c,b);
%         res=dir(name);
%         size2=res.bytes/1024/1024;
%         x = size2/size1;
%         sum = sum + x;
%     end
%     avg = sum/50
%     sum = 0;
% end

%psnr
sum = 0;
str = ['head\','bust\','body\'];
for sub = 2:2
    a1 = 'thumbnail\';
    a1 = strcat(a1,str(sub*5+1:(sub+1)*5));
    a2 = 'result2\';
    a2 = strcat(a2,str(sub*5+1:(sub+1)*5));
    for mm =1:60
        b=".png";
        c=num2str(mm);
        name=strcat(a1,c,b);
        ori=imread(name,"png");
        b=".png";
        c=num2str(mm);
        name=strcat(a2,c,b);
        res=imread(name,"png");
        x = lpips(ori,res);
        sum = sum + x;
    end
    avg = sum/60
    sum = 0;
end
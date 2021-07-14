
img = imread("thumbnail.png","png");
cal = zeros(3,256);
[M,N,C] = size(img);
for cha = 1 : C
    for m = 1 : M
        for n = 1 : N
            pixel = img(m,n,cha)+1;
            cal(cha,pixel) = cal(cha,pixel)+1;
        end
    end
end


x=0:1:255;
 a=cal(1,:); %a数据y值
 b=cal(2,:); %b数据y值
 c=cal(3,:);
 plot(x,a,'-r',x,b,'-g',x,c,'-b','LineWidth',1.1);
 
axis([-2,255,0,20000])  %确定x轴与y轴框图大小

set(gca,'xticklabel',[0:50:255])
set(gca,'YTick',[0:5000:20000]) %y轴范围0-700，间隔100

legend('Red','Green','Blue');   %右上角标注
xlabel('pixel value')  %x轴坐标描述
ylabel('count') %y轴坐标描述
set(gcf,'position',[0,0,420,270])

% x=0:1:255;
%  a=cal(1,:); %a数据y值
%  b=cal(2,:); %b数据y值
%  c=cal(3,:);
%  plot(x,a,'-r',x,b,'-g',x,c,'-b','LineWidth',1.1);
%  
% axis([-2,255,0,110000])  %确定x轴与y轴框图大小
% 
% set(gca,'xticklabel',[0:50:255])
% set(gca,'YTick',[0:10000:100000]) %y轴范围0-700，间隔100
% 
% legend('Red','Green','Blue');   %右上角标注
% xlabel('pixel value')  %x轴坐标描述
% ylabel('count') %y轴坐标描述
% set(gcf,'position',[0,0,420,270])

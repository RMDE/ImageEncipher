
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
 a=cal(1,:); %a����yֵ
 b=cal(2,:); %b����yֵ
 c=cal(3,:);
 plot(x,a,'-r',x,b,'-g',x,c,'-b','LineWidth',1.1);
 
axis([-2,255,0,20000])  %ȷ��x����y���ͼ��С

set(gca,'xticklabel',[0:50:255])
set(gca,'YTick',[0:5000:20000]) %y�᷶Χ0-700�����100

legend('Red','Green','Blue');   %���ϽǱ�ע
xlabel('pixel value')  %x����������
ylabel('count') %y����������
set(gcf,'position',[0,0,420,270])

% x=0:1:255;
%  a=cal(1,:); %a����yֵ
%  b=cal(2,:); %b����yֵ
%  c=cal(3,:);
%  plot(x,a,'-r',x,b,'-g',x,c,'-b','LineWidth',1.1);
%  
% axis([-2,255,0,110000])  %ȷ��x����y���ͼ��С
% 
% set(gca,'xticklabel',[0:50:255])
% set(gca,'YTick',[0:10000:100000]) %y�᷶Χ0-700�����100
% 
% legend('Red','Green','Blue');   %���ϽǱ�ע
% xlabel('pixel value')  %x����������
% ylabel('count') %y����������
% set(gcf,'position',[0,0,420,270])

 %% 3.优化求最小值的方法
clear, clc
hip_length = zeros(300,1);

for i = 0:299
    i = num2str(i);
    filex = strcat('./hips/',i,'x.txt');
    filey = strcat('./hips/',i,'y.txt');
    x = load(filex);
    y = load(filey);
    
    fun=@(t)sum((t(1)*x.^2+t(2)*x.*y+t(3)*y.^2+t(4)*x+t(5)*y+t(6)).^2);
    X = [1,1,1,1,1,1];
    [t, fval]= fminunc( fun , X);  %无边界多元优化函数
    %clf , plot(x,y,'.')
   % hold on
   % syms x y
    %ezplot(t(1)*x.^2+t(2)*x.*y+t(3)*y.^2+t(4)*x+t(5)*y+t(6), [-40 40 -40 40] ) 
   % axis square
    %作图区间可以写得稍大一点，保证函数图像完整
    A =t(1)/t(6);
    B =t(2)/t(6);
    C =t(3)/t(6);
    D =t(4)/t(6);
    E =t(5)/t(6);
    F =t(6)/t(6);

    %长轴倾角
    theta = 0.5*atan(B/(A-C));
    %椭圆几何中心
    Xc = (B*E-2*C*D)/(4*A*C-B*B);
    Yc = (B*D-2*A*E)/(4*A*C-B*B);
    %长短半轴
    a = (2*(A*Xc*Xc+C*Yc*Yc+B*Xc*Yc-1)/((A+C)+((A-C).^2+B*B).^0.5)).^0.5;
    b = (2*(A*Xc*Xc+C*Yc*Yc+B*Xc*Yc-1)/((A+C)-((A-C).^2+B*B).^0.5)).^0.5;
    %离心率
    e = (a*a-b*b).^0.5/a;
    %椭圆的周长
    perimeter = 2*pi*b+4*(a-b)
    i = str2num(i);
    hip_length(i+1,1) = perimeter;
   % filename = strcat('./hip_perimeter/hips',i,'.txt')
   % save(filename,'perimeter','-ascii')
end

xlswrite('C:\Users\kumori\Desktop\Parameter_statistics.xlsx',{'hips'},'A1:A1')
xlswrite('C:\Users\kumori\Desktop\Parameter_statistics.xlsx',hip_length,'A2:A301')
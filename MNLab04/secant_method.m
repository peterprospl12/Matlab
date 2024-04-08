function [xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,fun)
% a - lewa granica przedziału poszukiwań miejsca zerowego (x0=a)
% b - prawa granica przedziału poszukiwań miejsca zerowego (x1=b)
% max_iterations - maksymalna liczba iteracji działania metody siecznych
% ytolerance - wartość abs(fun(xsolution)) powinna być mniejsza niż ytolerance
% fun - nazwa funkcji, której miejsce zerowe będzie wyznaczane
%
% xsolution - obliczone miejsce zerowe
% ysolution - wartość fun(xsolution)
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution
% xtab - wektor z kolejnymi kandydatami na miejsce zerowe, począwszy od x2
% xdiff - wektor wartości bezwzględnych z różnic pomiędzy i-tym oraz (i+1)-ym elementem wektora xtab; xdiff(1) = abs(xtab(2)-xtab(1));

xsolution = 0;
ysolution = 0;
iterations = 0;
xtab = [a;b]
xdif = xtab(2) - xtab(1);

for i = 1:max_iterations
    iterations = iterations + 1;
    curr_fun = fun(xtab(end))
    nominator = curr_fun * (xtab(end) - xtab(end-1)); 
    denominator = curr_fun - fun(xtab(end-1));
    value = nominator / denominator;
    new_x = xtab(end) - value;
    xtab = [xtab;new_x];
    xdif = [xdif; abs(xtab(end) - xtab(end-1))]
    if abs(fun(new_x)) < ytolerance
        break
    end
end

xsolution = new_x;
ysolution = fun(new_x);
xtab = xtab(3:end);
xdif = xdif(3:end);
end

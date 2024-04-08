a = 1;
b = 60000;
ytolerance = 1e-12;
max_iterations=100;

[n_bisection,bis_ysolution,bis_iterations,bis_xtab,bis_xdif] = bisection_method(a,b,max_iterations,ytolerance,@estimate_execution_time);

[n_secant,sec_ysolution,sec_iterations,sec_xtab,sec_xdif] = secant_method(a,b,max_iterations,ytolerance,@estimate_execution_time);

subplot(2,1,1);
plot(1:length(bis_xtab), bis_xtab)
hold on
plot(1:length(sec_xtab), sec_xtab)
hold off
xlabel('Iterations');
ylabel('Time')
title('Estimate execution time')
legend('Bisection roots', 'Secant roots') 

subplot(2,1,2); 
semilogy(1:length(bis_xdif), bis_xdif)
hold on
semilogy(1:length(sec_xdif), sec_xdif)
hold off
xlabel('Iterations');
ylabel('Time difference')
title('Estimate execution time differences')
legend('Bisection differences', 'Secant differences') 


function time_delta = estimate_execution_time(N)
% time_delta - różnica pomiędzy estymowanym czasem wykonania algorytmu dla zadanej wartości N a zadanym czasem M
% N - liczba parametrów wejściowych

if N <= 0
    error('Incorrect value of time')
end

M = 5000; % [s]

nominator = N^(16/11) + N^((pi^2)/8);
value = nominator / 1000;

time_delta = value - M;

end



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

function [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,fun)
% a - lewa granica przedziału poszukiwań miejsca zerowego
% b - prawa granica przedziału poszukiwań miejsca zerowego
% max_iterations - maksymalna liczba iteracji działania metody bisekcji
% ytolerance - wartość abs(fun(xsolution)) powinna być mniejsza niż ytolerance
% fun - nazwa funkcji, której miejsce zerowe będzie wyznaczane
%
% xsolution - obliczone miejsce zerowe
% ysolution - wartość fun(xsolution)
% iterations - liczba iteracji wykonana w celu wyznaczenia xsolution
% xtab - wektor z kolejnymi kandydatami na miejsce zerowe, począwszy od xtab(1)= (a+b)/2
% xdiff - wektor wartości bezwzględnych z różnic pomiędzy i-tym oraz (i+1)-ym elementem wektora xtab; xdiff(1) = abs(xtab(2)-xtab(1));


iterations = 0;
xtab = (a+b)/2;
xdif = []
for i = 1:max_iterations
    iterations = iterations + 1;
    c = (a+b) / 2;
    if i > 1
        xtab = [xtab; c];
        xdif = [xdif; abs(xtab(end)-xtab(end-1))];
    end
    
    if abs(fun(c)) < ytolerance || abs(b - a) < ytolerance
        break;
    elseif fun(a)*fun(c) < 0
        b = c;
    else
        a = c;
    end
   
end

xsolution = c;
ysolution = fun(xsolution);



end

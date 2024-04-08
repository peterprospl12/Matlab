options = optimset('Display', 'iter');
tan6_fzero = fzero(@tan, 6, options);
tan4_5_fzero = fzero(@tan, 4.5, options);
a = 4.5;
b = 6.0;
ytolerance = 1e-12;
max_iterations=100;

[tan_bisection,bis_ysolution,bis_iterations,bis_xtab,bis_xdif] = bisection_method(a,b,max_iterations,ytolerance,@tan);

[tan_secant,sec_ysolution,sec_iterations,sec_xtab,sec_xdif] = secant_method(a,b,max_iterations,ytolerance,@tan);


subplot(2,1,1);
plot(1:length(bis_xtab), bis_xtab)
hold on
plot(1:length(sec_xtab), sec_xtab)
hold off
xlabel('Iterations');
ylabel('Roots')
title('Tangens roots')
legend('Bisection roots', 'Secant roots') 

subplot(2,1,2); 
semilogy(1:length(bis_xdif), bis_xdif)
hold on
semilogy(1:length(sec_xdif), sec_xdif)
hold off
xlabel('Iterations');
ylabel('Roots difference')
title('Tangens roots differences')
legend('Bisection differences', 'Secant differences') 
print()
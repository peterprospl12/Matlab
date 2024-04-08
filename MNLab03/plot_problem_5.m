function plot_problem_5(N,time_Jacobi,time_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel)
% Opis wektorów stanowiących parametry wejściowe:
% N - rozmiary analizowanych macierzy
% time_Jacobi - czasy wyznaczenia rozwiązania metodą Jacobiego
% time_Gauss_Seidel - czasy wyznaczenia rozwiązania metodą Gaussa-Seidla
% iterations_Jacobi - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Jacobiego
% iterations_Gauss_Seide - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Gauss-Seidla

subplot(2,1,1);
plot(N,time_Jacobi); 
hold on; 
plot(N,time_Gauss_Seidel); 
hold off;
title('Calculation time of Jacobi and Gauss Seidel solutions')
xlabel('Matrix size (NxN)');
ylabel('Time')
legend('Jacobi', 'Gauss Seidel', 'Location', 'eastoutside')

subplot(2,1,2);
bar(N, horzcat(iterations_Jacobi.',iterations_Gauss_Seidel.'))
title('Number of iterations of determining Jacobi and Gauss Seidel solutions')
xlabel('Matrix size (NxN)');
ylabel('Iterations')
legend('Jacobi', 'Gauss Seidel', 'Location', 'eastoutside')

print -dpng zadanie5.png
end

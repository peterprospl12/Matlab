load("filtr_dielektryczny.mat");

[A,b,x,time_direct,err_norm,index_number] = solve_direct(length(A), A, b);
vtime_direct = time_direct;
err_norm_direct = err_norm;
fprintf("Direct Solution: \n\t Iterations: 1 \n\t Time: %f \n\t Error Norm: %e \n", vtime_direct, err_norm_direct);

[A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(length(A), A, b);
time_Jacobi = time;
iterations_Jacobi = iterations;
err_norm_Jacobi = err_norm(iterations);
errors_Jacobi = err_norm;
fprintf("Jacobi Solution: \n\t Iterations: %d \n\t Time: %f \n\t Error Norm: %e \n", iterations_Jacobi, time_Jacobi, err_norm_Jacobi);

[A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Gauss_Seidel(length(A), A, b);
time_Gauss_Seidel = time;
iterations_Gauss_Seidel = iterations;
err_norm_Gauss_Seidel = err_norm(iterations);
errors_Gauss_Seidel = err_norm;

fprintf("Gauss Seidel Solution: \n\t Iterations: %d \n\t Time: %f \n\t Error Norm: %e \n", iterations_Gauss_Seidel, time_Gauss_Seidel, err_norm_Gauss_Seidel);
plot_error_norm(errors_Jacobi, errors_Gauss_Seidel, (1:iterations_Jacobi), (1:iterations_Gauss_Seidel));

figure;
bar(length(A),horzcat(time_Jacobi, time_Gauss_Seidel, time_direct)); 
title('Calculation time of Jacobi, Gauss Seidel and Direct solutions')
xlabel('Matrix size (NxN)');
ylabel('Time')
legend('Jacobi', 'Gauss Seidel', 'Direct', 'Location', 'eastoutside')
print -dpng zadanie6.1.png
figure;
bar(length(A), horzcat(iterations_Jacobi.',iterations_Gauss_Seidel.', 1))
title('Number of iterations of determining Jacobi, Gauss Seidel and Direct solutions')
xlabel('Matrix size (NxN)');
ylabel('Iterations')
legend('Jacobi', 'Gauss Seidel', 'Direct', 'Location', 'eastoutside')
print -dpng zadanie6.2.png
figure;
bar(length(A), horzcat(err_norm_Jacobi.',err_norm_Gauss_Seidel.', err_norm_direct))
title('Error norm of Jacobi, Gauss Seidel and Direct solutions')
xlabel('Matrix size (NxN)');
ylabel('Error norm')
legend('Jacobi', 'Gauss Seidel', 'Direct', 'Location', 'eastoutside')
print -dpng zadanie6.3.png



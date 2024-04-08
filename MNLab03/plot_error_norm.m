function plot_error_norm(errors_Jacobi,errors_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel)

subplot(2,1,1);
plot(iterations_Jacobi, errors_Jacobi); 
title('Error norm of Jacobi solutions')
xlabel('Iterations');
ylabel('Error norm')

subplot(2,1,2);
plot(iterations_Gauss_Seidel, errors_Gauss_Seidel); 
title('Error norm of Gauss Seidel solutions')
xlabel('Iterations');
ylabel('Error norm')
print -dpng error_norm.png

end


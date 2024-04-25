function [matrix_condition_numbers, max_coefficients_difference_1, max_coefficients_difference_2] = zadanie3()
% Zwracane są trzy wektory wierszowe:
% matrix_condition_numbers - współczynniki uwarunkowania badanych macierzy Vandermonde
% max_coefficients_difference_1 - maksymalna różnica między referencyjnymi a obliczonymi współczynnikami wielomianu,
%       gdy b zawiera wartości funkcji liniowej
% max_coefficients_difference_2 - maksymalna różnica między referencyjnymi a obliczonymi współczynnikami wielomianu,
%       gdy b zawiera zaburzone wartości funkcji liniowej

N = 5:40;

%% chart 1
matrix_condition_numbers = zeros(1, length(N));

for idx = 1:length(N)
    matrix_condition_numbers(idx) = cond(vandermonde_matrix(N(idx)));
end

%% chart 2
a1 = randi([20,30]);
for i = 1:length(N)
    ni = N(i);
    V = vandermonde_matrix(ni);
    
    % Niech wektor b zawiera wartości funkcji liniowej
    b = linspace(0,a1,ni)';
    reference_coefficients = [ 0; a1; zeros(ni-2,1) ]; % tylko a1 jest niezerowy
    
    % Wyznacznie współczynników wielomianu interpolującego
    calculated_coefficients = V \ b;

    max_coefficients_difference_1(i) = max(abs(calculated_coefficients-reference_coefficients));
end

%% chart 3
for i = 1:length(N)
    ni = N(i);
    V = vandermonde_matrix(ni);
    
    % Niech wektor b zawiera wartości funkcji liniowej nieznacznie zaburzone
    b = linspace(0,a1,ni)' + rand(ni,1)*1e-10;
    reference_coefficients = [ 0; a1; zeros(ni-2,1) ]; % tylko a1 jest niezerowy
    
    % Wyznacznie współczynników wielomianu interpolującego
    calculated_coefficients = V \ b;
    
    max_coefficients_difference_2(i) = max(abs(calculated_coefficients-reference_coefficients));
end
    subplot(3,1,1);
    semilogy(N, matrix_condition_numbers, 'DisplayName', 'Matrix condition numbers');
    title('Growth of the Condition Number of Vandermonde Matrix')
    xlabel('Vandermonde matrix size')
    ylabel('Matrix condition numbers')
    legend('Location', 'northwest');

    subplot(3,1,2);
    plot(N, max_coefficients_difference_1, 'DisplayName', 'Max coefficients difference')
    title('Max coefficients differences [Linear b]')
    xlabel('Vandermonde matrix size')
    ylabel('Max coefficients difference');
    legend('Location', 'northwest')

    subplot(3,1,3);
    plot(N, max_coefficients_difference_2, 'DisplayName', 'Max coefficients difference')
    title('Max coefficients differences [Disturbed linear b]')
    xlabel('Vandermonde matrix size')
    ylabel('Max coefficients difference');
    legend('Location', 'northwest')
    print('zadanie3.png', '-dpng')
end



function V = vandermonde_matrix(N)
    % Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
    x_coarse = linspace(0,1,N);
    V = zeros(N);
    for i = 1:N
        for j=1:N
            V(i,j) = x_coarse(i)^(j-1);
        end
    
    end

end

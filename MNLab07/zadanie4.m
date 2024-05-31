function [integration_error, Nt, ft_5, xr, yr, yrmax] = zadanie4()
    % Numeryczne całkowanie metodą Monte Carlo.
    %
    %   integration_error - wektor wierszowy. Każdy element integration_error(1,i)
    %       zawiera błąd całkowania obliczony dla liczby losowań równej Nt(1,i).
    %       Zakładając, że obliczona wartość całki dla Nt(1,i) próbek wynosi
    %       integration_result, błąd jest definiowany jako:
    %       integration_error(1,i) = abs(integration_result - reference_value),
    %       gdzie reference_value to wartość referencyjna całki.
    %
    %   Nt - wektor wierszowy zawierający liczby losowań, dla których obliczano
    %       wektor błędów całkowania integration_error.
    %
    %   ft_5 - gęstość funkcji prawdopodobieństwa dla n=5
    %
    %   [xr, yr] - tablice komórkowe zawierające informacje o wylosowanych punktach.
    %       Tablice te mają rozmiar [1, length(Nt)]. W komórkach xr{1,i} oraz yr{1,i}
    %       zawarte są współrzędne x oraz y wszystkich punktów zastosowanych
    %       do obliczenia całki przy losowaniu Nt(1,i) punktów.
    %
    %   yrmax - maksymalna dopuszczalna wartość współrzędnej y losowanych punktów

    reference_value = 0.0473612919396179; % wartość referencyjna całki

    Nt = 5:50:10^4;
    integration_error = zeros(1, length(Nt));

    ft_5 = fun(5);
    yrmax = ft_5 + 0.001;
    [xr, yr, integral] = monteCarlo_method(@fun, 1000, 0, 5, yrmax);
    xr = cell(1, length(Nt)); 
    yr = cell(1, length(Nt)); 
    integration_result = zeros(1, length(Nt));
    for i = 1:length(Nt)
        [xr{1,i}, yr{1,i}, integration_result(1,i)] = monteCarlo_method(@fun, Nt(i), 0, 5, yrmax);
        integration_error(1,i) = abs(integration_result(1,i) - reference_value);
    end

    loglog(Nt, integration_error, 'DisplayName', sprintf("Integration error"))
    xlabel('Number of subdivisions');
    ylabel('Integration error');
    title('Integration error for Monte Carlo method');
    legend('show');

     


end

function value = fun(t)

    sigma = 3;
    u = 10;    
    denominator = sigma*(sqrt(2*pi));
    nominator = -(t-u)^2;
    denonimnator2 = 2*sigma^2;
    euler = exp(nominator/denonimnator2);
    value = (1/denominator)*euler;
end

function [xr, yr, integral, yrmax] = monteCarlo_method(funHandle, N, a, b, yrmax)
    
    S = (b - a) * yrmax;
    xr = zeros(1, N);
    yr = zeros(1,N);
    sum = 0;
    count_under_curve = 0; 
    for i = 1:N
        x = a + (b - a) * rand(); 
        y = yrmax * rand();
        if y <= funHandle(x) % Sprawdzenie, czy punkt znajduje się pod krzywą funkcji
            count_under_curve = count_under_curve + 1; % Zwiększenie licznika punktów pod krzywą
        end
        xr(1,i) = x;
        yr(1,i) = y;
    end
    integral = (count_under_curve/N)*S;

end
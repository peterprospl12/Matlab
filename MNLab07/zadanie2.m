function [integration_error, Nt, ft_5, integral_1000] = zadanie2()
    % Numeryczne całkowanie metodą prostokątów.
    % Nt - wektor zawierający liczby podprzedziałów całkowania
    % integration_error - integration_error(1,i) zawiera błąd całkowania wyznaczony
    %   dla liczby podprzedziałów równej Nt(i). Zakładając, że obliczona wartość całki
    %   dla Nt(i) liczby podprzedziałów całkowania wyniosła integration_result,
    %   to integration_error(1,i) = abs(integration_result - reference_value),
    %   gdzie reference_value jest wartością referencyjną całki.
    % ft_5 - gęstość funkcji prawdopodobieństwa dla n=5
    % integral_1000 - całka od 0 do 5 funkcji gęstości prawdopodobieństwa
    %   dla 1000 podprzedziałów całkowania

    reference_value = 0.0473612919396179; % wartość referencyjna całki

    Nt = 5:50:10^4;
    integration_error = zeros(1, length(Nt));

    ft_5 = fun(5);
    integral_1000 = trapezoid_method(@fun, 1000, 0, 5);
    
    integration_result = zeros(1, length(Nt));

    for i = 1:length(Nt)
        integration_result(1,i) = trapezoid_method(@fun, Nt(i), 0, 5);
        integration_error(1,i) = abs(integration_result(1,i) - reference_value);
    end

    loglog(Nt, integration_error, 'DisplayName', sprintf("Integration error"))
    xlabel('Number of subdivisions');
    ylabel('Integration error');
    title('Integration error for trapezoid method');
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

function integral = trapezoid_method(funHandle, N, a, b)
    
    integral = 0;
    delta = (b - a) / N;
    for i = 1:N
        first_value = a + (i-1) * delta;
        sec_value = a + i * delta;
        value = (funHandle(first_value) + funHandle(sec_value))/2;
        integral = integral + value * delta;
    end
    

end
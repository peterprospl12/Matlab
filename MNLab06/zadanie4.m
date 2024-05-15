function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse, msek] = zadanie4(energy)
% Głównym celem tej funkcji jest wyznaczenie danych na potrzeby analizy dokładności aproksymacji wielomianowej.
% 
% energy - struktura danych wczytana z pliku energy.mat
% country - [String] nazwa kraju
% source  - [String] źródło energii
% x_coarse - wartości x danych aproksymowanych
% x_fine - wartości, w których wyznaczone zostaną wartości funkcji aproksymującej
% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
% y_yearly - wektor danych rocznych
% y_approximation - tablica komórkowa przechowująca wartości nmax funkcji aproksymujących dane roczne.
%   - nmax = length(y_yearly)-1
%   - y_approximation{i} stanowi aproksymację stopnia i
%   - y_approximation{i} stanowi wartości funkcji aproksymującej w punktach x_fine
% mse - wektor mający nmax wierszy: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia i.
%   - mse liczony jest dla aproksymacji wyznaczonej dla wektora x_coarse
% msek - wektor mający (nmax-1) wierszy: msek zawiera wartości błędów różnicowych zdefiniowanych w treści zadania 4
%   - msek(i) porównuj aproksymacje wyznaczone dla i-tego oraz (i+1) stopnia wielomianu
%   - msek liczony jest dla aproksymacji wyznaczonych dla wektora x_fine
load energy
country = 'Poland';
source = 'Wind';
degrees = 1:4;
x_coarse = [];
x_fine = [];
y_original = [];
y_yearly = [];
y_approximation = [];
mse = [];
msek = [];

% Sprawdzenie dostępności danych
if isfield(energy, country) && isfield(energy.(country), source)
    % Przygotowanie danych do aproksymacji
    dates = energy.(country).(source).Dates;
    y_original = energy.(country).(source).EnergyProduction;

    % Obliczenie danych rocznych
    n_years = floor(length(y_original) / 12);
    y_cut = y_original(end-12*n_years+1:end);
    y4sum = reshape(y_cut, [12 n_years]);
    y_yearly = sum(y4sum,1)';

    % degrees = 

    N = length(y_yearly);
    x_coarse = linspace(-1, 1, N)';
    x_fine = linspace(-1, 1, (N-1)*10+1)';
    n_max = length(y_yearly)-1;
    % Pętla po wielomianach różnych stopni

   

    for i = 1:n_max
        p = my_polyfit(x_coarse, y_yearly, i);
        y_approximation{i} = polyval(p, x_fine);
        mse(i, 1) = mean((polyval(p, x_coarse) - y_yearly).^2);
        if i > 1
            msek(i-1,1) = mean((y_approximation{i-1} - y_approximation{i}).^2);
        end
    end
   

    

    figure;
    subplot(3,1,1);
    plot(x_coarse, y_yearly, 'b', 'DisplayName', 'Oryginalne dane');
    hold on;
    for i = 1:length(degrees)
        plot(x_fine, y_approximation{i}, 'r--', 'DisplayName', sprintf('Stopień %d', degrees(i)));
    end
    hold off;
    xlabel('x');
    ylabel('Produkcja energii');
    title('Aproksymacja wielomianowa dla danych rocznych');
    legend('show');

    subplot(3,1,2);
    semilogy(1:n_max, mse, 'b', 'DisplayName', sprintf("MSE"));
    xlabel('Stopień wielomianu');
    ylabel('Błąd średniokwadratowy');
    title('Błąd średniokwadratowy dla różnych stopni wielomianu');
    legend('show');

    subplot(3,1,3);
    semilogy(1:n_max-1, msek, 'b', 'DisplayName', sprintf("MSEk"));
    xlabel('Stopień wielomianu');
    ylabel('Błąd róznicowy');
    title('Błąd różnicowy dla różnych stopni wielomianu');
    legend('show');
    print('zadanie4.png', '-dpng')

else
    disp(['Dane dla (country=', country, ') oraz (source=', source, ') nie są dostępne.']);
end

end

function p = my_polyfit(x, y, deg)
    
    n = length(x);
    X = ones(n, deg+1);
    for i = 1:length(x)
        for j=1:(deg+1)
            X(i,j) = x(i)^(deg+1-j);
        end
    end
    
    p = (X' * X) \ (X' * y);


end

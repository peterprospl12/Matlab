function [country, source, degrees, x_coarse, x_fine, y_original, y_yearly, y_approximation, mse] = zadanie3(energy)
% Głównym celem tej funkcji jest wyznaczenie aproksymacji rocznych danych o produkcji energii elektrycznej w wybranym kraju i z wybranego źródła energii.
% Wybór kraju i źródła energii należy określić poprzez nadanie w tej funkcji wartości zmiennym typu string: country, source.
% Dopuszczalne wartości tych zmiennych można sprawdzić poprzez sprawdzenie zawartości struktury energy zapisanej w pliku energy.mat.
% 
% energy - struktura danych wczytana z pliku energy.mat
% country - [String] nazwa kraju
% source  - [String] źródło energii
% degrees - wektor zawierający cztery stopnie wielomianu dla których wyznaczono aproksymację
% x_coarse - wartości x danych aproksymowanych
% x_fine - wartości, w których wyznaczone zostaną wartości funkcji aproksymującej
% y_original - dane wejściowe, czyli pomiary produkcji energii zawarte w wektorze energy.(country).(source).EnergyProduction
% y_yearly - wektor danych rocznych
% y_approximation - tablica komórkowa przechowująca cztery wartości funkcji aproksymującej dane roczne.
%   - y_approximation{i} stanowi aproksymację stopnia degrees(i)
%   - y_approximation{i} stanowi wartości funkcji aproksymującej w punktach x_fine.
% mse - wektor o rozmiarze 4x1: mse(i) zawiera wartość błędu średniokwadratowego obliczonego dla aproksymacji stopnia degrees(i).
load energy
country = 'Poland';
source = 'Coal';
degrees = 1:4;
x_coarse = [];
x_fine = [];
y_original = [];
y_yearly = [];
y_approximation = [];
mse = [];

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

    degrees = 1:4;

    N = length(y_yearly);
    x_coarse = linspace(-1,1,length(y_yearly))';
    x_fine = linspace(-1, 1, (N)*10)';

    % Pętla po wielomianach różnych stopni
    for i = 1:length(degrees)
        p = my_polyfit(x_coarse, y_yearly, degrees(i));
        y_approximation{i} = polyval(p, x_fine);
        mse(i) = mean((polyval(p, x_coarse) - y_yearly).^2);
    end
    
    figure;
    subplot(2,1,1);
    plot(x_coarse, y_yearly, 'b', 'DisplayName', 'Oryginalne dane');
    hold on;
    for i = 1:length(degrees)
        plot(x_fine, y_approximation{i}, 'r--', 'DisplayName', sprintf('Stopień %d', degrees(i)));
    end
    hold off;
    xlabel('Scaled Data');
    ylabel('Produkcja energii');
    title('Aproksymacja wielomianowa dla danych rocznych');
    legend('show');

    subplot(2,1,2);
    bar(mse);
    set(gca, 'XTickLabel', degrees);
    xlabel('Stopień wielomianu');
    ylabel('Błąd średniokwadratowy');
    title('Błąd średniokwadratowy dla różnych stopni wielomianu');

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

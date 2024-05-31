function [lake_volume, x, y, z, zmin] = zadanie5()
    % Funkcja zadanie5 wyznacza objętość jeziora metodą Monte Carlo.
    %
    %   lake_volume - objętość jeziora wyznaczona metodą Monte Carlo
    %
    %   x - wektor wierszowy, który zawiera współrzędne x wszystkich punktów
    %       wylosowanych w tej funkcji w celu wyznaczenia obliczanej całki.
    %
    %   y - wektor wierszowy, który zawiera współrzędne y wszystkich punktów
    %       wylosowanych w tej funkcji w celu wyznaczenia obliczanej całki.
    %
    %   z - wektor wierszowy, który zawiera współrzędne z wszystkich punktów
    %       wylosowanych w tej funkcji w celu wyznaczenia obliczanej całki.
    %cell
    %   zmin - minimalna dopuszczalna wartość współrzędnej z losowanych punktów
    N = 1e6;
    zmin = -45 - (rand() * (100 - 45));
    x = 100*rand(1,N); % [m]
    y = 100*rand(1,N); % [m]
    z = zmin * rand(1,N);

    lake_volume = monteCarlo_method(N, 0, 100, 0, 100, zmin, 0, x, y, z);


end

function lake_volume = monteCarlo_method(N, xa, xb, ya, yb, za, zb, x, y, z)
    
    S = (xb - xa) * (yb-ya) * abs((zb-za));
    count_above_curve = 0; 
    for i = 1:N
        if z(i) > get_lake_depth(x(i), y(i)) % Sprawdzenie, czy punkt znajduje się pod krzywą funkcji
            count_above_curve = count_above_curve + 1; % Zwiększenie licznika punktów pod krzywą
        end
    end
    lake_volume = (count_above_curve/N)*S;

end
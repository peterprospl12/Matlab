function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
% nodes_Chebyshev - wektor wierszowy zawierający N=16 węzłów Czebyszewa drugiego rodzaju
% V - macierz Vandermonde obliczona dla 16 węzłów interpolacji rozmieszczonych równomiernie w przedziale [-1,1]
% V2 - macierz Vandermonde obliczona dla węzłów interpolacji zdefiniowanych w wektorze nodes_Chebyshev
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% interpolated_Runge - wektor wierszowy wartości funkcji interpolującej określonej dla równomiernie rozmieszczonych węzłów interpolacji
% interpolated_Runge_Chebyshev - wektor wierszowy wartości funkcji interpolującej wyznaczonej
%       przy zastosowaniu 16 węzłów Czebyszewa zawartych w nodes_Chebyshev 
    N = 16;
    x_fine = linspace(-1, 1, 1000);
    nodes_Chebyshev = get_Chebyshev_nodes(N);

    V = vandermonde_matrix(N);
    V2 = vandermonde_matrix_Chebyshev(N);
    
    original_Runge = 1 ./ (1 + 25 * x_fine.^2);
    
    x_coarse_r = linspace(-1,1,N);
    b = (1 ./ (1 + 25 * x_coarse_r.^2))';
    c_runge = V \ b; % współczynniki wielomianu interpolującego
    
    interpolated_Runge = polyval(flipud(c_runge), x_fine); % interpolacja
    
    x_coarse_ch = get_Chebyshev_nodes(N);
    b = (1 ./ (1 + 25 * x_coarse_ch.^2))';
    c_runge = V2 \ b; % współczynniki wielomianu interpolującego

    interpolated_Runge_Chebyshev = polyval(flipud(c_runge), x_fine);

    subplot(2,1,1);
  
    title('Runge interpolation')
    xlabel('x')
    ylabel('y')
    hold on;
    plot(x_fine, original_Runge, 'DisplayName', 'Original Runge');
    plot(x_coarse_r, 1 ./ (1 + 25 * x_coarse_r.^2), 'o', 'DisplayName', 'Runge fun values')
    plot(x_fine, interpolated_Runge, 'DisplayName', 'Interpolated Runge'); % Wyświetlenie legendy dla interpolacji Runge
    legend('Location', 'north');
    hold off

    subplot(2,1,2);
    plot(x_fine, original_Runge, 'DisplayName', 'Original Runge');
    title('Chebyshev interpolation')
    xlabel('x');
    ylabel('y');
    hold on;
    plot(nodes_Chebyshev, 1 ./ (1 + 25 * nodes_Chebyshev.^2), 'o', 'DisplayName', 'Runge fun values')
    plot(x_fine, interpolated_Runge_Chebyshev, 'DisplayName', 'Interpolated Chebyshev')
    legend('Location', 'northeast')
    hold off
    print('zadanie2.png', '-dpng')


end

function nodes = get_Chebyshev_nodes(N)
    % oblicza N węzłów Czebyszewa drugiego rodzaju
    nodes = zeros(1, N);
    for i=0:N-1
        nodes(1,i+1) = cos((i*pi) / (N-1));
    end
end

function V = vandermonde_matrix(N)
    % Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
    x_coarse = linspace(-1,1,N);
    V = zeros(N);
    for i = 1:N
        for j=1:N
            V(i,j) = x_coarse(i)^(j-1);
        end
    
    end

end

function V = vandermonde_matrix_Chebyshev(N)
    % Generuje macierz Vandermonde dla N równomiernie rozmieszczonych w przedziale [-1, 1] węzłów interpolacji
    x_coarse = get_Chebyshev_nodes(N);
    V = zeros(N);
    for i = 1:N
        for j=1:N
            V(i,j) = x_coarse(i)^(j-1);
        end
    
    end

end
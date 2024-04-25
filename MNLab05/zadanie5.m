function [M,N,P,R,x_coarse,y_coarse,F_coarse,x_fine,y_fine,F_fine] = zadanie5()
%min_M = 4;
%max_M = 40;
%min_N = 4;
%max_N = 40;
%min_P = 10;
%max_P = 200;
%min_R = 10;
%max_R = 200;

% Wybór losowych wartości z ograniczeń
M = 37; % randi([min_M, max_M])
N = 25; % randi([min_N, max_N])
P = 39; % randi([min_P, max_P])
R = 105; %randi([min_R, max_R])

% Generowanie węzłów interpolacji na płaszczyźnie
x_coarse = linspace(0, 1, M);
y_coarse = linspace(0, 1, N);
[X_coarse, Y_coarse] = meshgrid(x_coarse, y_coarse);

% Wyznaczenie wartości funkcji oryginalnej w węzłach
F_coarse = sin(X_coarse*2*pi) .* abs(Y_coarse-0.5);
MN = M*N;
xvec_coarse = reshape(X_coarse, MN, 1);
yvec_coarse = reshape(Y_coarse, MN, 1);
fvec_coarse = reshape(F_coarse, MN, 1);

% Macierz Vandermonde'a dla interpolacji 2d
V = zeros(M*N, M*N);
for i = 0:(M-1)
    for j = 0:(N-1)
        V(:, i*N + j + 1) = xvec_coarse.^i .* yvec_coarse.^j;
    end
end

% Współczynniki wielomianu interpolacyjnego
coeffs = V \ fvec_coarse;

% Obliczanie wartości funkcji interpolującej na gęstszej siatce
x_fine = linspace(0, 1, P);
y_fine = linspace(0, 1, R);
[X_fine, Y_fine] = meshgrid(x_fine, y_fine);

F_fine = zeros(size(X_fine));
% zadanie B: zdefiniuj obliczenia wartości wielomianu interpolującego. Rezultat obliczeń zapisz w zmiennej F_fine.
for i = 1:M
    for j = 1:N
        % Obliczanie indeksu i dla współczynnika
        index = (i - 1) * N + j;
        
        % Obliczanie wartości wielomianu interpolacyjnego dla aktualnego indeksu
        F_fine = F_fine + coeffs(index) * X_fine.^(i-1) .* Y_fine.^(j-1);
    end
end

max_abs_F_coarse = max(abs(F_coarse(:)));
max_abs_F_fine = max(abs(F_fine(:)));

% Wyświetlanie komunikatów
if max_abs_F_coarse >= 10
    disp('Maksymalna wartość bezwzględna elementów macierzy F_coarse jest większa lub równa 10.');
end

if max_abs_F_fine <= 100
    disp('Maksymalna wartość bezwzględna elementów macierzy F_fine jest mniejsza lub równa 100.');
end

% Wykres dla punktów interpolacji
subplot(2,1,1)
surf(X_coarse, Y_coarse, F_coarse)
title('Interpolation Points Plot (Coarse Grid)')
xlabel('x')
ylabel('y')
zlabel('Function value')

% Wykres dla gęstszej siatki interpolacyjnej
subplot(2,1,2)
surf(X_fine, Y_fine, F_fine)
title('Interpolation Plot (Fine Grid)')
xlabel('x')
ylabel('y')
zlabel('Function value')
print('zadanie5.png', '-dpng')

end
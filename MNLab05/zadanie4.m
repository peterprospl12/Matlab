function [M,N,P,R,x_coarse,y_coarse,F_coarse,x_fine,y_fine,F_fine] = zadanie4()
P = 20; % liczba unikalnych współrzędnych x punktów dla których będzie obliczana interpolacja
R = 20; % liczba unikalnych współrzędnych y punktów dla których będzie obliczana interpolacja
M = 8; % liczba węzłów interpolacji wzdłuż osi X (stopień wielomianu zmiennej x: M-1)
N = 8; % liczba węzłów interpolacji wzdłuż osi Y (stopień wielomianu zmiennej y: N-1)

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
print('zadanie4.png', '-dpng')

end
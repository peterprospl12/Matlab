function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Gauss_Seidel(N, A, b)
    % A - macierz rzadka z równania macierzowego A * x = b
    % b - wektor prawej strony równania macierzowego A * x = b
    % M - macierz pomocnicza opisana w instrukcji do Laboratorium 3 – sprawdź wzór (7) w instrukcji, który definiuje M jako M_{GS}
    % bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3 – sprawdź wzór (7) w instrukcji, który definiuje bm jako b_{mGS}
    % x - rozwiązanie równania macierzowego
    % err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b)
    % time - czas wyznaczenia rozwiązania x
    % iterations - liczba iteracji wykonana w procesie iteracyjnym metody Gaussa-Seidla
    % index_number - Twój numer indeksu
    index_number = 192594;
    L1 = 4;
    
    if isempty(A) || isempty(b)
        [A, b] = generate_matrix(N, L1);
    end
    
    U = triu(A, 1);
    L = tril(A, -1);
    D = diag(diag(A));
    
    x = ones(N, 1);
    M = -(D+L)\U;
    bm = (D+L)\b;
    iterations = [];
    err_norm = ones(N,1);
    
    tic;
    for i = 1:1000
        iterations = i;
        x = M * x + bm;
        err_norm(i) = norm(A * x - b);
    
        if err_norm(i) < 1E-12 || err_norm(i) == inf || isnan(err_norm(i))
            break;
        end
    end
    err_norm = err_norm(1:iterations);
    time = toc;
end

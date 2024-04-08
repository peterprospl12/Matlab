function time_delta = estimate_execution_time(N)
% time_delta - różnica pomiędzy estymowanym czasem wykonania algorytmu dla zadanej wartości N a zadanym czasem M
% N - liczba parametrów wejściowych

if N <= 0
    error('Incorrect value of time')
end

M = 5000; % [s]

nominator = N^(16/11) + N^((pi^2)/8);
value = nominator / 1000;

time_delta = value - M;

end

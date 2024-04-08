function velocity_delta = rocket_velocity(t)
% velocity_delta - różnica pomiędzy prędkością rakiety w czasie t oraz zadaną prędkością M
% t - czas od rozpoczęcia lotu rakiety dla którego ma być wyznaczona prędkość rakiety

if t <= 0
    error('Incorrect value of time')
end

M = 750; % [m/s]
q = 2700;
u = 2000;
m0 = 150000;
g = 1.622;

velocity = u * log(m0 / (m0 - (q*t))) - g * t;

velocity_delta = velocity - M;

end

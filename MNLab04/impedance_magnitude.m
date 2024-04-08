function impedance_delta = impedance_magnitude(omega)

if omega <= 0
    error('Incorrect value of omega')
end

R = 525;
C = 7e-5;
L = 3;
M = 75; % docelowa wartość modułu impedancji

resistance = 1 / R^2;
wC = omega * C;
wL = 1 / (omega*L);


Z = abs(1/(sqrt(resistance + (wC - wL)^2)));


impedance_delta = Z - M;

end

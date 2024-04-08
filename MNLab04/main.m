
a = 1;
b = 50;
max_iterations = 100;
ytolerance = 1e-12;
% [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,@impedance_magnitude)



a = 1;
b = 50;
max_iterations = 100;
ytolerance = 1e-12;
[xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,@impedance_magnitude)


time = 10 
velocity_delta = rocket_velocity(time)
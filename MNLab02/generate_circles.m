function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
    index_number = 192594; % numer Twojego indeksu
    L1 = 4;
    % n_max wierszy, 3 kolumny, przy czym każda kolumna powinna zawierać kolejno następujące parametry i-tego wylosowanego okręgu: R, X, Y.
    circles = zeros(n_max, 3);
    rand_counts = zeros(n_max,1);
    counter = n_max;
    rand_counter = 1;
    while counter > 0
        R = r_max*rand(1);
        X = R + rand(1) * (a - 2*R);
        Y = R + rand(1) * (a - 2*R);
        cont = false;
        rand_counts(rand_counter) = rand_counts(rand_counter) + 1;
        for i=1:size(circles, 1)
            X1 = circles(i, 1);
            Y1 = circles(i, 2);
            p1 = [X1, Y1];
            p2 = [X, Y];
            dist = norm(p1-p2);
            if dist <= R + circles(i,3)
                cont = true;
                break;
            end
        end
        if cont == true
            continue;
        end
          
        circles(counter, :) = [X,Y,R]; 
        counter = counter - 1;
        rand_counter = rand_counter + 1;
    end
    
    circle_areas = zeros(n_max, 1);
    circle_areas(1,1) = pi * circles(1,3)^2;

    counts_mean = zeros(n_max,1);
    counts_mean(1) = rand_counts(1);
    for i=(2:n_max)
        counts_mean(i) = mean(rand_counts(1:i));
        circle_areas(i,1) = circle_areas(i-1,1) + pi * circles(i,3)^2;
    end
end

clear all
close all
format compact

n_max = 200;
a = 40;
r_max = a /2; 

[circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max);
plot_circles(a, circles); 
print -dpng zadanie1.png 

plot_circle_areas(circle_areas);
plot_counts_mean(counts_mean);

[numer_indeksu, Edges, I, B, A, b, r] = page_rank();
plot_PageRank(r);
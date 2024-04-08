function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
numer_indeksu = 192594;
L1 = 4;
L2 = 5;
d = 0.85;
N = 8;
Edges = [1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6, 6, 6, 7, 8;
         4, 6, 3, 4, 5, 5, 6, 7, 5, 6, 4, 6, 4, 7, 8, 6, 3];
I = speye(N,N);
B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
A = spdiags(1./sum(B).',0,N,N);
b = ones(N,1) * (1-d)/N;

M = I - d * B * A;

r = M \ b;

end

A = gaussian_kernel(11,1);
T = [0 1 0; 1 -4 1; 0 1 0];
B = conv2(A,T);
mesh(B);
I1 = imread('lena.bmp');
I1 = im2double(I1);

T = gaussian_kernelXY(5,1);
Tt = transpose(T);

A1 = conv2(I1, T);
A11 = conv2(A1, Tt);
figure; imshow(A11);

A2 = conv2(I1, gaussian_kernel(5,1));
figure; imshow(A2); 
%B2 = conv2(I1,gaussian_kernel(11,3));
%figure; imshow(B2); 

A = abs(A11-A2);figure; imshow(A.*2550);
sum(sum(A))

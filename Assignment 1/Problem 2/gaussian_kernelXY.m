function [matrix] = gaussian_kernelXY( w,s )
%gaussian_kernelXY function for gaussian blur
%   takes the input width (w) and variance(s) and returns a 1D array.
if nargin < 2
    error('Enter two arrguments');
end
half = double(floor(w/2));
x = linspace(-half, half, w);
matrix = exp(- x.^2 / 2*s);
matrix = matrix / (sqrt(2*pi*s));
matrix = matrix / sum(matrix);

end


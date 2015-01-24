function [matrix ] = gaussian_kernel( w,s )
%gaussian_kernel function for gaussian blur
%   takes the input width (w) and variance(s) and returns a 2D array.
if nargin < 2
    error('Enter two arrguments');
end
half = double(floor(w/2));
SumXY = 0;
for x = 1:w
    for y = 1:w
        p = -half + x -1 ;
        q = -half + y -1 ;
        NormXY = p^2 + q^2 ;
        exponent = exp(-NormXY/(2*s)) ;
        matrix(x,y) = exponent/(2*pi*s) ;
        SumXY = SumXY + matrix(x,y) ;
    end
end    
     
matrix(x,y) = matrix(x,y) / SumXY;
end


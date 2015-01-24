function [ temp ] = zero_crossing_LOG( I, thrs )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

I = im2double(I);

% laplacian of gaussian
A = gaussian_kernel(11,1);
T = [0 1 0; 1 -4 1; 0 1 0];
B = conv2(A,T);

zero_crossing = conv2(I,B,'same');

if(thrs > 1)
    thrs = thrs/255;
end

temp = zeros(512,512);
% row
for i = 2:size(zero_crossing,1)-1   
% col
    for j = 2:size(zero_crossing,2)-1
        if(( (zero_crossing(i-1,j)* zero_crossing(i+1,j)<0) &&  abs(zero_crossing(i-1,j)-zero_crossing(i+1,j)) > thrs) || ((zero_crossing(i,j-1)* zero_crossing(i,j+1)<0) && abs(zero_crossing(i,j-1)-zero_crossing(i,j+1))>thrs))
            temp(i,j) = 1;
        
        else
            temp(i,j) = 0;
        end    
    end
end

end


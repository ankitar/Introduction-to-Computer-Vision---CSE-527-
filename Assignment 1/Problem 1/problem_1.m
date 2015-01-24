function [ image ] = problem_1( I,w,s)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

I = im2double(I);
A = conv2(I, gaussian_kernel(w,s));
figure; 
image = imshow(A);
end


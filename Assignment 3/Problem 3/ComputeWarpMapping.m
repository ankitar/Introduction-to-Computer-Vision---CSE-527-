function [ A ] = ComputeWarpMapping( img1pts, img2pts )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

A = img1pts \ img2pts ; 

end

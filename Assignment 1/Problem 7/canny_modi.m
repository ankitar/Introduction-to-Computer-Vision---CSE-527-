function [ hyst ] = canny_modi( I )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


I = im2double(I);
hesterisis = canny(I,3,1);

hesterisis_low = (hesterisis > 0.1);
hesterisis_high = (hesterisis > 0.25);

hyst = zeros(size(hesterisis_high,1), size(hesterisis_high,2));

for r = 2: size(hesterisis_high,1)-1
    for c = 2: size(hesterisis_high,2)-1
        if(hesterisis_high(r,c))
            hyst(r,c) = 1;
        
        elseif(hyst(r-1,c) || hyst(r,c-1) || hyst(r-1,c+1)|| hyst(r-1,c-1))
             if(hesterisis_low(r,c)~=0)
                hyst(r,c)=1;
             end
        end    
    end
end
end


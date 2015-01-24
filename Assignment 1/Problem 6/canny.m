function [ non_max ] = canny( I, w,s )
%canny function to implement canny edge detection
%   takes four variable image name 'I', threshold value 'thres', width
%   'w' and sigma 's'. 

if nargin < 3
    error('Enter three arrguments');
end

I = im2double(I);

% CANNY_ENHANCER
gaussian = gaussian_kernelXY(w,s);

IX = conv2(I, gaussian, 'same');
IY = conv2(I, gaussian', 'same');

grad_x = gradient(IX);
grad_y = gradient(IY);


magnitude = sqrt(grad_x.^2 + grad_y.^2);
magnitude = magnitude/max(max(magnitude));

non_max = magnitude;

% NONMAX_SUPPRESSION


for i = 2 : size(magnitude,1)-1
    for j = 2 : size(magnitude,2)-1
        
        tangent = grad_y(i,j)/grad_x(i,j);
        
        if(grad_x(i,j) == 0)
            if((magnitude(i,j) < magnitude(i-1,j) || magnitude(i,j) < magnitude(i+1,j)))
                non_max(i,j)=0.0;
            end
        
        elseif(tangent == 0)
            if((magnitude(i,j) < magnitude(i,j-1) || magnitude(i,j) < magnitude(i,j+1)))
                non_max(i,j) = 0.0;        
            end
             
        
        elseif(tangent > 0 && tangent <= 1)
            inter1 = tangent * magnitude(i-1,j+1) + (1-tangent)*magnitude(i,j+1);
            inter2 = tangent * magnitude(i+1,j-1) + (1-tangent)*magnitude(i,j-1);
     
            if(magnitude(i,j) < inter1 || magnitude(i,j) < inter2)
                non_max(i,j) = 0.0;

            end
             
        elseif(tangent > 0 && tangent >= 1)
            inter1 = (1/tangent) * magnitude(i-1,j+1) + (1-(1/tangent))*magnitude(i-1,j);
            inter2 = (1/tangent) * magnitude(i+1,j-1) + (1-tangent)*magnitude(i+1,j);
     
            if(magnitude(i,j) < inter1 || magnitude(i,j) < inter2)
                non_max(i,j) = 0.0;

            end
        
        elseif(tangent < 0 && abs(tangent) < 1)
            inter1 = tangent * magnitude(i+1,j+1) + (1-tangent)*magnitude(i,j+1);
            inter2 = tangent * magnitude(i-1,j-1) + (1-tangent)*magnitude(i-1,j);
            
            if(magnitude(i,j) < inter1 || magnitude(i,j) < inter2)
                non_max(i,j) = 0.0;

            end
            
        elseif(tangent < 0 && abs(tangent) > 1)
            inter1 = (1/tangent) * magnitude(i+1,j+1) + (1-(1/tangent))*magnitude(i+1,j);
            inter2 = (1/tangent) * magnitude(i-1,j-1) + (1-(1/tangent))*magnitude(i-1,j);
            
            if(magnitude(i,j) < inter1 || magnitude(i,j) < inter2)
                non_max(i,j) = 0.0;
            end    
        end
                
        
    end
end

end


I1 = imread('humanity01.JPG');
I2 = imread('humanity02.JPG');

I1 = im2double(I1);
I2 = im2double(I2);

x_2 = [98 456 1 ; 541 132 1; 233 408 1; 226 531 1; 584 511 1; 543 357 1];
x_1 = [730 452 1; 1155 126 1; 857 430 1; 849 549 1; 1222 529 1; 1173 367 1];
A = ComputeWarpMapping(x_1, x_2);


[newImage, min_x, min_y] = WarpImage(I1,A);

finalMosaic = newImage;
imSize = size(finalMosaic);

rr = ceil(abs(min_y));
cc = ceil(abs(min_x));
S = size(I2);
newrow = S(1) + rr;
newcol = S(2) + cc;
I3 = zeros(newrow,newcol,3);

for r = 1:S(1)
    for c = 1:S(2)
        I3(r+rr,c+cc,1:3) = I2(r,c,1:3);
    end
end

for r = 1:imSize(1)
    for c = 1:imSize(2)
        for i = 1:3
            if finalMosaic(r,c,i) ~= 0 && I3(r,c,i) ~= 0
                finalMosaic(r,c,i) = (finalMosaic(r,c,i)+I3(r,c,i))/2;
            elseif finalMosaic(r,c,i) == 0 && I3(r,c,i) ~= 0
                finalMosaic(r,c,i) = I3(r,c,i);
            else
                finalMosaic(r,c,i) = finalMosaic(r,c,i);
            end
        end
    end
end



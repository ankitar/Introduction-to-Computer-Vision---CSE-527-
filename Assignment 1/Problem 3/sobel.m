function [magnitude, direction] = sobel(I, th)

 I = im2double(I);
kernel_x = [-1, 0, +1; -2, 0, +2; -1, 0, +1];
kernel_y = [+1, +2, +1; 0, 0, 0; -1, -2, -1];

sobel_x = conv2(I, kernel_x, 'same');
sobel_y = conv2(I, kernel_y, 'same');

magnitude = sqrt(sobel_x.^2 + sobel_y.^2);
direction = atan2(sobel_y, sobel_x);

threshold = (magnitude > th);  
threshold = threshold.* magnitude;  


figure;
imshow(magnitude,'InitialMagnification','fit');
title('sobel edge detector on building.bmp using magnitude');

figure;
imshow(threshold, 'InitialMagnification','fit');
title('sobel edge detector on building.bmp using threshold');



end






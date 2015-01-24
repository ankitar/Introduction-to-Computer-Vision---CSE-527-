%loading image
I = imread('building.bmp');
imshow(I);
I = im2double(I);

temp = zero_crossing_LOG(I,0.05);

figure;
imshow(temp);
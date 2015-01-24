%% 11
I1 = imread('lena.bmp');
I1 = im2double(I1);
A1 = canny_modi(I1);
figure; imshow(A1); imwrite(A1,'lenacannyM.bmp')


%% 22
I2 = imread('lena_noise.bmp');
I2 = im2double(I2);
A2 = canny_modi(I2);
figure; imshow(A2); imwrite(A2,'lena_noisecannyM.bmp')


I3 = imread('barbara.bmp');
I3 = im2double(I3);
A3 = canny_modi(I3);
figure; imshow(A3); imwrite(A3,'barbaracannyM.bmp')

I4 = imread('barbara_noise.bmp');
I4 = im2double(I4);
A4 = canny_modi(I4);
figure; imshow(A4); imwrite(A4,'barbara_noisecannyM.bmp')

I5 = imread('mandrill.bmp');
I5 = im2double(I5);
A5 = canny_modi(I5);
figure; imshow(A5); imwrite(A5,'mandrillcannyM.bmp')

I6 = imread('mandrill_noise.bmp');
I6 = im2double(I6);
A6 = canny_modi(I6);
figure; imshow(A6); imwrite(A6,'mandrill_noisecannyM.bmp')

I7 = imread('building.bmp');
I7 = im2double(I7);
A7 = canny_modi(I7);
figure; imshow(A7); imwrite(A7,'buildingcannyM.bmp')

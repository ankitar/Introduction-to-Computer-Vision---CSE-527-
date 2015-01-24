
I1 = imread('wadham001.pgm');
I1 = imresize(I1, 0.5);
I1 = im2double(I1);
[ pos, scale, orient, desc ] = SIFT( I1 );


I2 = imread('wadham003.pgm');
I2 = imresize(I2, 0.5);
I2 = im2double(I2);
[ pos2, scale2, orient2, desc2 ] = SIFT( I2 );

[database] = add_descriptors_to_database( I1 , pos, scale, orient, desc);

[IM_IDX, TRANS, THETA, RHO, DESC_IDX, NN_IDX, WGHT] = hough( database, pos2, scale2, orient2, desc2);
[maxWGHT,maxIndices] = max(WGHT);

firstSIFTpos = database.pos(NN_IDX{maxIndices},:);
secondSIFTpos = pos2(DESC_IDX{maxIndices},:);

[aff] = fit_robust_affine_transform(secondSIFTpos', firstSIFTpos');


[result, A ] = imWarpAffine(I1, aff, 1);
imshow(result)
disp(aff);

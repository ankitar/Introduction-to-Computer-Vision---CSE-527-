function [aff,A] = problem1(I)

I = im2double(I);

% STEP 1
[ pos, scale, orient, desc ] = SIFT( I );

% STEP 2

[database] = add_descriptors_to_database( I , pos, scale, orient, desc);


% STEP 3

A= [0 1 0 ; -1 0 0 ];
[result,A] = imWarpAffine(I, A, 0);

[ pos2, scale2, orient2, desc2 ] = SIFT( result );


% STEP 4

[IM_IDX, TRANS, THETA, RHO, DESC_IDX, NN_IDX, WGHT] = hough( database, pos2, scale2, orient2, desc2);

% STEP 5

[maxWGHT,maxIndices] = max(WGHT);

originalSIFTpos = pos(NN_IDX{maxIndices},:);
rotatedSIFTpos = pos2(DESC_IDX{maxIndices},:);
originalSIFTscale = scale(NN_IDX{maxIndices},:);

% STEP 6 
[aff] = fit_robust_affine_transform(rotatedSIFTpos', originalSIFTpos');

end
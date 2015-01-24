addpath('images');

%% STEP 1

% Model for phone image
phone = pgmRead('phone0003.pgm');
phone = imresize(phone, [256 256]);
phone = im2double(phone);


% Model for nutshell image
nutshell = pgmRead('nutshell0003.pgm');
nutshell = imresize(nutshell, [256 256]);
nutshell = im2double(nutshell);

%% STEP 2
% SHIFT on both the images
[ pos_phone, scale_phone, orient_phone, desc_phone ] = SIFT( phone );
[ pos_nutshell, scale_nutshell, orient_nutshell, desc_nutshell ] = SIFT(nutshell);

% Adding the SIFT features from both the images to database
[database] = add_descriptors_to_database( phone , pos_phone, scale_phone, orient_phone, desc_phone);
[database] = add_descriptors_to_database( nutshell, pos_nutshell, scale_nutshell, orient_nutshell, decs_nutshell );

%% STEP 3

% Loading images of phone to test

phone1 = pgmRead('phone0007.pgm');
phone1 = imresize(phone1, [256 256]);
phone1 = im2double(phone1);

phone4 = pgmRead('phone0017.pgm');
phone4 = imresize(phone4, [256 256]);
phone4 = im2double(phone4);

phone5 = pgmRead('phone0018.pgm');
phone5 = imresize(phone5, [256 256]);
phone5 = im2double(phone5);


% Loading images of nutshell to test
nutshell1 = pgmRead('nutshell0007.pgm');
nutshell1 = imresize(nutshell1, [256 256]);
nutshell1 = im2double(nutshell1);

nutshell2 = pgmRead('nutshell0008.pgm');
nutshell2 = imresize(nutshell2, [256 256]);
nutshell2 = im2double(nutshell2);

nutshell3 = pgmRead('nutshell0009.pgm');
nutshell3 = imresize(nutshell3, [256 256]);
nutshell3 = im2double(nutshell3);


nutshell5 = pgmRead('nutshell0011.pgm');
nutshell5 = imresize(nutshell5, [256 256]);
nutshell5 = im2double(nutshell5);



% Calculating SIFT features for the test images of phone
[ pos_phone1, scale_phone1, orient_phone1, desc_phone1 ] = SIFT( phone1 );

[ pos_phone4, scale_phone4, orient_phone4, desc_phone4 ] = SIFT( phone4 );

[ pos_phone5, scale_phone5, orient_phone5, desc_phone5 ] = SIFT( phone5 );

% Calculating SIFT features for test images of nutshell
[ pos_nutshell1, scale_nutshell1, orient_nutshell1, desc_nutshell1 ] = SIFT( nutshell1 );

[ pos_nutshell2, scale_nutshell2, orient_nutshell2, desc_nutshell2 ] = SIFT( nutshell2 );

[ pos_nutshell3, scale_nutshell3, orient_nutshell3, desc_nutshell3 ] = SIFT( nutshell3 );

[ pos_nutshell5, scale_nutshell5, orient_nutshell5, desc_nutshell5 ] = SIFT( nutshell5 );


%% All the computations shown below is for one image, as calculating this for all images together was taking a lot of time.

% Calculating Hough for phone images
[IM_IDX_phone1, TRANS_phone1, THETA_phone1, RHO_phone1, DESC_IDX_phone1, NN_IDX_phone1, WGHT_phone1] = hough( database, pos_phone1, scale_phone1, orient_phone1, desc_phone1);
[maxWGHT_phone1,maxIndices_phone1] = max(WGHT_phone1);

% Calculating Hough for nutshell images
[IM_IDX_nutshell1, TRANS_nutshell1, THETA_nutshell1, RHO_nutshell1, DESC_IDX_nutshell1, NN_IDX_nutshell1, WGHT_nutshell1] = hough( database, pos_nutshell1, scale_nutshell1, orient_nutshell1, desc_nutshell1);
[maxWGHT_nutshell1,maxIndices_nutshell1] = max(WGHT_nutshell1);

% Final Results for phone image 
modelSIFTpos_phone = database.pos_phone(NN_IDX_phone1{maxIndices_phone1},:);
phone1SIFTpos = pos_phone1(DESC_IDX_phone1{maxIndices},:);

[aff_phone1] = fit_robust_affine_transform(phone1SIFTpos', modelSIFTpos_phone');


[result_phone1, A_phone1 ] = imWarpAffine(phone, aff_phone1, 1);
imshow(result_phone1)

% Final Results for nutshell image
modelSIFTpos_nutshell = database.pos_nutshell(NN_IDX_nutshell1{maxIndices_nutshell1},:);
nutshell1SIFTpos = pos_nutshell1(DESC_IDX_nutshell1{maxIndices_nutshell},:);

[aff_nutshell1] = fit_robust_affine_transform(nutshell1SIFTpos', modelSIFTpos_nutshell');

[result_nutshell1, A_nutshell1 ] = imWarpAffine(nutshell, aff_nutshell1, 1);
imshow(result_nutshell1)
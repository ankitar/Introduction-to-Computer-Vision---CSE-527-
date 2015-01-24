clear;
make;
posTrainImageDir = dir('INRIAPerson/train_64x128_H96/pos');
negTrainImageDir = dir('INRIAPerson/Train/neg');
rect = [0 0 96 160];
%/home/ankit/Documents/MATLAB/Assignement 4/

%cropping negative image to one size
for i=3:length(negTrainImageDir)
    img = negTrainImageDir(i).name;
    cropimage = imcrop(imread(img),rect);
    folder = 'INRIAPerson/train_64x128_H96/neg/';
    suffix = img(1:end-4);
    newname = [suffix 'a'];
    newimagename = [folder newname '.png'];
    imwrite(cropimage, newimagename);
end

neg_resized_TrainImageDir = dir('INRIAPerson/train_64x128_H96/neg/');

% for all the resolution space calculating the vl_hog.

cell_size = [8 6 4 3];
block_size = [16 12 8 6]; 
W = [];
B = [];
for r = 1:4
    scale = 1/(2^(r-1));
    hog_neg = [];
    for i=4:1200
        img2 = neg_resized_TrainImageDir(i).name;
        downsample_image = imresize(imread(img2),scale);
        im_size = size(downsample_image);
        image_block = im2single(downsample_image);
        hog = vl_hog(image_block,cell_size(:,r));
        hog_r = reshape(hog, [], 1);
        hog_neg = [hog_neg hog_r];
    end

    hog_pos = [];
    for i=3:1000
        img3 = posTrainImageDir(i).name;
        downsample_image = imresize(imread(img3),scale);
        im_size = size(downsample_image);
        image_block = im2single(downsample_image);
        hog = vl_hog(image_block,cell_size(:,r));
        hog_r = reshape(hog, [], 1);
        hog_pos = [hog_pos hog_r];
    end

    p = size(hog_pos);
    n = size(hog_neg);

    hog_pos_neg = [hog_pos hog_neg]; 
    label = [];
    for i=1:p(2)
        label = [label 1];
    end

    for i = 1:n(2)
        label = [label -1];
    end

    % SVM train
    [w ,b] = vl_svmtrain(hog_pos_neg, label, 0.1);
    W{r} = w;
    B{r} = b;
    
    %Evaluation - ploting roc curve
    
    vl_roc(label,hog_pos_neg);
end

save('w1.mat','W');
save('b1.mat','B');
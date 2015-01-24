load('w1.mat');
load('b1.mat');

posTestImageDir = dir('INRIAPerson/Test/pos');
negTestImageDir = dir('INRIAPerson/Test/neg');

detectionWindow = [96 160];
cell_size = [8 6 4 3];
block_size = [16 12 8 6];
stride = [8 4 2 1];
label = [];
score_all = [];

for i=30:2:60
testImage = im2single((imread(posTestImageDir(i).name)));
orgImgSize = size(testImage);


for scl = 1:4
    scale_scl = 1/(2^(scl-1));
    testImage_resized_sclSpace = imresize(testImage,scale_scl);
    imgSize_scaleSpace = size(testImage_resized_sclSpace);
    score_matrix = zeros(imgSize_scaleSpace(1),imgSize_scaleSpace(2));
    for res = 4:-1:1
        scale_res = 1/(2^(res-1));
        window = detectionWindow*scale_res;
        testImage_resized = imresize(testImage_resized_sclSpace,scale_res);
        imgSize = size(testImage_resized);
        for y=1:stride(res):(imgSize(1)-(window(1)))
            for x=1:stride(res):(imgSize(2)-(window(2)))
                imageDetection_block = testImage_resized(y:(y+window(1)-1), x:(x+window(2)-1), 1:3);
                hogur = vl_hog(imageDetection_block,cell_size(:,res));
                hog = reshape(hogur, [],1);
                hog_double = im2double(hog);
                score = hog_double.'*W{res} + B{res};
                if score > 0
                    label = [label 1];
                    score_all = [score_all score];
                end
            end
        end 
    end
    
end
end

for i=30:2:60
testImage = im2single((imread(negTestImageDir(53).name)));
% testImage = im2single((imread(posTestImageDir(77).name)));
orgImgSize = size(testImage);



for scl = 1:4
    scale_scl = 1/(2^(scl-1));
    testImage_resized_sclSpace = imresize(testImage,scale_scl);
    imgSize_scaleSpace = size(testImage_resized_sclSpace);
    score_matrix = zeros(imgSize_scaleSpace(1),imgSize_scaleSpace(2));
    for res = 4:-1:1
        scale_res = 1/(2^(res-1));
        window = detectionWindow*scale_res;
        testImage_resized = imresize(testImage_resized_sclSpace,scale_res);
        imgSize = size(testImage_resized);
        for y=1:stride(res):(imgSize(1)-(window(1)))
            for x=1:stride(res):(imgSize(2)-(window(2)))
                imageDetection_block = testImage_resized(y:(y+window(1)-1), x:(x+window(2)-1), 1:3);
                hogur = vl_hog(imageDetection_block,cell_size(:,res));
                hog = reshape(hogur, [],1);
                hog_double = im2double(hog);
                score = hog_double.'*W{res} + B{res};
                if score > 0
                    label = [label -1];
                    score_all = [score_all score];
                end
            end
        end 
    end
end
end

vl_roc(label,score_all)

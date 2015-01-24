function [ img1warp, min_x, min_y ] = WarpImage( img1, A )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

image_size = size(img1);
max_row = image_size(1);
max_coloumn = image_size(2);

point1 = [1 1 1] * A;
point2 = [max_coloumn 1 1] * A;
point3 = [1 max_row 1] * A;
point4 = [max_coloumn max_row 1] * A;

min_x = min(min(point1(1), point2(1)), min(point3(1), point4(1)));
max_x = max(max(point1(1), point2(1)), max(point3(1), point4(1)));

min_y = min(min(point1(2), point2(2)), min(point3(2), point4(2)));
max_y = max(max(point1(2), point2(2)), max(point3(2), point4(2)));

if min_y < 0 && max_y > max_row
    row = ceil(max_y - min_y);
elseif min_y < 0 && max_y < max_row
    row = ceil(max_row - min_y);
elseif min_y > 0 && max_y > max_row
    row = max_y;
elseif min_y > 0 && max_y < max_row
    row = max_row;
end

if min_x < 0 && max_x > max_coloumn
    coloumn = ceil(max_x - min_x);
elseif min_x < 0 && max_x < max_coloumn
    coloumn = ceil(max_coloumn - min_x);
elseif min_x > 0 && max_x > max_coloumn
    coloumn = max_x;
elseif min_x> 0 && max_x < max_coloumn
    coloumn = max_coloumn;
end


img1warp = zeros(row, coloumn, 3);
B = inv(A);

% backward implementation

for r = ceil(min_y):ceil(max_y)
    for c = ceil(min_x):ceil(max_x)
        oldPoint = [c r 1] * B;
        if oldPoint(1) < max_coloumn && oldPoint(2) < max_row && oldPoint(1) > 0 && oldPoint(2) > 0
            img1warp(ceil(r-min_y),ceil(c-min_x),1:3) = img1(ceil(oldPoint(2)),ceil(oldPoint(1)), 1:3);
        end
    end
end



% Forward Implementation.

% for r = 1:max_row
%     for c = 1:max_coloumn
%         newPoints = [c r 1] * A;
%         
%         % row Shifting
%         if min_y < 0
%            newPoints(2) = ceil(newPoints(2) - min_y ) + 1;
%         else
%             newPoints(2) = ceil(newPoints(2));
%         end
% 
%         % coloumn shifting
%         if min_x < 0
%             newPoints(1) = ceil(newPoints(1) - min_x ) + 1;
%         else
%             newPoints(1) = ceil(newPoints(1));
%         end
%         
%         img1warp(newPoints(2),newPoints(1),1:3) = img1(r,c,1:3);
% 
%           
%     end
% end
% 
% end


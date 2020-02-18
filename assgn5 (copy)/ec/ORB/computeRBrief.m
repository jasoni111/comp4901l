function [desc, locs] = computeRBrief(img, locs_in, angles_in)
% computeOrbDescriptors in opencv
% https://github.com/opencv/opencv/blob/master/modules/features2d/src/orb.cpp
persistent cv_Pattern
persistent pattern_size

if isempty(cv_Pattern)
    cv_Pattern = CV_Pattern();
    pattern_size=max(cv_Pattern(:))-min(cv_Pattern(:));
end


img_width = size(img, 2);
img_height = size(img, 1);

half = floor(pattern_size/2);
halfup = ceil(pattern_size/2);

counter = 1;
locs = zeros(1, 2);
angles = zeros(1, 1);
for i = 1:length(locs_in)
    x = locs_in(i, 1);
    y = locs_in(i, 2);
    
    % If the requested location is close to the edges, we may not have
    % be able to generate a descriptor for them. Skip this.
    if x <= pattern_size || x >= (img_width-pattern_size) || y <= pattern_size || y >= (img_height-pattern_size)
        continue;
    end
    
    locs(counter, :) = locs_in(i, :);
    angles(counter, :) = angles_in(i, :);
    counter = counter + 1;
end

n = 256;
desc = zeros(size(locs, 1), n);

for i = 1:size(locs,1)
    pattern1 = round([cos(angles(i)),-sin(angles(i));sin(angles(i)),cos(angles(i))]*cv_Pattern(:,1:2)')'; 
    pattern2 = round([cos(angles(i)),-sin(angles(i));sin(angles(i)),cos(angles(i))]*cv_Pattern(:,3:4)')';
    for j = 1:256
        p1 = img(locs(i,2) + pattern1(j,2),locs(i,1) + pattern1(j,1));
        p2 = img(locs(i,2) + pattern2(j,2),locs(i,1) + pattern2(j,1));
        desc(i,j) = double(p1 < p2);
    end
end

% for i = 1:length(locs)
%     x = locs(i, 1);
%     y = locs(i, 2);
%     
%     patch = img(y-half:y+half, x-half:x+half);
%     for j = 1:256
%         val_x = patch(compareX(j));
%         val_y = patch(compareY(j));
%         bit_value = (val_x < val_y);
%         
%         desc(i, j) = bit_value;
%     end
% end


% for i = 1:size(locs_in,1)
%     pattern1 = round([cos(angle(i)),-sin(angle(i));sin(angle(i)),cos(angle(i))]*patterns(:,1:2)')'; 
%     pattern2 = round([cos(angle(i)),-sin(angle(i));sin(angle(i)),cos(angle(i))]*patterns(:,3:4)')';
%     for j = 1:256
%         p1 = I(corners(i,2) + pattern1(j,2),corners(i,1) + pattern1(j,1));
%         p2 = I(corners(i,2) + pattern2(j,2),corners(i,1) + pattern2(j,1));
%         features(i,j) = double(p1 < p2);
%     end
% end



% 
% 
% load('../data/brief-indices.mat');
% img_width = size(img, 2);
% img_height = size(img, 1);
% 
% half = floor(pattern_size/2);
% halfup = ceil(pattern_size/2);
% 
% counter = 1;
% locs = zeros(1, 2);
% for i = 1:length(locs_in)
%     x = locs_in(i, 1);
%     y = locs_in(i, 2);
%     
%     % If the requested location is close to the edges, we may not have
%     % be able to generate a descriptor for them. Skip this.
%     if x <= pattern_size || x >= (img_width-pattern_size) || y <= pattern_size || y >= (img_height-pattern_size)
%         continue;
%     end
%     
%     locs(counter, :) = locs_in(i, :);
%     counter = counter + 1;
% end
% 
% n = 256;
% desc = zeros(size(locs, 1), n);
% 
% % Approximate decimal feature locations. A more accurate version
% % would use interp
% locs = round(locs);
% 
% for i = 1:length(locs)
%     x = locs(i, 1);
%     y = locs(i, 2);
%     
%     patch = img(y-half:y+half, x-half:x+half);
%     for j = 1:256
%         val_x = patch(compareX(j));
%         val_y = patch(compareY(j));
%         bit_value = (val_x < val_y);
%         
%         desc(i, j) = bit_value;
%     end
% end
% 
end
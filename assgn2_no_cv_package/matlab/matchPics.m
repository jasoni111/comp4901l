function [locs1, locs2] = matchPics( I1, I2 )
%MATCHPICS Extract features, obtain their descriptors, and match them!

%% Convert images to grayscale, if necessary
if ndims(I1) == 3
    I1=rgb2gray(I1);
end;

if ndims(I2) == 3
    I2=rgb2gray(I2);
end;

% figure
% imshow(I1);
% 
% 
% figure
% imshow(I2);
%% Detect features in both images
I1_features=fast_corner_detect_9(I1,50);
I2_features=fast_corner_detect_9(I2,50);

%% Obtain descriptors for the computed feature locations
[I1_desc, I1_locs] = computeBrief(I1, I1_features);
[I2_desc, I2_locs] = computeBrief(I2, I2_features);

%% Match features using the descriptors
indexPairs = customMatchFeatures(I1_desc,I2_desc);

locs1=zeros(size(indexPairs,1),2);
locs2=zeros(size(indexPairs,1),2);

for i=1:size(indexPairs,1)
    locs1(i,:)=I1_locs(indexPairs(i,1),:);
    locs2(i,:)=I2_locs(indexPairs(i,2),:);
end

end


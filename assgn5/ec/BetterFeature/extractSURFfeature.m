function [feature] = extractSURFfeature(I)

if size(I,3)==3
 I=rgb2gray(I);
end
points = detectSURFFeatures(I);
[feature, ~] = extractFeatures(I, points);
end

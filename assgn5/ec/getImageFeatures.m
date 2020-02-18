function [ h ] = getImageFeatures(wordMap, dictionarySize)
%GETIMAGEFEATURES Summary of this function goes here
%   Detailed explanation goes here
h=histcounts(wordMap,1:dictionarySize+1);

h=h./size(wordMap(:),1);
end


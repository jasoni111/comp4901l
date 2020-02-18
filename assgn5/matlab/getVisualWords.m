function [wordMap] = getVisualWords(I, filterBank, dictionary)%GETVISUALWORDS Summary of this function goes here
% the dictionary passed in from batchToVisualWords is actually (dictionary^transpose) ._.
% changed that side instead
[filterResponses] = extractFilterResponses(I, filterBank);
filterResponses=reshape(filterResponses,[],size(filterResponses,3));

dist = pdist2(dictionary, filterResponses);
[~,Idx]=min(dist);
% wordMap=histcounts(Idx,1:size(dictionary,1));
wordMap=reshape(Idx,size(I,1),size(I,2));
figure
image(wordMap)
colormap(hsv(100))

end


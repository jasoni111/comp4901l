function [wordMap] = getSURFVisualWords(I, dictionary)%GETVISUALWORDS Summary of this function goes here
% the dictionary passed in from batchToVisualWords is actually (dictionary^transpose) ._.
% changed that side instead
[filterResponses] = extractSURFfeature(I);
% filterResponses=reshape(filterResponses,[] ...
%     ,size(filterResponses,3));

dist = pdist2(dictionary, filterResponses);
[~,wordMap]=min(dist);
% wordMap=reshape(Idx,size(I,1),size(I,2));
end


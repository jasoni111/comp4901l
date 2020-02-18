addpath('../ec/svmlib/matlab')

method='Random'
load('../data/traintest.mat');
load('dictionaryRandom.mat')
% load( append('../matlab/vision',method,'.mat'));
load( 'visionSVM.mat');


% 
% RandomPredictionchi=zeros(size(test_imagenames,2) ,40);
% RandomPredictionL2=zeros(size(test_imagenames,2) ,40);
% 
mapPath = append('../data/',method,'/');
FeatureM=zeros(size(test_imagenames,2),...
    size(dictionary, 1) );
for i=1:size(test_imagenames,2)
% i=1;
    fname=test_imagenames{i};
    fname(end-2:end)='mat';
    wordmap = append(mapPath,fname );
    load(wordmap);
    h = getImageFeatures(wordMap, size(dictionary, 1) );
    FeatureM(i,:)=h;
end
    svmpredict(test_labels',FeatureM,model);
    
    
% %     imgname=test_imagenames{i};
% %     I=imread(append('../data/',imgname) );
% %     wordMap = getVisualWords(I, filterBank, dictionary);
% %     h = getImageFeatures(wordMap, size(dictionary,1) );
%     d = getImageDistance(h,trainFeatures,'chi2');
%     for numNN=1:40
%         Result=knnPredict(d,numNN,trainLabels);
%         RandomPredictionchi(i,numNN)=Result;
%     end
%     
%     d = getImageDistance(h,trainFeatures,'euclidean');
%     for numNN=1:40
%         Result=knnPredict(d,numNN,trainLabels);
%         RandomPredictionL2(i,numNN)=Result;
%     end
% end
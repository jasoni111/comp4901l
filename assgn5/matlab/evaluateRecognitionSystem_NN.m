clear all
close all
% method=["Random";"Harris"]
method='Random'
load('../data/traintest.mat');
load( append('../matlab/vision',method,'.mat'));
RandomPredictionchi=zeros(size(test_imagenames,2) ,1);
RandomPredictionL2=zeros(size(test_imagenames,2) ,1);
mapPath = append('../data/',method,'/');
numNN=1;

for i=1:size(test_imagenames,2)
    fname=test_imagenames{i};
    fname(end-2:end)='mat';
    wordmap = append(mapPath,fname );
    load(wordmap);
    h = getImageFeatures(wordMap, size(dictionary, 1));
%     imgname=test_imagenames{i};
%     I=imread(append('../data/',imgname) );
%     wordMap = getVisualWords(I, filterBank, dictionary);
%     h = getImageFeatures(wordMap, size(dictionary,1) );
    d = getImageDistance(h,trainFeatures,'chi2');
    Result=knnPredict(d,numNN,trainLabels);
    RandomPredictionchi(i,numNN)=Result;
    
    d = getImageDistance(h,trainFeatures,'euclidean');
    Result=knnPredict(d,numNN,trainLabels);
    RandomPredictionL2(i,numNN)=Result;
end

Correct = RandomPredictionchi==test_labels';
Correct = mean(Correct,1);
[bstRate,bstIdx]=max(Correct);


figure('Name',"Random chi2, correct rate: "+bstRate+" T="+bstIdx,'NumberTitle','off')
fprintf('Random chi2 correct rate: %d T=%d'...
,bstRate,bstIdx )
C = confusionmat(test_labels',RandomPredictionchi(:,bstIdx) )
confusionchart(C);
title("Random chi2, correct rate: "+bstRate+" T="+bstIdx)


Correct = RandomPredictionL2==test_labels';
Correct = mean(Correct,1);
[bstRate,bstIdx]=max(Correct);

figure('Name',"Random euclidan, correct rate: "+bstRate+" T="+bstIdx,'NumberTitle','off')
fprintf('Random euclidan correct rate: %d T=%d'...
,bstRate,bstIdx )
C = confusionmat(test_labels',RandomPredictionL2(:,bstIdx) )
confusionchart(C);
title("Random euclidan, correct rate: "+bstRate+" T="+bstIdx)

%% Harris
method='Harris'
load('../data/traintest.mat');
load( append('../matlab/vision',method,'.mat'));
HarrisPredictionchi2=zeros(size(test_imagenames,2) ,1);
HarrisPredictionL2=zeros(size(test_imagenames,2) ,1);
mapPath = append('../data/',method,'/');
numNN=1;


for i=1:size(test_imagenames,2)
    fname=test_imagenames{i};
    fname(end-2:end)='mat';
    wordmap = append(mapPath,fname );
    load(wordmap);
    h = getImageFeatures(wordMap, size(dictionary, 1));
    d = getImageDistance(h,trainFeatures,'chi2');

        Result=knnPredict(d,numNN,trainLabels);
        HarrisPredictionchi2(i,numNN)=Result;
    
    
    d = getImageDistance(h,trainFeatures,'euclidean');
        Result=knnPredict(d,numNN,trainLabels);
        HarrisPredictionL2(i,numNN)=Result;
    
end

Correct = HarrisPredictionchi2==test_labels';
Correct = mean(Correct,1);
[bstRate,bstIdx]=max(Correct);


figure('Name',"Harris chi2, correct rate: "+bstRate+" T="+bstIdx,'NumberTitle','off')
fprintf('Harris chi2 correct rate: %d T=%d'...
,bstRate,bstIdx );
C = confusionmat(test_labels',HarrisPredictionchi2(:,bstIdx) )
confusionchart(C);
title("Harris chi2, correct rate: "+bstRate+" T="+bstIdx)

Correct = HarrisPredictionL2==test_labels';
Correct = mean(Correct,1);
[bstRate,bstIdx]=max(Correct);

figure('Name',"Harris euclidan, correct rate: "+bstRate+" T="+bstIdx,'NumberTitle','off')
fprintf('Harris euclidan correct rate: %d T=%d'...
,bstRate,bstIdx );
C = confusionmat(test_labels',HarrisPredictionL2(:,bstIdx) )
confusionchart(C);
title("Harris euclidan, correct rate: "+bstRate+" T="+bstIdx)






function predict=knnPredict(d,numNN,trainLabels)
[~,idx] = mink(d,numNN);
Freq=histcounts(trainLabels(idx),1:9);

[MaxFreq,label] = maxk(Freq,2);
if length(label)==1
    predict=label(1);
    return
end

if MaxFreq(1)~=MaxFreq(2)
    predict=label(1);
else
    predict=knnPredict(d,numNN-1,trainLabels);
end

end

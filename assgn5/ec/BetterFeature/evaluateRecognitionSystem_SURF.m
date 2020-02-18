clear all
close all
% method=["Random";"Harris"]

load('../../data/traintest.mat');
load('visionSURF.mat');
SURFPredictionchi=zeros(size(test_imagenames,2) ,40);
SURFPredictionL2=zeros(size(test_imagenames,2) ,40);

mapPath = '../BetterFeature/SURF/';
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
    for numNN=1:40
        Result=knnPredict(d,numNN,trainLabels);
        SURFPredictionchi(i,numNN)=Result;
    end
    
    d = getImageDistance(h,trainFeatures,'euclidean');
    for numNN=1:40
        Result=knnPredict(d,numNN,trainLabels);
        SURFPredictionL2(i,numNN)=Result;
    end
end

Correct = SURFPredictionchi==test_labels';
Correct = mean(Correct,1);
[bstRate,bstIdx]=max(Correct);


figure('Name',"Random chi2, correct rate: "+bstRate+" T="+bstIdx,'NumberTitle','off')
fprintf('Random chi2 correct rate: %d T=%d'...
,bstRate,bstIdx )
C = confusionmat(test_labels',SURFPredictionchi(:,bstIdx) )
confusionchart(C);
Rc=Correct';


Correct = SURFPredictionL2==test_labels';
Correct = mean(Correct,1);
[bstRate,bstIdx]=max(Correct);

figure('Name',"Random euclidan, correct rate: "+bstRate+" T="+bstIdx,'NumberTitle','off')
fprintf('Random euclidan correct rate: %d T=%d'...
,bstRate,bstIdx )
C = confusionmat(test_labels',SURFPredictionL2(:,bstIdx) )
confusionchart(C);
Rc=[Rc,Correct'];


figure
plot(Rc)
legend('SURF chi2','SURF L2')




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

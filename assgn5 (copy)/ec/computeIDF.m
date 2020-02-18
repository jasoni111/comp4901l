method='Random'
load('../data/traintest.mat');
load( append('../matlab/vision',method,'.mat'));


normDWInD=sum(trainFeatures~=0,1);
T=size(trainFeatures,1);
IDF=log(T./normDWInD);
save('idf.mat','IDF');
save('idfRandom.mat','IDF');

clear all
method='Harris'

load('../data/traintest.mat');
load( append('../matlab/vision',method,'.mat'));


normDWInD=sum(trainFeatures~=0,1);
T=size(trainFeatures,1);
IDF=log(T./normDWInD);
save('idfHarris.mat','IDF');
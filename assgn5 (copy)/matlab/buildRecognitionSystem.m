method='Harris';

load('../data/traintest.mat');
load(append('dictionary',method,'.mat'));

wordmaps = strrep(train_imagenames, '.jpg', '.mat');
mapPath = append('../data/',method,'/');

trainFeatures = zeros( size(train_imagenames,2),...
    size(dictionary, 1) );

for i=1:length(train_imagenames)
    fname=train_imagenames{i};
    fname(end-2:end)='mat';
    wordmap = append(mapPath,fname );
    load(wordmap);
    trainFeatures(i, :) = getImageFeatures(wordMap, size(dictionary, 1)); 
    
end
trainLabels=train_labels';

save(append('vision',method,'.mat') ...
    ,'filterBank', 'dictionary', 'trainFeatures', 'trainLabels')


method='Random';

load('../data/traintest.mat');
load(append('dictionary',method,'.mat'));

wordmaps = strrep(train_imagenames, '.jpg', '.mat');
mapPath = append('../data/',method,'/');

trainFeatures = zeros( size(train_imagenames,2),...
    size(dictionary, 1) );

for i=1:length(train_imagenames)
    fname=train_imagenames{i};
    fname(end-2:end)='mat';
    wordmap = append(mapPath,fname );
    load(wordmap);
    trainFeatures(i, :) = getImageFeatures(wordMap, size(dictionary, 1)); 
    
end
trainLabels=train_labels';

save(append('vision',method,'.mat') ...
    ,'filterBank', 'dictionary', 'trainFeatures', 'trainLabels')

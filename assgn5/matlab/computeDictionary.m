load("../data/traintest.mat");

alpha=50;
K=100;
tic
dictionaryHarris=...
    getDictionary(train_imagenames,alpha,K,"harris")
toc
tic
dictionaryRandom=...
    getDictionary(train_imagenames,alpha,K,"random")
toc

filterBank = createFilterBank();

dictionary=dictionaryRandom
save("dictionaryRandom.mat","dictionary","filterBank")
dictionary=dictionaryHarris
save("dictionaryHarris.mat","dictionary","filterBank")

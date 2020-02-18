load("../../data/traintest.mat");

K=100;

imgPaths=train_imagenames;

appendImgPaths=string(size(imgPaths) );
for i=1:size(imgPaths,2)
    appendImgPaths(i)="../../data/"+imgPaths{i};
end
imgPaths=appendImgPaths;
f = waitbar(0,'Please wait...');
res=zeros(0,64);

for i=1:size(imgPaths,2)
    
    if not(mod(i-1,30) )
        waitbar(i/size(imgPaths,2),f,"loading SURF")
    end
    
    I=imread(imgPaths(i));
    res = [res;...
        extractSURFfeature(I)];
end 
close(f)
[~, dictionary] = kmeans(res, K, "EmptyAction", "drop")
%"../data/airport/sun_aerinlrdodkqnypz.jpg"
save("dictionarySURF.mat","dictionary")

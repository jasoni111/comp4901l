load("../../data/traintest.mat");
load("dictionarySURF.mat")
imgPaths=all_imagenames;

appendImgPaths=string(size(imgPaths) );
for i=1:size(imgPaths,2)
    appendImgPaths(i)="../../data/"+imgPaths{i};
end
imgPaths=appendImgPaths;

f = waitbar(0,'Please wait...');
target = append('../BetterFeature/SURF/'); 

if ~exist(target,'dir')
    mkdir(target);
end

for category = mapping
    if ~exist([target,category{1}],'dir')
        mkdir([target,category{1}]);
    end
end

for i=1:size(imgPaths,2)
    
    if not(mod(i-1,30) )
        waitbar(i/size(imgPaths,2),f,"loading SURF")
    end
    
    I=imread(imgPaths(i));
    wordMap = getSURFVisualWords(I,dictionary);
    save([target, strrep(all_imagenames{i},'.jpg','.mat')],'wordMap');

end 
close(f)
%"../data/airport/sun_aerinlrdodkqnypz.jpg"

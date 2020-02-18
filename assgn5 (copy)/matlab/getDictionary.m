function [dictionary] = getDictionary(imgPaths, alpha, K, method)
%GETDICTIONARY Summary of this function goes here
%   Detailed explanation goes here
appendImgPaths=string(size(imgPaths) );
for i=1:size(imgPaths,2)
    appendImgPaths(i)="../data/"+imgPaths{i};
end
imgPaths=appendImgPaths;
size(imgPaths)
filterBank = createFilterBank();
pixelResponses=zeros(alpha*size(imgPaths,2),3*size(filterBank,1));
f = waitbar(0,'Please wait...');

for i=1:size(imgPaths,2)
    
    if not(mod(i-1,30) )
        waitbar(i/size(imgPaths,2),f,"loading "+method)
    end
    
    I=imread(imgPaths(i));
    res = extractFilterResponses(I,filterBank);
    
    if (method=="random")
        points=getRandomPoints(I,alpha);
        %x,y
    end
    if (method=="harris")
        points=getHarrisPoints(I,alpha);
        %x,y
    end
    
    for j=1:alpha
        pixelResponses((i-1)*alpha+j,:)=...
        res(points(1,j),points(2,j),: );
    end
end 
close(f)
[~, dictionary] = kmeans(pixelResponses, K, "EmptyAction", "drop")
%"../data/airport/sun_aerinlrdodkqnypz.jpg"

end


function [filterResponses] = extractFilterResponses(I, filterBank)

if size(I,3)==3
[L,a,b] = RGB2Lab(I);
else
L=I;
a=I;
b=I;
end

filterResponses=zeros(size(I,1),size(I,2),3*size(filterBank,1) );

for i = 1:size(filterBank,1)
	filterResponses(:,:,i*3-2) = imfilter(L,filterBank{i});
    filterResponses(:,:,i*3-1) = imfilter(a,filterBank{i});
    filterResponses(:,:,i*3) = imfilter(b,filterBank{i});
end

end


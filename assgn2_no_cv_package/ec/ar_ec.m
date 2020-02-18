% Q4.2x
% Q3.3.1
% clear all;
close all;

source=loadVid("../data/ar_source.mov");
book=loadVid("../data/book.mov");
cv_img = imread('../data/cv_cover.jpg');
hp_img = imread('../data/hp_cover.jpg');
v = VideoWriter('../results/ar.avi');
open(v)

scaled_hp_img = imresize(hp_img, [size(cv_img,1) size(cv_img,2)]);
[I1_desc,I1_locs]=computeORB(cv_img);

ROI=[];
result=zeros(size(book));
figure
for iFrame=1:size(source,2)
bookframe=book(iFrame).cdata;
sourceframe=source(iFrame).cdata;

if isempty(ROI)
    ROI=[1,size(bookframe,2);
        1,size(bookframe,1)];
end
bookframe_ROI=bookframe(ROI(2,1):ROI(2,2),ROI(1,1):ROI(1,2));

[I2_desc,I2_locs]=computeORB(bookframe_ROI);
indexPairs = customMatchFeatures(I1_desc,I2_desc,50);
% assert();

locs1=zeros(size(indexPairs,1),2);
locs2=zeros(size(indexPairs,1),2);

for i=1:size(indexPairs,1)
    locs1(i,:)=I1_locs(indexPairs(i,1),:);
    locs2(i,:)=I2_locs(indexPairs(i,2),:)+[ROI(1,1)-1,ROI(2,1)-1];
end

sourceframe = sourceframe(50:360-50,200:400,:);
sourceframe = imresize(sourceframe, [size(cv_img,1) size(cv_img,2)]);

[bestH2to1, ~] = computeH_ransac(locs1, locs2);
[resultframe,ROI]=compositeH_withROI(inv(bestH2to1), sourceframe, bookframe);

imshow(resultframe);

ROI=round(ROI);
writeVideo(v,resultframe)
end


close(v)

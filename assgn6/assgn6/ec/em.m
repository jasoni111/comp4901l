clear all;
close all;
addpath("../matlab");
load("lenet.mat");
layers = get_lenet();

% Im=imread("../images/image1.JPG");
% Im=imread("../images/image2.JPG");
% Im=imread("../images/image3.png");
Im=imread("../images/image4.jpg");
% hold on

Im=rgb2gray(Im);
BW = imbinarize(Im);
BW=1-BW;
CC = bwconncomp(BW,8);
L = labelmatrix(CC);
% imshow(label2rgb(L,'jet','w','shuffle'));
% figure;
imshow(BW);

for i=1:max(L(:))
% for i=1:1
    points=find(L==i);
    [y,x]=ind2sub(size(BW),points);
    miny=min(y);
    minx=min(x);
    maxy=max(y);
    maxx=max(x);
%     Im(miny:maxy,minx:maxx)=0;
    Iminput=BW(miny:maxy,minx:maxx);
    Iminput = padarray(Iminput,[15 15],0,'both')'
    Iminput=imresize(Iminput,[28 28]);
%     figure;
%     imshow(Iminput);
    
    [output, P] = convnet_forward(params, ...
    layers,Iminput(:) );
    [per,Idx]=maxk(P,2);
    Idx=Idx-1;
    text(minx, miny,...
int2str(Idx(1))+":"+sprintf('%.2f',per(1))+sprintf("\n")+...
int2str(Idx(2))+":"+sprintf('%.2f',per(2)), 'FontSize', 15,...
'color',[1,0,0]);

end
% hold off




% 
% hold off
% CC.PixelIdxList

% numPixels = cellfun(@numel,CC.PixelIdxList);
% [biggest,idx] = max(numPixels);
% BW(CC.PixelIdxList{idx}) = 0;


% [B,L] = bwboundaries(BW,'noholes');
% imshow(label2rgb(L, @jet, [.5 .5 .5]))
% hold on
% for k = 1:length(B)
%    boundary = B{k};
%    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
% end
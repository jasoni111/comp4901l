clear;
close all;

datadir     = '../ec';    %the directory containing the images
resultsdir  = '../ec'; %the directory for dumping results

%parameters
sigma     = 2;
threshold = 0.03;
rhoRes    = 2;
thetaRes  = pi/90;
nLines    = 50;
%end of parameters

imglist = dir(sprintf('%s/*.jpeg', datadir));

for i = 1:numel(imglist)
    
    %read in images%
    [path, imgname, dummy] = fileparts(imglist(i).name);
    img = imread(sprintf('%s/%s', datadir, imglist(i).name));
    
    if (ndims(img) == 3)
        img = rgb2gray(img);
    end
    
    img = double(img) / 255;
    BW=myEdgeFilterX(img,1);
    figure;
    imshow(BW);
%     figure;

%     [H,T,R] = hough(BW);
%     [H,T,R] = hough(BW,'RhoResolution',rhoRes,'Theta',-90:1:89);
%     P  = houghpeaks(H,35,'threshold',ceil(0.3*max(H(:))),'NHoodSize',[3,3]);
%     lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
%     img2 = img;
%     for j=1:numel(lines)
%        img2 = drawLine(img2, lines(j).point1, lines(j).point2); 
%     end     
%     figure;
%     imshow(img2);
    
    [H,rhoScale,thetaScale] = myHoughTransformX(BW, threshold, rhoRes, thetaRes);
    figure;
    imshow(H);
    [rhos, thetas] = myHoughLinesX(H, nLines);
    lines3 = myHoughLineSegments(rhoRes, thetaRes, rhos, thetas,BW);
    img3 = img;
    for j=1:numel(lines3)
       img3 = drawLineX(img3, lines3(j).point1, lines3(j).point2); 
    end
    figure;
    imshow(img3);
    
        
    fname = sprintf('%s/%s_edges.png', resultsdir, imgname);
    imwrite(BW, fname);
    
    fname = sprintf('%s/%s_edges.png', resultsdir, imgname);
    imwrite(H, fname);
    
    fname = sprintf('%s/%s_lines.png', resultsdir, imgname);
    imwrite(img3, fname);
    

%     figure;
%     imshow(img3);
    
end
function [img1] = myEdgeFilterX(img0, sigma)
    tic

hsize = 2 * ceil(3 * sigma) + 1;
h = fspecial('gaussian',hsize,sigma);
img0=myImageFilterX(img0,h);


%df/dx
h= fspecial('sobel');

imgx=myImageFilterX(img0,h');
imgy=myImageFilterX(img0,h);


%devide by zero may occure...
%luckily this doesn't affect that much

gradiant=atan(imgy./imgx);


amplitude=sqrt(imgy.*imgy+imgx.*imgx);
amplitude=amplitude.*(amplitude> (max(amplitude(:))*0.2 ) );
figure;

imshow(amplitude);

% figure("name","amplitude");
% imshow(amplitude);


gradiant=(gradiant>=0).*gradiant+...
(gradiant<0).*(gradiant+pi);
        %[0  , 22.5)
gradiant=is_within_45deg(gradiant).*(0)+...
    ... [22.5, 67.6)
    is_within_45deg(gradiant-deg2rad(45) ).*(1)+...
    ... [67.5, 112.6)
    is_within_45deg(gradiant-deg2rad(90) ).*(2)+...
    ... [112.5, 157.5) 
    is_within_45deg(gradiant-deg2rad(135) ).*(3)+...
    ... [157.5, 180)
    is_within_45deg(gradiant-deg2rad(180) ).*0;

%% Non-maximum suppression
img1=zeros(size(img0));
%% Handle 0 deg
shift0=Shift(amplitude,0,1);
shift1=Shift(amplitude,0,-1);

img1=(gradiant==0).*(amplitude>shift0 & amplitude>shift1).*amplitude ...
+(gradiant~=0).*img1;

%% Handle 45 deg
shift0=Shift(amplitude,-1,-1);
shift1=Shift(amplitude,1,1);
img1=(gradiant==1).*(amplitude>shift0 & amplitude>shift1).*amplitude ...
+(gradiant~=1).*img1;

%% Handle 90 deg
shift0=Shift(amplitude,1,0);
shift1=Shift(amplitude,-1,0);

img1=(gradiant==2).*(amplitude>shift0 & amplitude>shift1).*amplitude ...
    +(gradiant~=2).*img1;

%% Handle 135 deg
shift0=Shift(amplitude,-1,1);
shift1=Shift(amplitude,1,-1);
img1=(gradiant==3).*(amplitude>shift0 & amplitude>shift1).*amplitude ...
+(gradiant~=3).*img1;

% figure("name","img1")
% imshow(img1);

end

function [y]=is_within_45deg(x)
y=(x>=deg2rad(-22.5) )&(x<deg2rad(22.5) );
end
    
function [y]=Shift(originalimg,xshift,yshift)
[xSize,Ysize]=size(originalimg);
y=zeros(xSize,Ysize);
y(max(1,1+xshift):1:min(end+xshift,end),max(1,1+yshift):1:min(end+yshift,end) )=...
    originalimg(max(1,1-xshift):1:min(end-xshift,end),max(1,1-yshift):1:min(end-yshift,end));
end       

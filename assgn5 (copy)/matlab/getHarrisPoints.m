function [points] = getHarrisPoints(I,alpha)

if size(I,3)==3
    if max(I(:))>1
        Im = double(rgb2gray(I))./255;
    else
        Im = double(rgb2gray(I))
    end
else
    if max(I(:))>1
        Im = double(I)./255;
    else
        Im = double(I)
    end
end
Im=imgaussfilt(Im,1);

dy = fspecial('prewitt');  
dx = dy';

% main
Ix = conv2(Im, dx, 'same');   
Iy = conv2(Im, dy, 'same');

Ix2 = Ix.^2;

Iy2 = Iy.^2;
Ixy = Ix.*Iy;

k = 0.04;
R = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2;
R(1,:)=-Inf;
R(end,:)=-Inf;
R(:,1)=-Inf;
R(:,end)=-Inf;
isMax=imregionalmax(R);
R=R.*isMax;
[a,Index]=sort(R(:) );

Index=Index(1:alpha);
[y,x]=ind2sub(size(Im),Index);

figure
imshow(I);
hold on;
scatter(x,y)
points=[y';x'];


end


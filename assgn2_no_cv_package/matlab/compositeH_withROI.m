function [ composite_img, ROI] = compositeH_withROI( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography
% template_y_size=size(template,1)
% template_x_size=size(template,2)

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
% H_template_to_img = inv(H2to1);

%% Create mask of same size as template

mask=ones(size(template,1),size(template,2),size(template,3));

Vec=[1,1,size(template,2),size(template,2);
    1,size(template,1),1,size(template,1);
    1,1,1,1 ];
Vec=H2to1*Vec;
Vec=[Vec(1,:)./Vec(3,:);Vec(2,:)./Vec(3,:)];
ROI=[max(1,min(Vec(1,:)-30)),...
    min(size(img,2),max(Vec(1,:))+30);...
    max(1,min(Vec(2,:)-30)),...
    min(size(img,1),max(Vec(2,:))+30) ];


%% Warp mask by appropriate homography
mask=warpH(mask, H2to1, size(img));
% figure
% imshow(mask)
%% Warp template by appropriate homography
template=warpH(template, H2to1, size(img));
% figure
% imshow(template)
%% Use mask to combine the warped template and the image
composite_img=img.*uint8(~mask)+template.*uint8(mask);

end
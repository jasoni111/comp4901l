function [ composite_img ] = compositeH( H2to1, template, img )
%COMPOSITE Create a composite image after warping the template image on top
%of the image using the homography
% template_y_size=size(template,1)
% template_x_size=size(template,2)

% Note that the homography we compute is from the image to the template;
% x_template = H2to1*x_photo
% For warping the template to the image, we need to invert it.
% H_template_to_img = inv(H2to1);

%% Create mask of same size as template
% [X,Y]=meshgrid(1:template_y_size,1:template_x_size);
% mask=[X(:);Y(:);ones(1,size(X,1)*size(X,2) )]
mask=ones(size(template,1),size(template,2),size(template,3));

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
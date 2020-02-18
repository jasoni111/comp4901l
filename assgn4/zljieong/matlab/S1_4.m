clear all
close all
load("../data/PhotometricStereo/sources.mat");

numImages = size(S, 1);
Im = im2double(rgb2gray(imread('../data/PhotometricStereo/female_01.tif')));
[ySize,xSize] = size(Im);

% I [numImgsX all pixel]
I = zeros(numImages, ySize*xSize);
I(1, :) = Im(:);
for i = 2:numImages
    Im =im2double( ...
        rgb2gray( ...
        imread( ...
        sprintf('../data/PhotometricStereo/female_0%d.tif',i) ...
        ) ...
        ) ...
        );
    I(i,:)=Im(:);
end

g_vec = S \ I;
rho = reshape( sqrt(sum(g_vec .^2)) , ySize , xSize );
normal = reshape(g_vec', ySize, xSize, 3) ./ repmat(rho, [1 1 3]);

figure; 
quiver(normal(:,:,1), normal(:,:,2));
axis image; 
axis ij;
saveas(gcf,'../1_4_1_1.png')
% 
% figure; 
% quiver(normal(1:6:end,1:6:end,1), normal(1:6:end,1:6:end,2));
% axis image; 
% axis ij;
% saveas(gcf,'../1_4_1_1_a.png')

figure;
imshow(rho);
saveas(gcf,'../1_4_1_2.png')




%%
s1 = [0.58 -0.58 -0.58];
s2 = [-0.58 -0.58 -0.58];
Im = max(rho .* ...
    (normal(:,:,1) * s1(1) +...
    normal(:,:,2) * s1(2) +...
    normal(:,:,3) * s1(3)), 0);
figure;
imshow(Im);
saveas(gcf,'../1_4_3_1.png')


Im = max(rho .* ...
    (normal(:,:,1) * s2(1) +...
    normal(:,:,2) * s2(2) +...
    normal(:,:,3) * s2(3)), 0);
figure;
imshow(Im);
saveas(gcf,'../1_4_3_2.png')


%% Reference: Harvard cs283 assignment 7
%% https://www.seas.harvard.edu/courses/cs283/assgn7.pdf
Z = integrate_frankot(normal);

% Z is an HxW array of surface depths
figure;
s=surf(-Z); % use the ‘-’ sign since our Z-axis points down
% output s is a ‘handle’ for the surface plot
% adjust axis
axis image; axis off;
% change surface properties using SET
set(s,'facecolor',[.5 .5 .5],'edgecolor','none');
% add a light to the axis for visual effect
l=camlight;
% enable mouse-guided rotation
rotate3d on
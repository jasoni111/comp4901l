close all
clear all
load('../data/bunny.mat');

figure; 
quiver(N(:,:,1),N(:,:,2));
axis image; 
axis ij; 

saveas(gcf,'../quiver.png')

figure
imshow(N(:,:,3))
saveas(gcf,'../1_3_2.png')

y=size(N,1);
x=size(N,2);
rad45=deg2rad(45);
newim=zeros(y,x);

for i = 1:y
    for j = 1:x
        newim(i,j) = max(0,[0,sin(rad45),cos(rad45)]*squeeze(N(i,j,:)) );
    end
end
figure
imshow(newim)
saveas(gcf,'../1_3_3_1.png')


for i = 1:y
    for j = 1:x
        newim(i,j) =  max(0,[sin(rad45),0,cos(rad45)]*squeeze(N(i,j,:)) );
    end
end
figure
imshow(newim)
saveas(gcf,'../1_3_3_2.png')


for i = 1:y
    for j = 1:x
        newim(i,j) =  max(0,[sin(deg2rad(75)),0,cos(deg2rad(75))]*squeeze(N(i,j,:)) );
    end
end

figure
imshow(newim)
saveas(gcf,'../1_3_3_3.png')

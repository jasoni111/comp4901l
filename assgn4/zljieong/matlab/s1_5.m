close all
clear all
im=im2double(imread('../data/fruitbowl.png'));
s = [0.6257 0.5678 0.5349];

imout = makeLambertian(im, s);

figure
imshow(min(1,imout./0.1));
saveas(gcf,'../1_5.png')


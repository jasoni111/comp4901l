clear all;
close all;
layers = get_lenet();
load lenet.mat
% load data
% Change the following value to true to load the entire dataset.
fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
xtrain = [xtrain, xvalidate];
ytrain = [ytrain, yvalidate];
m_train = size(xtrain, 2);
batch_size = 64;
 
 
layers{1}.batch_size = 1;
img = xtest(:, 1);
img = reshape(img, 28, 28);
imshow(img')
 
%[cp, ~, output] = conv_net_output(params, layers, xtest(:, 1), ytest(:, 1));
output = convnet_forward(params, layers, xtest(:, 1));
output_1 = reshape(output{1}.data, 28, 28);
% Fill in your code here to plot the features.
figure;
imshow(output_1');
figure;
features2=reshape(output{2}.data,...
    output{2}.width,output{2}.height,output{2}.channel);
for k=1:20
subplot(4,5,k);
% size(output{2}.data)

imshow(features2(:,:,k)');
end
figure;
features5=reshape(output{5}.data,...
    output{5}.width,output{5}.height,output{5}.channel);
for k=1:20
subplot(4,5,k);
% size(output{2}.data)

imshow(features5(:,:,k)');
end
% features2==features5



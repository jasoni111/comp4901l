%% Network defintion
layers = get_lenet();


%% Loading data
load lenet.mat

fullset = false;
[xtrain, ytrain, xvalidate, yvalidate, xtest, ytest] = load_mnist(fullset);
% figure
% imshow(reshape(xtest(:,1),28,28))
% [output, P] = convnet_forward(params, layers, xtest(:, 1))
% assert(false)
% load the trained weights

%% Testing the network
% Modify the code to get the confusion matrix
predict=zeros(size(xtest,2),1);
for i=1:100:size(xtest, 2)
    [output, P] = convnet_forward(params, layers, xtest(:, i:i+99));
    [~,Idx]=max(P)
    predict(i:i+99,:)=Idx'
end
cm = confusionchart(ytest'-1,predict-1);
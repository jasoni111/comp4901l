function [img1] = myImageFilterX(img0, h)
[ySize,xSize]=size(img0);
[yFilterSize,xFilterSize]=size(h);
[yShift,xShift]=meshgrid(-floor(yFilterSize/2):floor(yFilterSize/2),-floor(xFilterSize/2):floor(xFilterSize/2));

%% Not fully vectorized
% for i = 1:xFilterSize
%     for j=1:yFilterSize
%         img1=img1+ShiftAndScale(img0,h(i,j),xShift(i,j),yShift(i,j));
%     end
% end

%% vectorized stuff, not sure does it bring any speed up...

%produce filterW*filterH cell of W*H matrix
img_padded=padarray(img0,[double(yFilterSize),double(xFilterSize)],'both','replicate');
img1 = arrayfun(@(x,y,z)ShiftAndScale(img_padded,x,y,z,yFilterSize,xFilterSize),...
    h,yShift,xShift,'UniformOutput',false);
%produce filterW*filterH cell of 1*1*(W*H) matrix
img1 = cellfun(@(x)reshape(x,1,1,[]),img1,'UniformOutput',false);
%produce filterW*filterH*1*1*(W*H) matrix
%cell2mat takes ~10s to load the fist time loading it, will be quicker
%after cached
imgx = cell2mat(img1);
img1=reshape(sum(imgx,[1,2]),ySize,xSize);
%% debug
% if conv2(img0,h,'same')==img1
%     disp("filter work")
% else
%     disp("filter fail")
% end

end

%zero padding
function [y]=ShiftAndScale(img_padded,scaler,columnshift,rowshift,yFilterSize,xFilterSize)
[YSize,Xsize]=size(img_padded);
y=zeros(YSize-abs(yFilterSize)*2,Xsize-abs(xFilterSize)*2);
y(:,:)=...
    img_padded(1+abs(yFilterSize)-rowshift:end-abs(yFilterSize)-rowshift,...
    1+abs(xFilterSize)-columnshift:end-abs(xFilterSize)-columnshift);
y=y.*scaler;
end
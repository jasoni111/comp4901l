function [pts2] = epipolarCorrespondence(im1, im2, F, pts1)
% epipolarCorrespondence:
%   Args:
%       im1:    Image 1
%       im2:    Image 2
%       F:      Fundamental Matrix from im1 to im2
%       pts1:   coordinates of points in image 1
%   Returns:
%       pts2:   coordinates of points in image 2
pts2=[];
pts1=[pts1';ones(1,size(pts1,1))];
for k=1:size(pts1,2)
p1 = pts1(:,k);
x1=p1(1);
y1=p1(2);
% L'=Fx
ep = F*p1;

window_size=8;
kernel = fspecial('gaussian', [17 17], 3);

src = double(im1((y1-window_size):(y1+window_size), (x1-window_size):(x1+window_size)));
Cost=Inf;
x2=proj(1);
y2=proj(2);
for i=x1-40:x1+40
	for j=y1-40:y1+40
        %x'^TL'=0
        if abs([i,j,1]*ep)>0.3
            continue;
        end
        target = double(im2(j-window_size:j+window_size,i-window_size:i+window_size));
        tempCost = kernel .* (src - target);
        tempCost = sum(tempCost.^2,2);
        tempCost=sum(tempCost(:));
        if tempCost<Cost
            Cost=tempCost;
            x2=i;
            y2=j;
        end   
	end
end
pts2=[pts2; [x2 y2]];

end

end
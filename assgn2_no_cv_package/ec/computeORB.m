function [desc,locs] = computeORB(Im)
if ndims(Im) == 3
    Imgray=rgb2gray(Im);
else 
    Imgray=Im;
end
Allscale = 1:-0.05:0.75;

Alldesc=[];
Alllocs=[];
Allharris=[];

for scale=1:size(Allscale,2)
Im = imresize(Imgray,Allscale(scale));

%% Detect features in both images
features=fast_nonmax(Im,4, fast_corner_detect_9(Im,50));
H = computeHarris(Im);
angles = ICAngles(Im,[features(:,2),features(:,1)]);

[desc,locs] = computeRBrief(Im, features,angles);
harris = H(sub2ind(size(H),locs(:,2),locs(:,1)));

Alldesc=[Alldesc;desc];
Alllocs=[Alllocs;round(locs/Allscale(scale))];
Allharris=[Allharris;harris];

end
% desc=Alldesc;
% locs=Alllocs;
num_features=min(800,length(Alllocs));
[~,index] = sort(Allharris);
% % whos harris
% % whos Allfeatures
desc = Alldesc(index(1:num_features),:);
locs = Alllocs(index(1:num_features),:);
end


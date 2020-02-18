function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.
inliers=[];
locs1T=locs1';
numFeatures=size(locs1,1);
assert(numFeatures>=4);
n=80;
locs2T=[locs2';ones(1,size(locs2,1))];
maxinliers=0;
for i=1:n
    if maxinliers>35
        return;
    end
    indexs=get_4_non_repeat_index(numFeatures);
    if any( [locs1(indexs(1),:)==locs1(indexs(2),:),...
            locs1(indexs(1),:)==locs1(indexs(3),:),...
            locs1(indexs(1),:)==locs1(indexs(4),:),...
            locs1(indexs(2),:)==locs1(indexs(3),:),...
            locs1(indexs(2),:)==locs1(indexs(4),:),...
            locs1(indexs(3),:)==locs1(indexs(4),:)] )
        continue
    end
    if any( [locs2(indexs(1),:)==locs2(indexs(2),:),...
            locs2(indexs(1),:)==locs2(indexs(3),:),...
            locs2(indexs(1),:)==locs2(indexs(4),:),...
            locs2(indexs(2),:)==locs2(indexs(3),:),...
            locs2(indexs(2),:)==locs2(indexs(4),:),...
            locs2(indexs(3),:)==locs2(indexs(4),:)] )
        continue
    end
    templocs1=[locs1(indexs(1),:);locs1(indexs(2),:);...
        locs1(indexs(3),:);locs1(indexs(4),:)];
    
    templocs2=[locs2(indexs(1),:);locs2(indexs(2),:);...
        locs2(indexs(3),:);locs2(indexs(4),:)];
%     [locs2(1,:);locs2(2,:);locs2(3,:);locs2(4,:)];
    H2to1=computeH_norm(templocs1,templocs2);
    Homo=H2to1*locs2T;
    Homo=[Homo(1,:)./Homo(3,:);Homo(2,:)./Homo(3,:)];
    distance=locs1T-Homo;
    distancesq=sum(distance.^2,1);
    numinliers=nnz(distancesq<25);
    if (numinliers>maxinliers)
        maxinliers=numinliers;
        bestH2to1=H2to1;
    end
end
% maxinliers
% bestH2to1
%Q2.2.3
end

function [indexs]=get_4_non_repeat_index(maxIndex)
    indexs = zeros(1,4);
    assert(maxIndex>=4)
    for p = 1:4
        while indexs(p) == 0
            indexs(p) = ceil(rand(1)*maxIndex);
            if any( indexs(1:p-1)==indexs(p) ) 
                indexs(p)=0;
            end
        end
    end
end

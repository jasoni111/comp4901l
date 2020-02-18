function [H2to1] = computeH_norm(x1, x2)
%% change to  [x,y]
% x1=[ (x1(1,:)./x1(3,:))' ,(x1(2,:)./x1(3,:))' ]
% x2=[ (x2(1,:)./x2(3,:))' ,(x2(2,:)./x2(3,:))' ]

%% Compute centroids of the points
centroid1 = sum(x1,1)./size(x1,1);
centroid2 = sum(x2,1)./size(x2,1);

%% Shift the origin of the points to the centroid
x1=x1-centroid1;
x2=x2-centroid2;
%% Normalize the points so that the max distance from the origin is equal to sqrt(2).
x1_scale=sqrt(2)/sqrt(max(sum(x1.^2,2)));
x1=x1.*x1_scale;
x2_scale=sqrt(2)/sqrt(max(sum(x2.^2,2)));
x2=x2.*x2_scale;
x1=x1
x2=x2
%% similarity transform 1
T1=[x1_scale 0 -x1_scale*centroid1(1);...
    0 x1_scale -x1_scale*centroid1(2);...
    0 0 1];


% Resize1=[x1_scale 0 0;0 x1_scale 0;0 0 1]
% T1 = [];

%% similarity transform 2
T2=[x2_scale 0  -x2_scale*centroid2(1);...
     0 x2_scale -x2_scale*centroid2(2);...
    0 0 1];

%% Compute Homography
H2to1 = computeH( x1, x2 );
%% Denormalization
H2to1 = T1\H2to1*T2;
H2to1=H2to1./H2to1(9);

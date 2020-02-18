% A test script using templeCoords.mat
%
% Write your code here
%

% save extrinsic parameters for dense reconstruction
%% Load the two images and the point correspondences from someCorresp.mat
close all;
clear all;
load('../data/someCorresp.mat');
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');
%% Run eightpoint to compute the fundamental matrix F
F = eightpoint(pts1, pts2,  M );
% displayEpipolarF(im1,im2,F);
load('../data/templeCoords.mat');
epipolarMatchGUI(im1, im2, F);
pts2 = epipolarCorrespondence(im1, im2, F, pts1);
load('../data/intrinsics.mat');
%x'=K'RK^-1+K't/z
E = essentialMatrix(F, K1, K2);
M1 = [1,0,0,0;0,1,0,0;0,0,1,0];
M2s = camera2(E);
for i = 1:4
    P_ = triangulate(K1*M1, pts1, K2*M2s(:,:,i), pts2);
     if all(P_(:,3) > 0)
        P = P_;
        M2 = M2s(:,:,i);
        f=figure;
        scatter3(P(:,1),P(:,2),P(:,3));
        axis equal
        f.CurrentAxes.ZDir = 'Reverse';
        xlabel('x') 
        ylabel('y')
        zlabel('z')
        f.CurrentAxes.CameraPosition = [ -0.1254    0.7819   -4.7778];
        rotate3d
     end
end
% assert(false)
%% Load the points in image 1 contained in templeCoords.mat and run your
% epipolarCorrespondences on them to get the corresponding points in image 2

R1=eye(3);
t1=zeros(3,1);
R2=M2(1:3,1:3);
t2=M2(1:3,4);
save('../data/extrinsics.mat', 'R1', 't1', 'R2', 't2');

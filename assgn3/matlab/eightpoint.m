function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% M=320;
% T=[1 0 -1;0 1 -1;0 0 1]*[1/M 0 0;0 1/M 0;0 0 1];
% pts1=(pts1./M)-1;
% pts2=(pts2./M)-1;
T=[1/M 0 0;0 1/M 0;0 0 1];
pts1=(pts1/M);
pts2=(pts2/M);
A=zeros(size(pts1,1) ,9);
for i=1:size(pts1,1)
    xp=pts2(i,1);
    yp=pts2(i,2);
    x=pts1(i,1);
    y=pts1(i,2);
    A(i,:)=[x*xp y*xp xp x*yp y*yp yp x y 1];
end
[~,~,V] = svd(A);
F=reshape(V(:,end),3,3)';
[U,S,V] = svd(F);
S(end,end)=0;
% S=diag([S(1,1),S(2,2),0]);
F=U*S*V';
F=refineF(F,pts1,pts2);
F=T'*F*T;
% [U,S,V] = svd(A);
% S(:,9)=0;
% A=U*S*V';
% [U,S,V] = svd(A);
% F=reshape(V(:,9),3,3);
% F=refineF(F,pts1,pts2);
% F=T'*F*T;


% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

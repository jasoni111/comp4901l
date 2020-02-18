function [ H2to1 ] = computeH( x1, x2 )
%COMPUTEH Computes the homography between two sets of points, x1=Hx2
assert(size(x1,1)==size(x2,1));
assert(size(x1,2)==size(x2,2));

A=zeros(2*size(x1,1),9 );

for i=0:( size(x1,1)-1)
    x=x2(i+1,1);
    y=x2(i+1,2);
    xp=x1(i+1,1);
    yp=x1(i+1,2);

    A(2*i+1,:)=[-x,-y,-1,0,0,0,x*xp,y*xp,xp];
    A(2*i+2,:)=[0,0,0,-x,-y,-1,x*yp,y*yp,yp];
end
[U,S,V]=svd(A);
singularVector=V(:,9);
H2to1=reshape(singularVector,3,3)';
end

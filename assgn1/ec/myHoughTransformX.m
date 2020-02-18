function [H, rhoScale, thetaScale] = ...
    myHoughTransformX(Im, threshold, rhoRes, thetaRes)
%Your implementation here
%theta in [0,2pi]
%p in [0,M]->M=sqrt(x^2+y^2)
Im=Im>threshold;
figure
imshow(Im);
[ySize,xSize]=size(Im);
M=ceil( sqrt(xSize^2+ySize^2)/rhoRes );
% disp(M);
rhoScale=1:rhoRes:M*rhoRes;

% N=ceil(2*pi/rhoRed);
%[0,2pi)
thetaScale=0:thetaRes:2*pi-thetaRes;
cosLookup=cos(thetaScale);
sinLookup=sin(thetaScale);

N=length(thetaScale);
H=zeros(M,N);
% H2=zeros(M,N);

for x=1:xSize
    for y=1:ySize
        if Im(y,x)
            X=repelem(x,length(thetaScale) );
            Y=repelem(y,length(thetaScale) );
            P=int32( (X.*cosLookup+Y.*sinLookup )./rhoRes );
%             P2=int32( (X.*cosLookup+Y.*sinLookup )./rhoRes );
            for theta=1:N
                if P(theta)>0
                    H(P(theta),theta)=H(P(theta),theta)+1;
                end
%                 if P2(theta)>0
%                     H2(P2(theta),theta)=H2(P2(theta),theta)+1;
%                 end
            end
        end
    end
end
figure("name","H")
imshow(H.*4./max(H(:)) );

% figure("name","H2")
% imshow(H2.*4./max(H2(:)) );
end
        
        
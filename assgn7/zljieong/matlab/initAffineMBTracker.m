function [affineMBContext] = initAffineMBTracker(img, rect)

template = double(img(rect(2) :rect(2)+rect(4),rect(1):rect(1)+rect(3)));

[Gx, Gy] = imgradientxy(template);

[xs,ys] = meshgrid(rect(2) :rect(2)+rect(4),rect(1):rect(1)+rect(3));

J = [xs(:).*Gx(:), xs(:).*Gy(:), ys(:).*Gx(:), ys(:).*Gy(:), Gx(:), Gy(:)]; 
H = J'*J; 

affineMBContext = struct('J',J,'invHessian',inv(H) );

end

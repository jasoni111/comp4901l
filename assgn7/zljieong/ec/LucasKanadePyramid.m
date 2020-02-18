function [u,v] = LucasKanadePyramid(It, It1, rect)
It=im2double(It);
It1=im2double(It1);

u = 0;
v = 0;
epsilon = 0.001;
deltaP = [1 1];

numPyramid=2

[X, Y] = meshgrid(rect(1):rect(1)+rect(3), ...
    rect(2):rect(2)+rect(4));

template = interp2(It, X, Y);

reducedTemplate= impyramid(template, 'reduce');
reducedReducedTemplate= impyramid(reducedTemplate, 'reduce');

while(norm(deltaP) > 0.01)
    [X, Y] = meshgrid((rect(1)+u) : (rect(1)+rect(3)+u), ...
        (rect(2)+v) : (rect(2)+rect(4)+v));
    warpimg = double(interp2(It1, X, Y));
    reducedWarpimg = impyramid(warpimg, 'reduce');
    reducedReducedWarpimg = impyramid(reducedWarpimg, 'reduce');
    err = reducedReducedWarpimg - reducedReducedTemplate;
    
    [dTx, dTy] = gradient(reducedReducedWarpimg);
    A = double([dTx(:), dTy(:)]);
    H = A' * A;
    
    deltaP = H\A' * err(:);
    if isnan(deltaP)
        deltaP
        assert(false);
    end
    % update warp
    u = u - deltaP(1)*4;
    v = v - deltaP(2)*4;
end


while(norm(deltaP) > 0.01)
    [X, Y] = meshgrid((rect(1)+u) : (rect(1)+rect(3)+u), ...
        (rect(2)+v) : (rect(2)+rect(4)+v));
    warpimg = double(interp2(It1, X, Y));
    reducedWarpimg = impyramid(warpimg, 'reduce');
    err = reducedWarpimg - reducedTemplate;
    
    [dTx, dTy] = gradient(reducedWarpimg);
    A = double([dTx(:), dTy(:)]);
    H = A' * A;
    
    deltaP = H\A' * err(:);
    if isnan(deltaP)
        deltaP
        assert(false);
    end
    % update warp
    u = u - deltaP(1)*2;
    v = v - deltaP(2)*2;
end

while(norm(deltaP) > 0.01)
    [X, Y] = meshgrid((rect(1)+u) : (rect(1)+rect(3)+u), ...
        (rect(2)+v) : (rect(2)+rect(4)+v));
    warpimg = double(interp2(It1, X, Y));  
    err = warpimg - template;  
    [dTx, dTy] = gradient(warpimg);
    A = double([dTx(:), dTy(:)]);
    H = A' * A;
    
    deltaP = H\A' * err(:);
    if isnan(deltaP)
        assert(false);
    end
    % update warp
    u = u - deltaP(1);
    v = v - deltaP(2);
    norm(deltaP)
end


end

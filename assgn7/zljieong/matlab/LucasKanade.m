function [u,v] = LucasKanade(It, It1, rect)
It=im2double(It);
It1=im2double(It1);
% rect=[rect(1) rect(2) rect(1)+rect(3) rect(2)+rect(4)]

u = 0;
v = 0;
epsilon = 0.001;
deltaP = [1 1];

[X, Y] = meshgrid(rect(1):rect(1)+rect(3), ...
    rect(2):rect(2)+rect(4));

template = interp2(It, X, Y);

while(norm(deltaP) > epsilon)
    [X, Y] = meshgrid((rect(1)+u) : (rect(1)+rect(3)+u), ...
        (rect(2)+v) : (rect(2)+rect(4)+v));
    warpimg = double(interp2(It1, X, Y));
    
    err = warpimg - template;
    
    [dTx, dTy] = gradient(warpimg);
    A = double([dTx(:), dTy(:)]);
%     size(A)
%     A*A'
%     assert(false);
    H = A' * A;
    
    deltaP = H\A' * err(:);
    if isnan(deltaP)
        assert(false);
    end
    % update warp
    u = u - deltaP(1);
    v = v - deltaP(2);
    
end
end
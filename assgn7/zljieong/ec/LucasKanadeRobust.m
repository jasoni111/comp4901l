function [u,v] = LucasKanadeRobust(It, It1, rect)
It=im2double(It);
It1=im2double(It1);

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
        
        Weights=getHubersWeights(warpimg(:),template(:) );

        err = warpimg - template;
        [dTx, dTy] = gradient(warpimg);
        A = double([dTx(:), dTy(:)]);

        H = A'*([Weights].* A);

        deltaP = H\A'*((Weights).* err(:));
        if isnan(deltaP)
            error('GGED')
        end
        % update warp
        u = u - deltaP(1)
        v = v - deltaP(2);

    end
end

function [Weights]=getHubersWeights(warpimg,template)
e=warpimg-template;
size(e);
std(e);
k=1.345*std(e);
abse=abs(e);
Weights=(abse<=k).*1+(abse>k).*(k./ (abse+(e==0).*0.001) );

end

% function [Weights]=IRLS(warpimg,template)
% 
% 
% 
% 
% end

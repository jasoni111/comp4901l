function [rhos, thetas] = myHoughLinesX(H, nLines)
%Your implemention here
% max(H(:))
% disp(max(H(:)))
imdilated_H=imdilate(H,ones(3,3) );
figure("name","imdilated_H");
imshow(imdilated_H>H & H~=0);
[rhoSize,thetaSize]=size(H);
isMaxima=imdilated_H==H & H~=0;
rhos=[];
thetas=[];
votes=[];
for rho=1:rhoSize
    for theta=1:thetaSize
        if isMaxima(rho,theta)
            rhos=[rhos; rho];
            thetas=[thetas; theta];
            votes=[votes; H(rho,theta)];
        end
    end
end

% [rhoSize,thetaSize]=size(H);
% canSkip=zeros(rhoSize,thetaSize);
% rhos=[];
% thetas=[];
% votes=[];
% for rho=1:rhoSize
%     for theta=1:thetaSize
%         if canSkip(rho,theta), continue;end
%         [isMax,canSkip]=isLocalMax(H,canSkip,rho,theta,rhoSize,thetaSize)
%         if isMax(H,canSkip,rho,theta)
%             rhos=[rhos ;rho];
%             thetas=[thetas ;theta];
%             votes=[votes; H(rho,theta)];
%         end
%     end
% end

T=table(rhos,thetas,votes);
T=sortrows(T,"votes", "descend");
rhos=T.rhos(1:nLines);
thetas=T.thetas(1:nLines);


end

% function [ismax,canskip]=isLocalMax(H,canSkip,x,y,xSize,ySize)
% for dx=-1:1
%     for dy=-1:1
%         if dx==0 && dy==0 || x+dx<1 || ...
%                 x+dx>xSize || y+dy<1 || y+dy>ySize
%             continue; 
%         end
%         if H(y+dy,x+dx)>H(y+dy,x+dx)
%         end
%     end
% end
% end
function [dist] = getImageDistance(hist1, histSet, method)
%hist1: 1XK
%histSet: TXK
%return: TX1
if( strcmp(method,'euclidean') )
    dist=pdist2(hist1,histSet)';
end

if( strcmp( method,'chi2' ) )
%     size( ((hist1-histSet).^2) )
    divisor=(hist1+histSet)+(hist1+histSet==0).*0.0001;
    dist=sum( ((hist1-histSet).^2)./(divisor),2)/2;
end
% dist
end



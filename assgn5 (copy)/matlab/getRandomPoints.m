function [points] = getRandomPoints(I, alpha)
%GETRANDOMPOINTS Summary of this function goes here
%   Detailed explanation goes here
x=randi(size(I,2),[1,alpha]);
y=randi(size(I,1),[1,alpha]);
points=[y;x];

end


% A custom feature matching script that DOES NOT rely on the computer
% vision package.
% Given binary features F1 and F2, it computes the max match in F2 for
% every point in F1. The threshold parameter will suppress bad matches.
% Increase the threshold to get more matches.
%

function indexPairs = customMatchFeatures(F1, F2, threshold)

if nargin < 3
  threshold = 30;
end

n = size(F1, 1);
indexPairs = zeros(n, 2);
diff = zeros(n, 1);

indexPairs(:,1) = linspace(1, n, n);
for i = 1:n
    matchScore = xor(F1(i,:), F2);
    [M,I] = min(sum(matchScore, 2));
    indexPairs(i,2) = I;
    diff(i) = M;
end

indexPairs(diff>threshold,:) = [];
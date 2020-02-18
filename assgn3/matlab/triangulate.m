function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%

P = zeros(4,size(pts1,1));
P3=[P1;P2]
for i=1:size(pts1,1)
   	A = [0 1 -pts1(i,2) 0 0 0; 
        -1 0 pts1(i,1) 0 0 0; 
        pts1(i,2) -pts1(i,1) 0 0 0 0;
       0 0 0 0 1 -pts2(i,2); 
       0 0 0 -1 0 pts2(i,1); 
       0 0 0 pts2(i,2) -pts2(i,1) 0];

	A = [A*P3];
	[~,~,V] = svd(A);
	z = V(:,end);
	P(:,i) = z/z(4);
end

pts3d = P(1:3,:)';

p1 = pts1';
p2 = pts2';

p1_reproj = P1*P;
p2_reproj = P2*P;
p1_reproj=p1_reproj./p1_reproj(3,:);
p1_reproj=p1_reproj(1:2,:);
p2_reproj=p2_reproj./p2_reproj(3,:);
p2_reproj=p2_reproj(1:2,:);

error=[sum((p1-p1_reproj).^2,1).^(1/2),sum((p2-p2_reproj).^2,1).^(1/2)]
error = mean(error)


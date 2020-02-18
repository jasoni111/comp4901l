% compute harris corner score
function H = computeHarris(Im)
Im = double(Im);
sigma=2; r = 6;

dy = fspecial('prewitt'); % The Mask 
dx = dy';

% main
Ix = conv2(Im, dx, 'same');   
Iy = conv2(Im, dy, 'same');
gaussian = fspecial('gaussian',6, 2);

Ix2 = conv2(Ix.^2, gaussian, 'same');  
Iy2 = conv2(Iy.^2, gaussian, 'same');
Ixy = conv2(Ix.*Iy, gaussian,'same');

k = 0.04;
Hp = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2;
H=Hp/max(abs(Hp(:)));
H(1:r,:) = 0;
H(:,1:r) = 0;
H(end-r+1:end,:) = 0;
H(:,end-r+1:end) = 0;
end

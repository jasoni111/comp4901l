function H = computeHarris(Im)
Im = double(Im);

dy = fspecial('prewitt'); % The Mask 
dx = dy';

% main
Ix = conv2(Im, dx, 'same');   
Iy = conv2(Im, dy, 'same');

Ix2 = Ix.^2 
Iy2 = Iy.^2
Ixy = Ix.*Iy

k = 0.04;
Hp = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2;
H=Hp/max(abs(Hp(:)));

end

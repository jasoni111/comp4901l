function [Wout] = affineMBTracker(img, tmp, rect, Win, context)
tmp=im2double(tmp);

count = 0;
deltap = ones(6,1);
Wout = Win;
while (norm(deltap) > 0.2) && (count < 30)
    W_pI = warpH(img,Wout,size(img),0);
    Err = double(W_pI(rect(2) :rect(2)+rect(4),rect(1):rect(1)+rect(3)))-tmp; % w by h
    deltap = context.invHessian*context.J'*Err(:); 
    deltap=[reshape(deltap,2,3);0 0 0];
    Wdp=eye(3)+deltap;
    Wout = Wout\Wdp;    
    
    count = count+1;
end
end

function warp_im = warpH(im, H, out_size,fill_value)

if ~exist('fill_value', 'var') || isempty(fill_value)
    fill_value = 0;
end

tform = maketform( 'projective', H'); 
warp_im = imtransform( im, tform, 'bilinear', 'XData', [1 out_size(2)], 'YData', [1 out_size(1)], 'Size', out_size(1:2), 'FillValues', fill_value*ones(size(im,3),1));
end



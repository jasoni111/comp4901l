function imout = makeLambertian(im, s)
    %% 1(d)
    r = null(s);
    r1 = r(:,1);
    r2 = r(:,2);    
    j_1=im(:,:,1)*r1(1)+im(:,:,2)*r1(2)+im(:,:,3)*r1(3);
    j_2=im(:,:,1)*r2(1)+im(:,:,2)*r2(2)+im(:,:,3)*r2(3);
    imout=sqrt(j_1.^2+j_2.^2);
end
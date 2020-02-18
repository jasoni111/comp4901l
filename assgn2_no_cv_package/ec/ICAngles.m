% compute angles corresponding to the selected points
function angles = ICAngles(Im,coord)
Im = double(Im);
ImPadded = padarray(Im,[3,3],0,'both');

angles = zeros(size(coord,1),1);
[DX,DY]=meshgrid(-3:3);

mask = strel('octagon',3).Neighborhood;
xMask=mask.*DX;
yMask=mask.*DY;

for i = 1:size(coord,1)
    x = coord(i,2);
    y = coord(i,1);
    roi=ImPadded(y:y+6,x:x+6);
    
    M01=roi.*xMask;
    M10=roi.*yMask;
    m01=sum(M01(:));
    m10=sum(M10(:));
    angles(i) = atan2(m01,m10);
end

%     
%     m10=roi.*DX;
%     
%     for dx= -3:3
%         for dy = -3:3
%             if mask(dy+4,dx+4) 
%                pixel = ImPadded(y + 3 + dy,x + 3 + dx);
%                m10 = m10 + pixel * dx;
%                m01 = m01 + pixel * dy;
%             end
%         end
%     end
%     angle(i) = atan2(m01,m10);
end

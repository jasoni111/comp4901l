function [liness] = myHoughLineSegments(rhoRes, thetaRes,lineRhos, lineThetas, Im)
MaxDistance=25;

Bin=Im>0;
[yPeak,xPeak]=find(Bin);
yPeak=yPeak;
xPeak=xPeak;

templine.point1 = [0,0];
templine.point2 = [0,0];

liness = repmat(templine,1,0);
linecount=1;

[ySize,xSize]=size(Im);
for line = 1:length(lineRhos)
    
    theta = (lineThetas(line)-1 )*thetaRes;
    
    
    rho_all = int32( (xPeak.*cos(theta) + yPeak.*sin(theta))./rhoRes );
    index = find(rho_all == lineRhos(line) );
    
    yPeakOnLine = yPeak(index); 
    xPeakOnLine = xPeak(index);
    
    if length(yPeakOnLine)<=2,continue ,end
    
    Vertical_diff = max(yPeakOnLine) - min(yPeakOnLine);
    horizontaldiff = max(xPeakOnLine) - min(xPeakOnLine);
    if max(yPeakOnLine) - min(yPeakOnLine) > max(xPeakOnLine) - min(xPeakOnLine)
        sorting_order = [1 2];
    else
        sorting_order = [2 1];
    end
    [sorted] = sortrows([yPeakOnLine xPeakOnLine], sorting_order);
    yPeakOnLine = sorted(:,1);
    xPeakOnLine = sorted(:,2);
    
    distances=(yPeakOnLine(1:end-1)-yPeakOnLine(2:end) ).^2+...
            (xPeakOnLine(1:end-1)-xPeakOnLine(2:end) ).^2;
    
    for i=1:length(yPeakOnLine)-1
        if distances(i)<=MaxDistance
            if linecount>1 && liness(linecount-1).point2(1)==xPeakOnLine(i) && ...
                    liness(linecount-1).point2(2)==yPeakOnLine(i)
                liness(linecount-1).point2=[xPeakOnLine(i+1),yPeakOnLine(i+1)];
                continue
            end                
            templine.point1 = [xPeakOnLine(i),yPeakOnLine(i)];
            templine.point2 = [xPeakOnLine(i+1),yPeakOnLine(i+1)];
            liness(linecount)=templine;
            linecount=linecount+1;
        end
    end

end

end
% clear all
% close all
% 
% 
% video = VideoWriter('../results/car_mb.avi');
% tracker = [130 125 200 140]  ;
% centre = [round(tracker(1)+tracker(3)/2);round(tracker(2)+tracker(4)/2);1];
% 
% open(video);
% figure;
% 
% prev_frame = imread('../data/car/frame0020.jpg');
% template = prev_frame(tracker(2) :tracker(2)+tracker(4),tracker(1):tracker(1)+tracker(3));
% Win =eye(3);
% 
% context = initAffineMBTracker(prev_frame, tracker);
% new_tracker = tracker;
% for i = 20:280
%     imgdir = sprintf('../data/car/frame%04d.jpg', i);
%     if (~exist(imgdir,'file'))
%         continue;
%     end
%     im = imread(imgdir);
%     Wout = affineMBTracker(im, template, tracker, Win, context);
%     
%     new_c = Wout*centre;
%     new_c = new_c./new_c(3);
%     new_tracker = [round(new_c(1)-floor(new_tracker(3)/2)), round(new_c(2)-floor(new_tracker(4)/2)), ...
%         new_tracker(3), new_tracker(4)];
%     utotalShift=new_c(1)-centre(1)
%     vtotalShift=new_c(2)-centre(2)
%     
%     clf;
%     hold on;
%     imshow(im);
%     rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
%     title(num2str(i-20));
%     drawnow;
%     
%     F = getframe;
%     writeVideo(video,F);
%     
%     tracker = new_tracker;
% end
% close(video);
% 
% 


clear all
close all
%%

tracker = [390 80 190 100];
centre = [round(tracker(1)+tracker(3)/2);round(tracker(2)+tracker(4)/2);1]
video = VideoWriter('../results/landing_mb.avi');
open(video);

% Initialize the tracker
figure;

% TODO run the Matthew-Baker alignment in both landing and car sequences
prev_frame = imread('../data/landing/frame0190_crop.jpg');
template = prev_frame(tracker(2) :tracker(2)+tracker(4),tracker(1):tracker(1)+tracker(3));
Win =eye(3);

context = initAffineMBTracker(prev_frame, tracker);

% Start tracking
new_tracker = tracker;
for i = 191:308
    imgdir = sprintf('../data/landing/frame%04d_crop.jpg', i);
    if (~exist(imgdir,'file'))
        continue;
    end
    im = imread(imgdir);
    Wout = affineMBTracker(im, template, tracker, Win, context);
    
    %     new_c = Wout*[cx;cy;1];
    new_c = Wout*centre;
    new_c = new_c./new_c(3);
    new_tracker = [round(new_c(1)-floor(new_tracker(3)/2)), round(new_c(2)-floor(new_tracker(4)/2)), ...
        new_tracker(3), new_tracker(4)]; % TODO calculate the new bounding rectangle
    utotalShift=new_c(1)-centre(1)
    vtotalShift=new_c(2)-centre(2)
    
    
    clf;
    hold on;
    imshow(im);
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    title(num2str(i-190));
    drawnow;
    
    F = getframe;
    writeVideo(video,F);
    
    tracker = new_tracker;
end
close(video);


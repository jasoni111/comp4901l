tracker = [130 125 200 140]         % TODO Pick a bounding box in the format [x y w h]
% You can use ginput to get pixel coordinates
close all;
%% Initialize the tracker
figure;

prev_frame = imread('../data/car/frame0020.jpg');
utotalShift=0
vtotalShift=0


% video = VideoWriter('../results/car_lk.mp4', 'MPEG-4'); % New
video = VideoWriter('../ec/car_Robust.avi'); % New

open(video);

%% Start tracking
new_tracker = tracker;
for i = 20:280
    i
    new_frame = imread(sprintf('../data/car/frame%04d.jpg', i));
    [u, v] = LucasKanadeRobust(prev_frame, new_frame, tracker);
    
    clf;
    hold on;
    imshow(new_frame);
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    
    F = getframe;
    writeVideo(video,F);
    title(num2str(i-20));
    
    prev_frame = new_frame;
    tracker(1) = tracker(1) + u;
    tracker(2) = tracker(2) + v;
    
    utotalShift=utotalShift+u
    vtotalShift=vtotalShift+v
end
close(video);


clear all;
tracker = [390 80 190 100]        % TODO Pick a bounding box in the format [x y w h]
% You can use ginput to get pixel coordinates
close all;
%% Initialize the tracker
figure;

prev_frame = imread('../data/landing/frame0190_crop.jpg');

utotalShift=0
vtotalShift=0

video = VideoWriter('../ec/landing_Robust.avi'); % New
video.Quality = 100;

open(video);

%% Start tracking
new_tracker = tracker;
for i = 191:308
    imgdir = sprintf('../data/landing/frame%04d_crop.jpg', i);
    if (~exist(imgdir,'file'))
        continue;
    end
    new_frame = imread(sprintf('../data/landing/frame%04d_crop.jpg', i));
    [u, v] = LucasKanadeRobust(prev_frame, new_frame, tracker);
    
    clf;
    hold on;
    imshow(new_frame);
    rectangle('Position', new_tracker, 'EdgeColor', [1 1 0]);
    drawnow;
    
    F = getframe;
    writeVideo(video,F);
    title(num2str(i-190));
    
    prev_frame = new_frame;
    tracker(1) = tracker(1) + u;
    tracker(2) = tracker(2) + v;
    
    utotalShift=utotalShift+u
    vtotalShift=vtotalShift+v
end
close(video);


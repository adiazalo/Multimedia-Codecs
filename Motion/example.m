%% Sample use of yuvRead

clc; clear; close all;


% Set the video information
videoSequence = 'foreman_qcif.y';
width  = 176;
height = 144;
nFrame = 170;


% Read the video sequence
[Y,U,V] = yuvRead(videoSequence, width, height ,nFrame); 


% Show sample frames
figure;
c = 0;  % counter
for iFrame = 10:10:170
    c = c + 1;
    subplot(4,5,c), imshow(Y(:,:,iFrame));
    title(['frame #', num2str(iFrame)]);
end
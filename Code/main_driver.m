% MATHEMATICS FUNDAMENTALS FOR ROBOTICS
%
% PROJECT: Shadow Traverse Rovers
% Authors:
%   Ander Solorzano
%   Ben Chaffe
%
% Date: Fall 2014
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Clear all variables and screen
%
clear all variables;
clc;

% Load the images
imgOrg = imread('malapert_original.png');
% imshow(imgOrg);

% Create a greyscale image of the image
imgOrg_gray = rgb2gray(imgOrg);
% imshow(imgOrg_gray);


%% Perform the image processing for the map

% Convert the image to a binary form

% create a matrix of zeros with same size as original image
mask = zeros(size(imgOrg,1),size(imgOrg,2)); 

% find the lit areas of the image
bgIdx = find(imgOrg_gray > 0); 

% set all values of binary image to 1 that meet constraint
mask(bgIdx) = 1;

% display the masked image of the original grayscale image in binary
% imtool(mask);

% make a 9x9 neighborhood matrix
% for dilation using 9x9 neighborhood
structureElt = strel('square', 9); 

% dilate the image and display it
dilation = imdilate(mask,structureElt);
% imtool(dilation);

% rename the image
robotWorld = dilation;
% imtool(robotWorld);

% Enter the start and end positions
[x_Start,y_Start,x_Goal,y_Goal] = world_param(robotWorld);

% Print to the screen
sprintf(' Start Point at: %d,%d \n',x_Start,y_Start)
sprintf(' Goal Point at: %d,%d \n',x_Goal,y_Goal)

Start_Point = [x_Start,y_Start];
Goal_Point = [x_Goal,y_Goal];



%% Navigate the world

% Grab the power parameters
[ P_cap,P_regen,P_range ] = robot_power_param;

% Set initial conditions
P_in = P_cap;

% 
% for i = 1:P_range
%     P_out = robot_power_consumption(P_in,P_cap,P_regen,12,360,robotWorld);
%     P_in = P_out;
% end




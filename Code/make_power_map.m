function [ P_map ] = make_power_map( img,P_light,P_shadow )
% Makes the power map given a binary image
%   Pixel values with 1 are the lit areas (robot gets positive power)
%   Pixel values with -1 are the shadow areas (robot consumes power)

% INPUT:
%   img = the binary image of the world

% OUTPUT:
%   P_map = the cost map of the world

% create a matrix of ones with same size as original image
mask = ones(size(img,1),size(img,2)); 

% find the shadow areas of the image
bgIdx = find(img == 0); 

% set all values of the shadows to P_shadow
mask(bgIdx) = P_shadow;

% find the shadow areas of the image
bgIdx = find(img == 1); 

% set all values of the shadows to P_shadow
mask(bgIdx) = P_light;

% Make the power map
P_map = mask;

end


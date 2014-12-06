function [ P_cap,P_regen,P_range ] = robot_power_param()
% Defines the power requirements of the robot

% OUTPUTS
%   P_cap   = the power capicty of the robot
%   P_regen = the power regeneration rate of the robot in light
%   P_range = the maximum range that the robot can go without power

P_cap = 100;
P_regen = 1;
P_range = P_cap;


end


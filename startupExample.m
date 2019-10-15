%% Robot Manipulator Control Example 
% Copyright 2018 The MathWorks, Inc.


% NOTE: This submission requires files from the following submission:
%  https://github.com/ROBOTIS-GIT/open_manipulator


% This startup script adds the necessary folders to the MATLAB path.
% If git support is setup this script will clone the necessary git
% repository and create the necessary urdf file. Otherwise, download the
% necessary submission, place it on the MATLAB path and run this script.

% Find relevant models and scripts and the corresponding directories
% See Readme file for detailed model and script information
clear
clc
addpath(genpath(pwd));

if checkDependencies
    edit('openManipulatorIK.m');
    edit('Readme.txt')
    open_system('openManipulatorWaypointTracking')
    open_system('openManipulatorBallTracking')
else
    disp('Please make sure all dependencies are on the MATLAB path');
end
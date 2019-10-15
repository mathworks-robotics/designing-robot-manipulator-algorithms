%% Robot Manipulator Control Example 

% Copyright 2017-2019 The MathWorks, Inc.

% NOTE: This submission requires files from the following Git repository:
% https://github.com/ROBOTIS-GIT/open_manipulator

% This startup script adds the necessary folders to the MATLAB path.
% If Git installed on your computer, this script will clone the necessary
% repository and create the necessary urdf file. Otherwise, download the
% necessary files, place them on the MATLAB path, and run this script.

% Find relevant models and scripts and the corresponding directories
% See Readme file for detailed model and script information
clear
clc
addpath(genpath(pwd));

% Set the simulation cache folder to a work folder
if ~isfolder('work')
    mkdir('work')
end
Simulink.fileGenControl('set','CacheFolder','work')

% Check dependencies and address them 
if checkDependencies
    edit('openManipulatorIK.m');
    edit('Readme.md')
    open_system('openManipulatorWaypointTracking')
    open_system('openManipulatorBallTracking')
else
    disp('Please make sure all dependencies are on the MATLAB path');
end
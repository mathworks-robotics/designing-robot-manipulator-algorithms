%% Initialization Script -- Ball Tracking

% Copyright 2018 The MathWorks, Inc.

% This script is used in the model callbacks to initialize 
% all necessary data for the corresponding simulation

clear
close all

%% Robot arm control parameters
Ts = 0.02; % Sample time
filter_constant = 0.02; % Time constant for joint actuators
gripper_force = 6; % Gripper force
position_threshold = [0.05 0.05 0.2];
joint_damping = 0.001;
homePose = [0.278 0 0.198]'; % Position to return to after grabbing ball
estDelay = 0.2; % Ball tracking estimation delay
time_jump = 0.1; % Ball tracking time jump

%% Mechanical parameters
% Ball parameters
ball_radius = 2; %in cm
initPosX = 0.2;
initVelX = 0;
initPosY = -0.2;
initVelY = 0;
initPosZ = 0.025;
initVelZ = 0;

% Floor contact parameters
floor_dimensions = [45 45 0.5];% in cm
contact_floor.planeLength = 0.45; %in m
contact_floor.planeDepth = 0.0025; %in m
contact_floor.stiffness = 1e3;
contact_floor.damping = 1e2;
contact_floor.kFrictionCoeff = 0.2; % Kinetic friction
contact_floor.sFrictionCoeff = 0.3; % Static friction
contact_floor.dampingCoeff = 0.0001; % damping for linear motion
contact_floor.dampingCoeffR = 0.000005; % damping for rotational motion

% Gripper contact parameters
contact_gripper.planeLength_x = 0.06; %in m
contact_gripper.planeLength_y = 0.02; %in m
contact_gripper.planeDepth = 0.001; %in m
contact_gripper.stiffness = 1e3;
contact_gripper.damping = 1e2;
contact_gripper.kFrictionCoeff = 0.7; % Kinetic friction
contact_gripper.sFrictionCoeff = 0.8; % Static friction
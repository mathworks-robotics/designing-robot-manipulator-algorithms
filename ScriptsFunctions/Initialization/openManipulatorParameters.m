%% Initialization Script

% This script is used in the model callbacks to initialize 
% all necessary data for the corresponding simulation

% Copyright 2017-2018 The MathWorks, Inc.

%% Robot arm control parameters
robot = createRigidBodyTree;

TsWaypoint = 0.05;      % Waypoint supervisory logic sample time
TsBall = 0.02;          % Ball tracking supervisory logic sample time
TsCtrl = 0.005;         % Low-level control sample time

% Actuator type: 1 for motion, 2 for torque
if ~exist('actuatorType','var')
    actuatorType = 1;
end

% Initial end effector position
initPos = tform2trvec(getTransform(robot,robot.homeConfiguration,'end_effector'));

% Motion control parameters
filter_constant = 0.05; % Time constant for joint actuators
gripper_force = 6;      % On/off gripper force

% PID compensator parameters (joints 1-4)
% Proportional gains
Kp1 = 8; 
Kp2 = 8; 
Kp3 = 8;
Kp4 = 8;
% Derivative gains
Kd1 = 0.1;
Kd2 = 0.1;
Kd3 = 0.1;
Kd4 = 0.1;
% Derivative filter coefficients
Kfilt1 = 150;
Kfilt2 = 150;
Kfilt3 = 150;
Kfilt4 = 150;
ctrlUpperLimit = 2;         % Maximum torque
ctrlLowerLimit = -2;        % Minimum torque

% Gripper control parameters
KpGrip = 75;            % Proportional gain
KiGrip = 50;            % Derivative gain
gripUpperLimit = 2;     % Maximum grip force
gripLowerLimit = -2;    % Minimum grip force

% Cartesian space controller parameters
KpCart = 500;            % Proportional gain
KiCart = 100;            % Integral gain
KdCart = 5;              % Derivative gain
KfiltCart = 150;         % Derivative filter coefficient

% Waypoint Following parameters
waypoint_threshold = 0.02;  % Threshold for waypoint following

% Ball Tracking parameters
position_threshold = [0.03 0.03 0.03];   % XYZ thresholds for ball tracking
homePose = [0.278 0 0.198]'; % Position to return to after grabbing ball
estDelay = 0.2; % Ball tracking estimation delay
time_jump = 0.1; % Ball tracking time jump 


%% Mechanical parameters
% Joint parameters
joint_damping = 0.2;    % Revolute joint damping
grip_stiffness = 1;     % Gripper stiffness
grip_damping = 5;       % Gripper damping

% Ball parameters
ballMass = 0.01;    % kg
ball_radius = 2;    % in cm
initPosX = 0.2;
initVelX = 0;
initPosY = -0.2;
initVelY = 0;
initPosZ = 0.025;
initVelZ = 0;
ball_damping  = 0.005;   % Damping for vertical translation of ball
ball_rot_damping = 0.01; % Damping for rotation of ball

% Floor contact parameters
floor_dimensions = [45 45 0.5];% in cm
contact_floor.planeLength = 0.45; %in m
contact_floor.planeDepth = 0.0025; %in m
contact_floor.stiffness = 1e3;
contact_floor.damping = 1e2;
contact_floor.kFrictionCoeff = 0.025; % Kinetic friction
contact_floor.sFrictionCoeff = 0.1; % Static friction
contact_floor.dampingCoeff = 0.0001; % damping for linear motion
contact_floor.dampingCoeffR = 0.000005; % damping for rotational motion

% Gripper contact parameters
contact_gripper.planeLength_x = 0.085; %in m
contact_gripper.planeLength_y = 0.04; %in m
contact_gripper.planeDepth = 0.001; %in m
contact_gripper.stiffness = 1e3;
contact_gripper.damping = 1e2;
contact_gripper.kFrictionCoeff = 0.7; % Kinetic friction
contact_gripper.sFrictionCoeff = 0.8; % Static friction
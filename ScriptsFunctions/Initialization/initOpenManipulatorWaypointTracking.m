%% Initialization Script -- Waypoint Tracking

% Copyright 2018 The MathWorks, Inc.

% This script is used in the model callbacks to initialize 
% all necessary data for the corresponding simulation.

%% Define waypoints based on case provided
switch trajectorySelection
    case 1 % Simple Trajectory
        wayPoints = [0.2 -0.2 0.02; 0.25 0 0.15; 0.2 0.2 0.02];
    case 2 % Complex Trajectory
        wayPoints = [0.2 -0.2 0.02; 0.15 0 0.28; 0.15 0.05 0.2; ...
                     0.15 0.09 0.15; 0.1 0.12 0.1; 0.04 0.1 0.2; ...
                     0.25 0 0.15; 0.2 0.2 0.02];
    case 3 % Trajectory that will cause gripper fault
        wayPoints = [0.2 -0.2 0.02; 0.15 0 0.28; 0.15 0.05 0.2; ...
                     0.15 0.09 0.15; 0.1 0.12 0.1; 0.04 0.1 0.2; ...
                     0.25 0 0.15; 0.2 0.2 0.02];
end
% Use Curve Fitting Toolbox to create a spline from the trajectory points
trajectory = cscvn(wayPoints');
numTotalPoints = 20;
eePositions = ppval(trajectory,linspace(0,trajectory.breaks(end),numTotalPoints));
trajectoryPoints = eePositions';
% Set gripper state as 4th column of waypoints
if trajectorySelection == 3 % Gripper fault case
    % Enable grip in first 4 and last 2 waypoints
    wayPoints(1:4,4) = 1;
    wayPoints(end-1:end,4) = 1;
else
    % Enable grip in all waypoints except the last
    wayPoints(:,4) = 1;
    wayPoints(end,4) = 0;
end

%% Robot arm control parameters
Ts = 0.05;  % Sample time
filter_constant = 0.05; % Time constant for joint actuators
gripper_force = 3; % Gripper force
position_threshold = 0.02;
joint_damping = 0.001;

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
%% Waypoint tracking demonstration using Robotics System Toolbox

% This demonstration performs inverse kinematics of a
% robot manipulator to follow a desired set of waypoints.

% Copyright 2017-2018 The MathWorks, Inc.

%% Load and display robot
clear
clc

addpath(genpath(strcat(pwd,'\Dependencies')))
robot = createRigidBodyTree;
axes = show(robot);
axes.CameraPositionMode = 'auto';

%% Create a set of desired wayPoints

% wayPoints = [0.2 -0.2 0.02;0.25 0 0.15; 0.2 0.2 0.02]; % Alternate set of wayPoints
wayPoints = [0.2 -0.2 0.02;0.15 0 0.28;0.15 0.05 0.2; 0.15 0.09 0.15;0.1 0.12 0.1; 0.04 0.1 0.2;0.25 0 0.15; 0.2 0.2 0.02];
exampleHelperPlotWaypoints(wayPoints);

%% Create a smooth curve from the waypoints to serve as trajectory

trajectory = cscvn(wayPoints');

% Plot trajectory spline and waypoints
hold on
fnplt(trajectory,'r',2);

%% Perform Inverse Kinematics for a point in space
ik = robotics.InverseKinematics('RigidBodyTree',robot);
weights = [0.1 0.1 0 1 1 1];
initialguess = robot.homeConfiguration;

% Calculate the inverse kinematic solution using the "ik" solver 
% Use desired weights for solution (First three are orientation, last three are translation)
% Since it is a 4-DOF robot with only one revolute joint in Z we do not
% put a weight on Z rotation; otherwise it limits the solution space
numTotalPoints = 30;

% Evaluate trajectory to create a vector of end-effector positions
eePositions = ppval(trajectory,linspace(0,trajectory.breaks(end),numTotalPoints));

% Call inverse kinematics solver for every end-effector position using the
% previous configuration as initial guess
for idx = 1:size(eePositions,2)
    tform = trvec2tform(eePositions(:,idx)');
    configSoln(idx,:) = ik('end_effector',tform,weights,initialguess);
    initialguess = configSoln(idx,:);
end

%% Visualize robot configurations
title('Robot waypoint tracking visualization')
axis([-0.1 0.4 -0.35 0.35 0 0.35]);
for idx = 1:size(eePositions,2)
    show(robot,configSoln(idx,:), 'PreservePlot', false,'Frames','off');
    pause(0.1)
end
hold off
function [wayPoints,eePositions] = createWaypoints(scenarioSelection,trajSelection,numPoints)
% Define waypoints and trajectory based on the provided scenario and
% trajectory type

% Copyright 2017-2019 The MathWorks, Inc.

%% Create waypoints
switch scenarioSelection
    case 1 % Simple Trajectory
        wayPoints = [0.2 -0.2 0.15; 0.2 -0.2 0.02; ...
                     0.25 0 0.15; 0.2 0.2 0.02];
        waypointTime = 3;
        wayPointVels = [0 0 0; 0 0 0; 0 0.1 0; 0 0 0];
    case 2 % Complex Trajectory
        wayPoints = [0.2 -0.2 0.15; 0.2 -0.2 0.02; 0.15 0 0.28; ...
            0.15 0.05 0.2; 0.15 0.09 0.15; 0.1 0.12 0.1; ...
            0.04 0.1 0.2; 0.25 0 0.15; 0.2 0.2 0.02];
        waypointTime = 1;
        wayPointVels = [0 0 0; 0 0 0; 0 0.05 0; 0 0.025 -0.025; ... 
             0 0.025 -0.025; -0.1 0 0; 0.05 0 0; 0 -0.1 -0.05; 0 0 0];
    case 3 % Trajectory that will cause gripper fault
        wayPoints = [0.2 -0.2 0.15; 0.2 -0.2 0.02; 0.15 0 0.28; ...
            0.15 0.05 0.2; 0.15 0.09 0.15; 0.1 0.12 0.1; ...
            0.04 0.1 0.2; 0.25 0 0.15; 0.2 0.2 0.03];
        waypointTime = 1;
        wayPointVels = [0 0 0; 0 0 0; 0 0.05 0; 0 0.025 -0.025; ... 
             0 0.025 -0.025; -0.1 0 0; 0.05 0 0; 0 -0.1 -0.05; 0 0 0];
end

%% Use Robotics System Toolbox to create a trajectory from the waypoints
switch trajSelection
    case 1
        eePositions = trapveltraj(wayPoints',numPoints,'EndTime',waypointTime);
    case 2
        wpTimes = (0:size(wayPoints,1)-1)*waypointTime;
        trajTimes = linspace(0,wpTimes(end),numPoints);
        eePositions = cubicpolytraj(wayPoints',wpTimes,trajTimes, ...
            'VelocityBoundaryCondition',wayPointVels');
end

%% Set gripper state as 4th column of waypoints
if scenarioSelection == 3 % Gripper fault case
    % Enable grip in 2 places
    wayPoints(2:5,4) = 1;
    wayPoints(end-1:end,4) = 1;
else
    % Enable grip in all waypoints except the first and last
    wayPoints(2:end-1,4) = 1;
end

end


function [wayPoints,eePositions] = createWaypoints(trajectorySelection,numPoints)
% Define waypoints based on trajectory provided

% Copyright 2017-2018 The MathWorks, Inc.

    %% Create waypoints
    switch trajectorySelection
        case 1 % Simple Trajectory
            wayPoints = [0.2 -0.2 0.15; 0.2 -0.2 0.02; ... 
                         0.25 0 0.15; 0.2 0.2 0.02];
        case 2 % Complex Trajectory
            wayPoints = [0.2 -0.2 0.15; 0.2 -0.2 0.02; 0.15 0 0.28; ...
                         0.15 0.05 0.2; 0.15 0.09 0.15; 0.1 0.12 0.1; ... 
                         0.04 0.1 0.2; 0.25 0 0.15; 0.2 0.2 0.02];
        case 3 % Trajectory that will cause gripper fault
            wayPoints = [0.2 -0.2 0.15; 0.2 -0.2 0.02; 0.15 0 0.28; ...
                         0.15 0.05 0.2; 0.15 0.09 0.15; 0.1 0.12 0.1; ... 
                         0.04 0.1 0.2; 0.25 0 0.15; 0.2 0.2 0.03];
    end
    
    %% Use Curve Fitting Toolbox to create a spline from the trajectory points
    trajectory = cscvn(wayPoints');
    eePositions = ppval(trajectory,linspace(0,trajectory.breaks(end),numPoints));
    
    %% Set gripper state as 4th column of waypoints
    if trajectorySelection == 3 % Gripper fault case
        % Enable grip in 2 places
        wayPoints(2:5,4) = 1;
        wayPoints(end-1:end,4) = 1;
    else
        % Enable grip in all waypoints except the first and last
        wayPoints(2:end-1,4) = 1;
    end

end


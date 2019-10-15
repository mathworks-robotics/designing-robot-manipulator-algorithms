function [jointStates, iterations] = simInvKin(eePosition,initialGuess)
% This function is meant to be implemented as interpreted in MATLAB
% function blocks to provide inverse kinematics algorithms for simulations

% Copyright 2017-2018 The MathWorks, Inc.

    persistent simRobot
    persistent previousStates
    persistent ik

    % Following statement runs only once at initialization to create the rigid
    % body tree object and initial configuration. The persistent variables 
    % store data throughout the course of the simulation. This makes the 
    % object reusable and ensures an efficient simulation.

    if(isempty(simRobot))
       [simRobot,previousStates] = createRigidBodyTree;
       ik = robotics.InverseKinematics('RigidBodyTree',simRobot);
       ik.SolverParameters.MaxIterations = 30;
    end

    % Create a homogeneous transform from the desired end effector position 
    tform = trvec2tform(eePosition');

    % Populate the previous configuration structure with the input data from
    % simulation
    for idx = 1:4
        previousStates(idx).JointPosition = initialGuess(idx);
    end

    % Calculate the inverse kinematic solution using the "ik" solver 
    % Use desired weights for solution (First three are orientation, last three are translation)
    % Since it is a 4 DOF robot we dont put a weight on Z rotation otherwise it
    % really limits the solution space
    weights = [0.1, 0.1, 0, 1, 1, 1];
    [configSoln, info] = ik('end_effector',tform,weights,previousStates);
    iterations = info.Iterations;

    % Assign to the output variable from the robot configuration structure
    jointStates = zeros(4,1);
    for idx = 1:4
        jointStates(idx) = configSoln(idx).JointPosition;
    end

end


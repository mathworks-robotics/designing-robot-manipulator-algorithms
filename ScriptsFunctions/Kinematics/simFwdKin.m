function eePosition = simFwdKin(jointStates)
% This function is meant to be implemented as interpreted in MATLAB
% function blocks to provide forward kinematics algorithms for simulations

% Copyright 2018 The MathWorks, Inc.

    persistent simRobot
    persistent jointConfig

    % Following statement runs only once at initialization to create the rigid
    % body tree object and inital configuration. The persistent variables store data throughout the
    % course of the simulation. This makes the object reusable and ensures an
    % efficient simulation

    if(isempty(simRobot))
       [simRobot,jointConfig] = createRigidBodyTree();
    end

    % Assign input values to the persistent robot configuration struct
    for idx = 1:4
        jointConfig(idx).JointPosition=jointStates(idx);
    end

    % Use getTransform to to obtain position of end effector as transform
    tform = getTransform(simRobot,jointConfig,'end_effector');

    % Extract only translation portion of the transform
    eePosition = tform2trvec(tform);

end

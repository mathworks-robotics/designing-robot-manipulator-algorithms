function [robot,homeConfig] = createRigidBodyTree
% Creates a robotics.RigidBodyTree object to be used by the 
% forward and inverse kinematics blocks.

% Copyright 2018 The MathWorks, Inc.

   % Import the robot description from the URDF file
   robot = importrobot('open_manipulator_chain.urdf');
   
   % Add another coordinate frame for the end effector
   eeOffset = 0.12;
   eeBody = robotics.RigidBody('end_effector');
   setFixedTransform(eeBody.Joint,trvec2tform([eeOffset 0 0]));
   addBody(robot,eeBody,'link5');
   
   % Return its home configuration
   homeConfig = robot.homeConfiguration;

end


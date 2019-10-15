%% Assign mass and inertia to bodies
% These were determined from modified Onshape model
% https://cad.onshape.com/documents/faa35c12613c16b81746260b/w/8cac57d2336c73ff6385eb8d/e/d350ed6ec7164d6104fa6b35
% Assumes plastic parts (1.2 kg/m^3) and an aluminum motor (2.7 kg/m^3)

% NOTE: Inertia properties are [Ixx Iyy Izz Iyz Ixz Ixy] 

% Copyright 2018 The MathWorks, Inc.

% Body 1 - Base motor
robot.Bodies{1}.Mass = 0.082;
robot.Bodies{1}.Inertia = [1.867e-5, 3.208e-5, 2.83e-5, ...
                           7.71e-15, -3.102e-7, -3.067e-14];

% Body 2 - "Shoulder" joint
robot.Bodies{2}.Mass = 0.098;
robot.Bodies{2}.Inertia = [2.465e-5, 2.434e-5, 1.429e-5, ...
                           -8.638e-8, -4.872e-7, -1.08e-8];
                       
% Body 3 - Arm link 1
robot.Bodies{3}.Mass = 0.136;
robot.Bodies{3}.Inertia = [2.449e-4, 2.529e-4, 4.186e-5, ...
                           7.352e-7, -3.136e-5, 4.114e-8];
                       
% Body 4 - Arm link 2
robot.Bodies{4}.Mass = 0.131;
robot.Bodies{4}.Inertia = [3.347e-5, 2.361e-4, 2.481e-4, ...
                           -3.210e-9, -3.614e-7, 5.328e-7];
                       
% Body 5 - Gripper wrist
robot.Bodies{5}.Mass = 0.141;
robot.Bodies{5}.Inertia = [1.03e-4, 6.849e-5, 8.489e-5, ...
                           -3.875e-7, 3.639e-6, 6.255e-11];
                       
% Body 6 - Left gripper
robot.Bodies{6}.Mass = 0.017;
robot.Bodies{6}.Inertia = [5.373e-6, 1.467e-5, 1.017e-5, ...
                           5.075e-9, 2.461e-8, 7.928e-7];
 
% Body 7 - Right gripper
robot.Bodies{7}.Mass = 0.017;
robot.Bodies{7}.Inertia = [5.373e-6, 1.467e-5, 1.017e-5, ...
                           -5.075e-9, -2.461e-8, -7.928e-7];
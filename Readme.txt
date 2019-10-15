ROBOT MANIPULATOR CONTROL EXAMPLE
Copyright 2017-2018 The MathWorks, Inc.

------------------------------------------------------------------------------------------

ABOUT THE EXAMPLE:

This demo uses the ROBOTIS OpenManipulator Chain to demonstrate the design 
of manipulator algorithms using MATLAB and Simulink tools.

Forward and inverse kinematics are demonstrated using functions available 
within MATLAB as well as supervisory logic implemented in Stateflow.

Robot geometries are imported to MATLAB using the "importrobot" function
and to Simscape Multibody using the "smimport" function. For more information
on these functions check the associated documentation pages.

------------------------------------------------------------------------------------------

MAIN EXAMPLE FILES:

1. openManipulatorIK.m
    
    This file shows how to import a robot from a URDF description and use
    the generated rigid body tree representation to implement forward and
    inverse kinematics algorithms

2. openManipulatorWaypointTracking.slx
    
    This Simulink model uses Simscape Multibody as the environment and shows
    how to integrate the forward and inverse kinematics algorithms into Simulink
    to be used with Stateflow supervisory logic to pickup a ball, follow a
    trajectory, and finally drop the ball.

3. openManipulatorBallTracking.slx

    This Simulink model builds on the waypoint tracking model and adds simple
    perception to track and catch a moving ball using a polynomial 
    extrapolation of the ball trajectory.

4. openManipulatorTorqueCtrlCfg.slx

    This Simulink model tests the closed-loop torque controller, in configuration 
    space, using joint position commands (no inverse kinematics or supervisory logic).

5. openManipulatorTorqueCtrlTask.slx

    This Simulink model tests the closed-loop torque controller, in task 
    space, using end effector position commands (no supervisory logic).


------------------------------------------------------------------------------------------

PRODUCT REQUIREMENTS:

MATLAB
Simulink
Robotics System Toolbox
Curve Fitting Toolbox
Simscape
Simscape Multibody
Stateflow


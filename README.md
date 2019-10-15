# Robot Manipulator Control Example
Copyright 2017-2019 The MathWorks, Inc.

------------------------------------------------------------------------------------------

## About the Example

This example uses the ROBOTIS OpenManipulator Chain robot to demonstrate the 
design of manipulator algorithms using MATLAB and Simulink.

This submission depends on files from the following Git repository: https://github.com/ROBOTIS-GIT/open_manipulator. 
The `startupExample` script will attempt to download them, but if there are 
any errors there is a pre-imported model of the robot manipulator so you can 
still run the examples.

Forward and inverse kinematics are demonstrated using functions available 
within MATLAB as well as supervisory logic implemented in Stateflow.

Robot geometries are imported to MATLAB using the "importrobot" function
and to Simscape Multibody using the "smimport" function. For more information
on these functions check the associated documentation pages.

To learn more, refer to these videos:

* [Designing Robot Manipulator Algorithms](https://www.mathworks.com/videos/matlab-and-simulink-robotics-arena-designing-robot-manipulator-algorithms-1515776491590.html)
* [Controlling Robot Manipulator Joints](https://www.mathworks.com/videos/matlab-and-simulink-robotics-arena-controlling-robot-manipulator-joints-1521714030608.html)

------------------------------------------------------------------------------------------

## Main Example Files

1. `openManipulatorIK.m`
    
    This file shows how to import a robot from a URDF description and use
    the generated rigid body tree representation to implement forward and
    inverse kinematics algorithms

2. `openManipulatorWaypointTracking.slx`
    
    This Simulink model uses Simscape Multibody as the environment and shows
    how to integrate the forward and inverse kinematics algorithms into Simulink
    to be used with Stateflow supervisory logic to pickup a ball, follow a
    trajectory, and finally drop the ball.

3. `openManipulatorBallTracking.slx`

    This Simulink model builds on the waypoint tracking model and adds simple
    perception to track and catch a moving ball using a polynomial 
    extrapolation of the ball trajectory.

4. `openManipulatorTorqueCtrlCfg.slx`

    This Simulink model tests the closed-loop torque controller, in configuration 
    space, using joint position commands (no inverse kinematics or supervisory logic).

5. `openManipulatorTorqueCtrlTask.slx`

    This Simulink model tests the closed-loop torque controller, in task 
    space, using end effector position commands (no supervisory logic).

------------------------------------------------------------------------------------------

## Product Requirements

This submission was last updated and tested using MATLAB R2019b. 

The required toolboxes to run all examples are:

* MATLAB
* Simulink
* Robotics System Toolbox
* Simscape
* Simscape Multibody
* Stateflow

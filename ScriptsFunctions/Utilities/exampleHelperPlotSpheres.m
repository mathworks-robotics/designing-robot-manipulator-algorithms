function exampleHelperPlotSpheres(size,pointPosition)
% This function plots a sphere as points of interest

% Copyright 2017-2018 The MathWorks, Inc.

% Create points for visualizing a sphere
[X,Y,Z] = sphere(20);

% Translate to the specified position
X = size*X + pointPosition(1);
Y = size*Y + pointPosition(2);
Z = size*Z + pointPosition(3);
% Add the sphere to the figure and configure lighting
s = patch(surf2patch(X,Y,Z));
s.FaceColor = 'blue';
s.FaceLighting = 'gouraud';
s.EdgeAlpha = 0;
% Move the light so that the side of the cup is illuminated
lightObj = findobj(gca,'Type','Light');
lightObj.Position = [1,1,1];


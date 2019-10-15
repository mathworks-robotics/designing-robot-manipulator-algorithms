function exampleHelperPlotWaypoints(wayPoints)
% This function plots spheres as points of interest

% Copyright 2017-2018 The MathWorks, Inc.

for idx = 1:size(wayPoints,1)
   exampleHelperPlotSpheres(0.01,wayPoints(idx,:));
end


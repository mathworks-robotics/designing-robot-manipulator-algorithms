function ready = checkDependencies
% This function checks whether all the necessary files to run the
% example are available on the MATLAB path. It also modifies the
% robot description file to a format compatible to be imported into
% MATLAB and Simulink.

% Copyright 2017-2018 The MathWorks, Inc.

% Initialize the readiness flag
ready = true;

gitRepo = 'https://github.com/ROBOTIS-GIT/open_manipulator';

disp('Checking for open_manipulator_description files...')

% Check for the necessary project folder from the repository
% If the folder does not exist, clone the Git repository
if exist('open_manipulator_description','dir')~=7
    disp(['Attempting to clone Git repository from ' gitRepo '...']);
    [status,~] = system(['git clone ' gitRepo]);
    
    % If cloning the repository failed, warn user that git is not installed
    if status ~= 0
        d = dialog('Position',[450 450 280 250],'Name','OpenManipulator description files not found');
        uicontrol('Parent',d,...
            'Style','text',...
            'Position',[20 50 250 180],...
            'String',{'Attempt failed. Make sure you have installed Git: https://git-scm.com/downloads or download the files manually.', ...
                      '',['Please make sure to have the ''open_manipulator_description'' folder on the MATLAB path. Find this folder in the following repository: ' gitRepo]});
        uicontrol('Parent',d,...
            'Position',[110 20 70 25],...
            'String','Close',...
            'Callback','delete(gcf)');
        disp('Attempt failed');
        disp(['Copy the following link to the Git repository: ' gitRepo]);
        ready = false;
        return;
    end
    
    % If successful, add files to path
    disp('Done');
    addpath(genpath(pwd));
end

% Check for the modified URDF file. If it exist, we are all set.
if isempty(which('open_manipulator.urdf'))
    % If the URDF file does not exist, check for the XACRO file from
    % the Git repository and modify it.
    xacroFile = which('open_manipulator.urdf.xacro');
    if ~isempty(xacroFile)
        disp('Modifying necessary description files...');
        urdfFolder = fileparts(xacroFile);
        urdfFile = fullfile(urdfFolder,'open_manipulator.urdf');
        filetext = fileread('open_manipulator.urdf.xacro');
        % String replace all the expressions with numeric values
        searchExpression = '\${[^}]*\d+[^}]*}'; % Starts with $ and has text (with at least one number) between { }
        [startIdx,endIdx] = regexp(filetext,searchExpression);        
        while ~isempty(startIdx)
           token = filetext(startIdx(1):endIdx(1));
           numericVal = eval(token(3:end-1));
           filetext = strrep(filetext,token,num2str(numericVal));
           [startIdx,endIdx] = regexp(filetext,searchExpression);
        end
        % Write the URDF file with the new text
        file = fopen(urdfFile,'w');
        fwrite(file,filetext);
        fclose(file);
        disp('Done');
        
    % Give a warning if the description file is not found
    else
        d = dialog('Position',[450 450 280 250],'Name','Open Manipulator Description xacro file not found');
        uicontrol('Parent',d,...
            'Style','text',...
            'Position',[20 50 250 180],...
            'String',{['Please make sure to have the ''open_manipulator.urdf.xacro'' file in the MATLAB path. Find this file and other necessary dependencies in the following repository: ' gitRepo], ...
                       '','Else, this example will use the preloaded robotics.RigidBodyTree object in openManipulatorDescription.mat'});
        uicontrol('Parent',d,...
            'Position',[110 20 70 25],...
            'String','Close',...
            'Callback','delete(gcf)');
        ready = false;
    end
end

disp('Done checking')

end


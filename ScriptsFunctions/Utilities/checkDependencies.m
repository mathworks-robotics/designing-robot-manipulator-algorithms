% This function checks whether all the necessary files to run the
% demosntration are available on the MATLAB path. It also modifies the 
% robot description file to a format compatible to be imported into
% Simulink.

% Copyright 2018 The MathWorks, Inc.

function ready=checkDependencies

% Check for the necessary project folder from the repository

disp('Checking for Open_Manipulator_Description files.....')

% Attempt to use GIT integration to clone the repository
if exist('open_manipulator_description','dir')~=7
    disp('Attempting to checkout repository from GIT.....');
    [status,~]= system('git clone https://github.com/ROBOTIS-GIT/open_manipulator');
    disp('Done');
    
    % Address failed GIT support
    if status ~= 0
        disp('Attempt failed. Make sure you have installed GIT bash software: http://gitforwindows.org/ or download the files manually');
        d = dialog('Position',[450 450 280 250],'Name','Open Manipulator Description files not found');
        
        txt = uicontrol('Parent',d,...
            'Style','text',...
            'Position',[20 150 250 80],...
            'String','Please make sure to have the ''Open_Manipulator_Description'' folder on the MATLAB path. Find this folder in the following submission:  https://github.com/ROBOTIS-GIT/open_manipulator');
        
        btn = uicontrol('Parent',d,...
            'Position',[85 20 70 25],...
            'String','Close',...
            'Callback','delete(gcf)');
        disp('Copy the following link to the GIT repository: https://github.com/ROBOTIS-GIT/open_manipulator');
        ready=0;
        
    % If succesful, add files to path 
    else
        addpath(genpath(pwd));
        disp('Modifying necessary description files.....');
        
        % Create a description file in the supported URDF format by
        % removing XACRO elements
        if exist('open_manipulator_chain.xacro','file')==2
            filetext=fileread('open_manipulator_chain.xacro');
            temptxt=strrep(filetext,'${pi*0.9}','2.8274');
            temptxt=strrep(temptxt,'${-pi*0.9}','-2.8274');
            file=fopen('open_manipulator_chain.urdf','w');
            fwrite(file,temptxt);
            fclose(file);
            disp('Done');
            ready=1;
            
        % Give a warning if the description file is not found
        else
            d = dialog('Position',[450 450 280 250],'Name','Open Manipulator Description xacro file not found');
            
            txt = uicontrol('Parent',d,...
                'Style','text',...
                'Position',[20 150 250 80],...
                'String','Please make sure to have the ''open_manipulator_chain.xacro''file in the MATLAB path. Find this file and other necessary dependencies in the following submission:  https://github.com/ROBOTIS-GIT/open_manipulator');
            
            btn = uicontrol('Parent',d,...
                'Position',[85 20 70 25],...
                'String','Close',...
                'Callback','delete(gcf)');
            ready=0;
        end
    end
else
    ready=1;
end
disp('Done checking')
end


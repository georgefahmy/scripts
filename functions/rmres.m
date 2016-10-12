function rmres(flightid)
%this function will allow the user to delete the results file from any
%folder, allowing the user to rerun the full flight analysis as opposed to
%just loading the existing data. the user an identify a specific folder to
%remove the results directory from, or they can choose from their folders.

    startdir = '/Users/georgeKespry/Documents/Projects/Matlab/Data/';
    assignin('base','startdir',startdir);
    cd (startdir);
    if exist('flightid','var')
        pathname = [startdir mat2str(flightid)];
        assignin('base','pathname',pathname);
    else 
        if ~exist('pathname','var')
            pathname = uigetdir('Select Folder for Data');
            assignin('base','pathname',pathname);
            if pathname == 0
                close all;
                clc;
                fprintf('User selected Cancel\n');
                return
            end
        end
    end
    fprintf('Removed results folder from\n');
    fprintf('%s\n',pathname);
    if exist([pathname '/_results.txt'],'file') == 2
        cd(pathname);
        delete([pathname '/' '_results.txt'])
        delete([pathname '/' '_summary.txt'])
        delete([pathname '/' '_workspace.mat'])
        cd(startdir)
    else
        fprintf('Results folder does not exist\n\n')
        return
    end
end
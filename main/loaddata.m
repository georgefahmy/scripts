function loaddata(folder)
%% New file import
% This script streamlines the file definitions, import functions and
% variable assignments. it starts with the standard pathname and
% filestructure, the file names from the directory are then stored into a
% cell, then we filter which files we care about using regexp. the second
% for loop will then define the variable name, load the data and then store
% that data into the variable of the correct name. this script will import
% all relevant files for analysis.
startdir = '~/Documents/Projects/Matlab/Data/'; %set to your data directory
assignin('base','startdir',startdir);
global workspace;
cd (startdir);
if exist('folder','var')
    pathname = [startdir mat2str(folder)];
    assignin('base','pathname',pathname);
else 
    if ~exist('pathname','var')
        
        pathname = uigetdir(startdir,'Select Folder for Data');
        assignin('base','pathname',pathname);
        if pathname == 0
            close all;
            clc;
            fprintf('User selected Cancel\n');
            return
        end
        if pathname == '0'
            close all;
            clc;
            fprintf('User selected Cancel\n')
            return
        end
    end
end
temp = regexp(pathname,'/');
if length(pathname(temp(end)+1:end)) == 10
    flightid = pathname(temp(end)+1:end);
    assignin('base','flightid',flightid);
    clear temp;
elseif length(pathname(temp(end)+1:end)) == 5
    flightid = [pathname(temp(end)+1:end) '_' 'fly'];
    assignin('base','flightid',flightid);
    clear temp;
else
    flightid = '';
    assignin('base','flightid',flightid);
    clear temp;
end
filestruct = dir(pathname); 
files = {'Names'};
j = 1;
for i = 1:length(filestruct)
    files{j,1} = char(strcat((filestruct(i).name)));
    j = j+1;
end
ind = cellfun(@isempty,regexp(files,'^\.|kdz$|map|complete|raw|uploaded|summary|_results.txt'));
files = files(ind);
isresults = ~cellfun(@isempty,regexp(files,'_results'));
isresults2 = ~cellfun(@isempty,regexp(files,'_workspace'));

%this is for rerunning data
%%%%%%%%%%%%%%
if ~isempty(files(isresults)) || ~isempty(files(isresults2))
    resultsfolder = [pathname '/' cell2mat(files(isresults))];
    if ~isempty(files(isresults2))
        workspacefile = [pathname '/' cell2mat(files(isresults2))];
        data = load(workspacefile);
%         close all;
        loaded_workspace = 1;
        assignin('base','loaded_workspace',1)
        temp = structvars(data);
        temp2 = size(temp,1);
        for i = 1:temp2
            assignin('base',temp(i,1:regexp(temp(i,:),'=')-2) ,eval(temp(i,regexp(temp(i,:),'=')+2:end-1)));
        end
        clear workspacefile;
        fprintf('Loaded Data %s\n',flightid);
       
        return
    end
    results = dir(resultsfolder);
    for i = 1:length(results)
        resultfiles{j,1} = char(strcat((results(i).name)));
        j = j+1;
    end
    isworkspace = ~cellfun(@isempty,regexp(resultfiles,'workspace.mat'));
    theworkspace = resultfiles(isworkspace);
    if ~isempty(theworkspace)
        data = load([pathname '/' cell2mat(files(isresults)) '/' theworkspace{end}]);
%         close all;
        loaded_workspace = 1;
        assignin('base','loaded_workspace',1)
        temp = structvars(data);
        temp2 = size(temp,1);
        for i = 1:temp2
            assignin('base',temp(i,1:regexp(temp(i,:),'=')-2) ,eval(temp(i,regexp(temp(i,:),'=')+2:end-1)));
        end
        clear theworkspace;
        fprintf('Loaded Data %s\n',flightid);
       
        return
    else
        isresults = cellfun(@isempty,regexp(files,'_results'));
        files = files(isresults);
        loaded_workspace = 0;
        cont = 0;
        assignin('base','loaded_workspace',0)
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%assignin('base',['flight_' flightid],struct());
flightvar = ['flight_' flightid];
loaded_vars = {'names'};
for i = 1:length(files)
    if ~exist('loaded_workspace','var')
        loaded_workspace = 0;
        assignin('base','loaded_workspace',0)
    end
    temp = cell2mat(files(i));
    temp2 = regexp(cell2mat(files(i)),'[.]');
    file = [pathname '/' temp];    
    if length(temp2) == 2
        if ~exist('drone','var')
            drone = temp(1:temp2(1)-1);
            assignin('base','drone',drone);
            if drone(1) == 'o' || drone(1) == 'a'
                dronetype = 1;
                assignin('base','dronetype',1)
            else 
                dronetype = 0;
                assignin('base','dronetype',0)
            end
        end
        variable = temp(temp2(1)+1:temp2(2)-1);
        assignin('base',variable,importdata(file));
        fprintf('Loaded %s\n',variable);
        loaded_vars{i,1} = variable;
    elseif length(temp2) == 1 && temp2 == 8
        variable = 'geotags'; 
        assignin('base',variable,importgeotags(file));
        fprintf('Loaded %s\n',variable);
        loaded_vars{i,1} = variable;
    elseif length(temp2) == 1 && temp2 == 5
        variable = 'meta'; 
        assignin('base',variable,importmeta(file));
        fprintf('Loaded %s\n',variable);
        loaded_vars{i,1} = variable;
    end
    assignin('base','loaded_vars',loaded_vars);
end

fprintf('File Import Complete\n\n');


%unixtodate(flightid);

clear variable temp* file* i j ind isresults isworkspace theworkspace result*;

workspace = whos;
assignin('base','workspace',workspace);



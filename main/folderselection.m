%% Multiple folder loading stuff
% This will allow the user to select multiple folders from the data
% directory. Once the user has selected the folders desired, the script
% will import the files listed, store them into a structure
% flights.flight_id, this allows the the data to be viewed all together.
startdir = '/Users/georgeKespry/Documents/Projects/Matlab/Data/';
cd (startdir);

%%%%%%%%%%
%list the folders available for analysis from the data directory
start_data = dir(startdir);
data_names = {'names'};
k = 1;
for i = 5:length(start_data)
    if length(start_data(i).name) == 10
        data_names{k,1} = (start_data(i).name);
        k = k+1;
    end
end

[selection, ok] = listdlg('ListString',data_names,'SelectionMode','Multiple');

num_folders = size(selection);
num_folders = num_folders(2);
%%%%%%%%%%

if ~ok
    
    fprintf('User Selected Cancel\n');
    return
    
elseif ok
    
    for i = 1:num_folders
        folder = data_names{selection(i)};
        data = dir([startdir folder]);
            
        %%%%%%%%%%
        %list files from folders
        j = 1;
        for ii = 1:length(data)
            files{j,1} = char(strcat((data(ii).name)));
            j = j+1;
        end
        %remove files that we dont care about.
        ind = cellfun(@isempty,regexp(files,'^\.|kdz$|map|complete|raw|uploaded|summary|_results.txt|_workspace.mat|meta.json'));
        files = files(ind);
        %%%%%%%%%%
        
        %%%%%%%%%%
        % Change this to isolate files to import.
        %
        % att_con_telem
        % att_rate_con_telem
        % baro
        % command_interface_status
        % con_con_config
        % controller_watchdog_plan
        % emb_command
        % emb_controller
        % emb_estimator
        % emb_mgmt
        % emb_sensor
        % emb_state
        % gps_state
        % gps_ubx_nav_pvt
        % gps_ubx_nav_svinfo
        % high_controller_time_stats
        % lidar
        % mission_progress
        % path_queue
        % path_target
        % pos_con_config
        % pos_con_telemetry
        % sensor_x86
        % system_monitor
        vars = ['emb_sensor.tsv|emb_mgmt.tsv'];
        ind = ~cellfun(@isempty,regexp(files,vars));
        files2 = files(ind);
        %%%%%%%%%%
       
        %%%%%%%%%%
        % drone name identification
        temp0 = files{end-2};
        temp1 = regexp(temp0,'[.]');
        assignin('base','drone',temp0(1:temp1(1)-1))
        %%%%%%%%%%
                  
        %%%%%%%%%%
        %importing files
        for l = 1:length(files2)
            temp1 = regexp(files2{l},'[.]');
            file = [startdir folder '/' files2{l}];
            variable = files2{l}(temp1(1)+1:temp1(2)-1);
            flights.(['flight_' folder]).(variable) = importdata(file);
%             fprintf('Loaded %s\n',variable);
        end
        %%%%%%%%%%
        
        %%%%%%%%%%
        fprintf('Saved %s %s\n',folder,drone);
        %%%%%%%%%%
    end
    
    %%%%%%%%%%
    % assigning the flights to seperate variables
    fields = fieldnames(flights);
    for i = 1:length(fields)
        assignin('base',fields{i},flights.(fields{i}))
    end
    clearvars -except flight_* fields
    %%%%%%%%%%
end

structextractor;

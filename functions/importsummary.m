function mission_summary = importsummary(file)
%% mission summary import
    fid = fopen(file);
    raw = textscan(fid,'%s','Delimiter',',');
    raw = raw{1};
    mission_summary_file = raw;
    fclose(fid);
    mission_summary_file = regexprep(mission_summary_file,'"','');
    mission_summary_file = regexprep(mission_summary_file,'}','');
%%
    ind1 = ~cellfun(@isempty,regexp(mission_summary_file,'start_time'));
    ind2 = ~cellfun(@isempty,regexp(mission_summary_file,'flight_id'));
    ind3 = ~cellfun(@isempty,regexp(mission_summary_file,'drone_name'));
    ind4 = ~cellfun(@isempty,regexp(mission_summary_file,'duration'));
    ind5 = ~cellfun(@isempty,regexp(mission_summary_file,'flight_end_state'));
    ind13 = ~cellfun(@isempty,regexp(mission_summary_file,'flight_end_reason'));
    ind6 = ~cellfun(@isempty,regexp(mission_summary_file,'mission_name'));
    ind7 = ~cellfun(@isempty,regexp(mission_summary_file,'uid'));
    ind8 = ~cellfun(@isempty,regexp(mission_summary_file,'drone_software_version'));
    ind9 = ~cellfun(@isempty,regexp(mission_summary_file,'drone_height'));
    ind10 = ~cellfun(@isempty,regexp(mission_summary_file,'imaging_height'));
    ind11 = ~cellfun(@isempty,regexp(mission_summary_file,'user_email'));
    
    
%%

mission_summary.start_time = mission_summary_file(ind1);         %start_time
mission_summary.start_time = mission_summary.start_time{1};
mission_summary.flight_id = mission_summary_file(ind2);               %flight_id
mission_summary.flight_id = mission_summary.flight_id{1};
mission_summary.drone_name = mission_summary_file(ind3);              %drone_name
mission_summary.drone_name = mission_summary.drone_name{1};
mission_summary.duration = mission_summary_file{ind4};                %duration
mission_summary.flight_end_state = mission_summary_file{ind5};        %flight_end_state
mission_summary.flight_end_reason = mission_summary_file{ind13};
mission_summary.mission_name = mission_summary_file{ind6};            %mission_name
mission_summary.battery_info = mission_summary_file{ind7};           %battery_info
mission_summary.sw_version = mission_summary_file{ind8};  %drone_software_version
mission_summary.fly_height = mission_summary_file{ind9};            %drone_height
mission_summary.imaging_height = mission_summary_file{ind10};         %imaging_height
mission_summary.user_email = mission_summary_file{ind11};             %user_email

%disp(mission_summary);

    

    

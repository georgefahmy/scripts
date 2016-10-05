%% Flight_analysis
%----------Copyright----------
%---George Fahmy 04/19/2016---
%-----Copyright(c) Kespry-----
%-----All Rights Reserved-----

%This script runs through all the flight data files to check for flight
%info that will be used to calculate a number of important factors for
%determing the quality of flight, as well as display plots of important
%flight data.
%
ccc;
loaddata;

if ~pathname
    return
end

%% initial analyis
if exist('meta','var') && length(meta) >= 20
    meta = meta_data_analysis(meta);
end

if isempty(flightid)
    
    fprintf('flight id is empty\n')
    flightid = 'empty';
    
elseif strcmp(flightid(end-2:end),'fly')
    
    movefile(pathname,[startdir meta.flightid]);
    meta.fly_id = flightid(1:end-4);
    flightid = meta.flightid;
    pathname = [startdir meta.flightid];
    fprintf('Flightid determined from meta data: %s\n',flightid);
    
elseif exist('meta','var') && isfield(meta,'flightid')
    
    flightid = str2mat(meta.flightid);
    fprintf('Flight id: %s\n',flightid);
end

if exist('meta','var') && isfield(meta,'poly') && isfield(meta,'home')
    poly2 = meta.poly(:,1) - meta.home(1);
    poly2(:,end+1) = meta.poly(:,2) - meta.home(2);
end  
if exist('emb_sensor','var')
    emb_sensor = sensor_data_analysis(emb_sensor);
end
gainsdefine;
stateanalysis;

%% Save
    
%flight time    
if exist('emb_command','var') && ~isfield(flightdata,'totaltime')
    flightdata.totaltime = (emb_command.recv_timestamp(end)-emb_command.recv_timestamp(1))/60;
elseif ~isfield(flightdata,'totaltime')
    flightdata.totaltime = (gps_state.recv_timestamp(end) - gps_state.recv_timestamp(1))/60;
end
%Discription of flight
if ~loaded_workspace && ~exist('desc','var')
    [desc] = inputdlg('Enter a description of the flight','Description',2);
    if isempty(cell2mat(desc))
        fprintf('User selected Cancel');
        return
    end
    saveresults;
elseif loaded_workspace && ~exist('desc','var')
    desc = '';
    saveresults;
end

clear data flight_* ;
save ([pathname '/_workspace']);
done = fprintf('Saved workspace\n');

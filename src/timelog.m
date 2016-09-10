%% Flight 
if exist([startdir 'flight_time_log.txt']) == 2
    [prevflid,new_total,prevtime] = getlog([startdir 'flight_time_log.txt']);
    if ~ismember(str2double(flightid),prevflid)
        if length(fieldnames(flightdata)) > 5
            if ~isfield(flightdata,'totaltime')
                flightdata.totaltime = (emb_command.recv_timestamp(end)-emb_command.recv_timestamp(1))/60;
            end
            fid  = fopen([startdir 'flight_time_log.txt'],'at+');
            formatspec = '%.0f %s %.2f';

            fprintf(fid,'%s   %s       %.2f        %.2f\n',...
                    flightdata.flightid,flightdata.flightdate,flightdata.totaltime,new_total+flightdata.totaltime);
            fclose(fid);
        end
    end
end

%%
if 0
    fid = fopen([startdir 'flight_time_log.txt']);

    header = fgetl(fid);
    header2 = strsplit(header,' ');

    str = repmat('%s',1,21);
    raw = textscan(fid,[ '%[^\n\r]'],'HeaderLines',1);
    for i = 1:length(raw{1})
        raw2(i) = cell2mat(strsplit(raw{1}{i},' '));
    end

    raw{1}; %flightid
    raw{4}; %date
    raw{5}; %time
    raw{12}; %flight_time
    raw{20}; %total_time

    fclose(fid);
end
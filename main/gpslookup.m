%% find all flights where gps is bad
startdir = '/Users/georgeKespry/Documents/Projects/Matlab/Data/';
cd (startdir);
data = dir(startdir);
badflight = {'names'};
jj = 1;
for i = 5:length(data)
    temp = dir([startdir data(i).name]);
    j = 1;
    for ii = 1:length(temp)
        files{j,1} = char(strcat((temp(ii).name)));
        j = j+1;
    end
    ind = ~cellfun(@isempty,regexp(files,'gps_ubx_nav_pvt.tsv*'));
    file = files(ind);
    if ~isempty(file)
        file = cell2mat([startdir data(i).name '/' file(1)]);
        assignin('base','gps_ubx_nav_pvt',importdata(file));
        var = eval(cell2mat(who('gps_ubx_nav_pvt*')));
        if isfield(var,'h_acc');
            if max(diff(var.h_acc)) > 100;
    %             plot(diff(var.h_acc));
    %             pause(1);
                fprintf('%s\n',data(i).name);
                badflight{jj,1} = char(strcat((data(i).name)));
                jj = jj+1;
            end
        else isfield(var,'hAcc');
            if max(diff(var.hAcc)) > 100;
    %             plot(diff(var.hAcc));
    %             pause(1);
                fprintf('%s\n',data(i).name);
                badflight{jj,1} = char(strcat((data(i).name)));
                jj = jj+1;
                
            end
        end
    end
    close all;
    clear file*;
end
    
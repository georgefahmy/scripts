function [geotags] = importfile(filename, startRow, endRow)
%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 3;
    endRow = inf;
end

%% Format string for each line of text:
formatSpec = '%s%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Allocate imported array to column variable names
geotags.file_name = dataArray{:, 1};
geotags.long = dataArray{:, 2};
geotags.lat = dataArray{:, 3};
geotags.alt = dataArray{:, 4};
geotags.roll = dataArray{:, 5};
geotags.pitch = dataArray{:, 6};
geotags.yaw = dataArray{:, 7};
geotags.enable = dataArray{:, 8};
geotags.timestamp = dataArray{:, 9};
geotags.var_x = dataArray{:, 10};
geotags.var_y = dataArray{:, 11};
geotags.var_z = dataArray{:, 12};




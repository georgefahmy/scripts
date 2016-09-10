function totaltime = getresults(results)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   VARNAME3 = IMPORTFILE(FILENAME) Reads data from text file FILENAME for
%   the default selection.
%
%   VARNAME3 = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows
%   STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   VarName3 = importfile('resuts.txt',4, 4);
%
%    See also TEXTSCAN.
 
% Auto-generated by MATLAB on 2015/09/01 10:08:33

%% Initialize variables.
delimiter = {' ',':'};
if nargin<=2
    startRow = 4;
    endRow = 4;
end

%% Format string for each line of text:
%   column3: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%f%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(results,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
textscan(fileID, '%[^\n\r]', startRow(1)-1, 'ReturnOnError', false);
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    textscan(fileID, '%[^\n\r]', startRow(block)-1, 'ReturnOnError', false);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'ReturnOnError', false);
    dataArray{1} = [dataArray{1};dataArrayBlock{1}];
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
totaltime = dataArray{:, 1};



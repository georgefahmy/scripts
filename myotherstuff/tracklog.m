%% tracklog analysis
function tracklog(file)

if exist('file','var')
    assignin('base','file',file);
else 
    if ~exist('file','var')
        cd '~/Desktop/tracklogs'
        file = uigetfile('*.*','Select the tracklog to analyze');
        assignin('base','file',file);
        if file == 0
            close all;
            clc;
            fprintf('User selected Cancel\n');
            return
        end
    end
end
 
fid = fopen(file,'r');
header = fgetl(fid); % I have to do this 3 times to get to the correct line
header = fgetl(fid); % in the file
header = fgetl(fid);
header = regexprep(header,' ','_');
header = strsplit(header,',')';
header = header(1:end-1);

str = repmat('%n',1,length(header));

raw = textscan(fid,[str '%[^\n\r]'],'Delimiter',',','Headerlines',3);

for i = 1:length(header)
    data.(cell2mat(header(i))) = cell2mat(raw(i));
end
if ~isempty(regexp(file,'[.]','ONCE'))
    filename = file(1:regexp(file,'[.]')-1);
end
assignin('base',filename,data);
fprintf('loaded %s\n',file)


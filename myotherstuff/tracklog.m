%% tracklog analysis
function [data] = tracklog(file)
 
fid = fopen(file,'r');
header = fgetl(fid);
header = fgetl(fid);
header = fgetl(fid);
header = regexprep(header,' ','_');
header = strsplit(header,',')';
header = header(1:end-1);

str = repmat('%n',1,length(header));

raw = textscan(fid,[str '%[^\n\r]'],'Delimiter',',','Headerlines',3);

for i = 1:length(header)
    data.(cell2mat(header(i))) = cell2mat(raw(i));
end

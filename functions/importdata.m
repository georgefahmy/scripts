function [data] = importdata(file)

fid = fopen(file);

%isolates the headerline
headerline = fgetl(fid);
%replaces the  '.' with a '_' so it can be used as a variable
headerline = regexprep(headerline,'[.]','_');
%below changes the [0] to a _r_ so it can be used as a variable name
headerline = regexprep(headerline,'[','_');
headerline = regexprep(headerline,']','');
%below we change 0,1,2 to roll pitch yaw for easier identification
headerline = regexprep(headerline,'0','r'); %Roll
headerline = regexprep(headerline,'1','p'); %Pitch
headerline = regexprep(headerline,'2','y'); %Yaw

%stores the headerline info in a cell from a tab delimited line
header = strsplit(headerline,'\t')';
header = header(1:end-1);

if isempty(header)
    header = {'rawdata'};
end

if length(header) ~= 1 % regexp(header{2},'process_name_')
    %str = repmat('%s',1,length(header)); %come back to this later
    str = repmat('%n',1,length(header));
else
    str = repmat('%n',1,length(header));
   temp = 1;
end

raw = textscan(fid,[str '%[^\n\r]'],'HeaderLines',1,'Delimiter','\t');

for i = 1:length(header)
   
       data.(cell2mat(header(i))) = cell2mat(raw(i));
  
   if ~isempty(regexp(header{i,1},'recv_timestamp','ONCE')) && ~isempty(data.(cell2mat(header(i))))
       data.(cell2mat(header(i))) = data.(cell2mat(header(i))) - data.(cell2mat(header(i)))(1);
   end
%    if ~isempty(regexp(header{i,1},'timestamp','ONCE')) && ~isempty(data.(cell2mat(header(i))))
%        data.(cell2mat(header(i))) = data.(cell2mat(header(i))) - data.(cell2mat(header(i)))(1);
%    end
   
end

fclose(fid);

%this removes all NaNs from the data
temp1 = fieldnames(data);
for i = 1:length(temp1)
    temp2 = data.(temp1{i});
    temp2(isnan(temp2)) = [];
    data.(temp1{i}) = temp2;      
end

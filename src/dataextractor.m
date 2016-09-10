%% Data extractor
startdir = '/Users/georgeKespry/Documents/Projects/Matlab/Data/';
cd (startdir);
load('data');
validflights = fieldnames(data);

[selection,ok] = listdlg('ListString',validflights,'SelectionMode','single','Name','Data Extractor','PromptString','Select Flight');
if ok
    flightid = cell2mat(validflights(selection));
    flightid = flightid((end-9:end));
    selectedflight = data.(cell2mat(validflights(selection)));
    fprintf('User selected flight %s\n',flightid);
else
    fprintf('User selected cancel\n');
    return
end

vars = fieldnames(selectedflight);

for i = 1:length(fieldnames(selectedflight))
    
    assignin('base',cell2mat(vars(i)),selectedflight.(cell2mat(vars(i))));
    fprintf('Extracted: %s \n',cell2mat(vars(i)));
    pause(0.01);
end

%% FFT 
workspace = whos;
validvars = {'Names'};
j = 1;

for i = 1:length(workspace)
    
    if ~isempty(regexp(str2mat(workspace(i).class),'struct','ONCE'))
        %this stores the available structure variables in the validvars
        %list below.
        validvars{j,1} = str2mat(strcat((workspace(i).name)));
        j = j+1;
    end
end
myindices = cellfun(@isempty,regexp(validvars,'gains$|folders|files|meta|caps|workspace|data|con_con_config|selectedflight'));
validvars = validvars(myindices);

%this lists the available structs in the workspace, choose from the
%list and it will allow you select a variable within the struct.
[selection,ok] = listdlg('ListString',validvars,'SelectionMode','single','Name','Struct Plotter','PromptString','Select a struct');

if ok
    selectedvar = eval(cell2mat(validvars(selection)));
else
    fprintf('User Selected Cancel\n');
    return
end
validfields = fieldnames(selectedvar);
%this then chooses the desired variable for plotting the fft of the
%function.

[selection2,ok] = listdlg('ListString',validfields,'SelectionMode','single','Name','Struct Plotter','PromptString','Select a struct');
selectedstruct = cell2mat(validvars(selection)); %the user selected structure
selectedfield = cell2mat(validfields(selection2)); %the selected field of that struct.

if ok
    variable = eval([selectedstruct '.' selectedfield]);
    timevar = eval([selectedstruct '.' 'recv_timestamp']);
else
    fprintf('User Selected Cancel\n');
    return
end

Fs = length(variable)/(timevar(end)-timevar(1)); %sampling frequency

if Fs < 75 

    timevector = [0:1/round(Fs):((length(variable)-1)/round(Fs))];

elseif Fs >= 75 && Fs <= 125

    timevector = [0:1/round(Fs):((length(variable)-1)/round(Fs))];

elseif Fs > 150

    timevector = [0:1/round(Fs):((length(variable)-1)/round(Fs))];

end

range = input('Enter Window Range, 0 for full range: \n','s');
if length(range) == 1 && str2num(range) == 0
    ind1 = 1;
    ind2 = length(variable);
else 
    ind1 = find(round(timevector) == str2num(range(1:regexp(range,' ')-1)));
    ind2 = find(round(timevector) == str2num(range(regexp(range,' '):end)));
end
           
L = length(variable(ind1:ind2));          % Length of signal
NFFT = 2^nextpow2(L); %
Y  = abs(fft(detrend(variable(ind1:ind2)),NFFT)/L);
f = Fs/2*linspace(0,1,NFFT/2);
thedata = 2*abs(Y(1:NFFT/2)); %the data that has been fft'd
window = 10; %smoothing window
if window == 1
    windowsize = ' ';
else 
    windowsize = [' window of ' mat2str(window)];
end
displayname = [regexprep(selectedfield,'_',' ') windowsize];

temp0 = gcf;
    if ~isempty(temp0.Name)
        yes = samefigchoice;
        if yes
            fprintf('Continuing plot on existing figure...\n\n');
            pause(.2);
        elseif ~yes
            figure('Name',[selectedstruct],'WindowStyle','docked');
            hold on;
        end
    else
        if isempty(temp0.Name)
            close(gcf);
        end
        figure('Name',[selectedstruct],'WindowStyle','docked');
        hold on;
    end
    hold on;
    plot(f,movingmean(thedata,window),'DisplayName',displayname);
    set(gca,'YScale','log');
    grid on;
    ylim([mean(thedata)*1e-3 mean(thedata)*1e3]);
    xlim([0 round(Fs)/2]);
    xlabel('frequency');
    legend('-DynamicLegend','Location','Best');
    
fprintf('plotting %s\n', [selectedstruct '.' selectedfield])   
fprintf('\nSampling Frequency is %.1f Hz\n',round(Fs));    
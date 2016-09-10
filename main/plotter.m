%% plotter

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
myindices = cellfun(@isempty,regexp(validvars,'gains$|folders|files|meta|caps|workspace|data|con_con_config|selectedflight|selectedvar'));
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
%this gets the fieldnames from the selected structure to plot.
validfields = fieldnames(selectedvar);
myindices = cellfun(@isempty,regexp(validfields,'recv_timestamp|timestamp'));
validfields = validfields(myindices);
%this then chooses the desired variable for plotting the fft of the
%function. 
[selection2,ok] = listdlg('ListString',validfields,...
           'SelectionMode','multiple','Name','Plotter','PromptString','Select fields');
selectedstruct = cell2mat(validvars(selection)); %the parent struct
selectedfields = (validfields(selection2)); %the variable(s) chosen.

temp = size(selectedfields); %this is used if multiple variables are selected.


if ok
    % 
    
    temp0 = gcf;
    if ~isempty(temp0.Name)
        yes = samefigchoice;
        if yes
            fprintf('Continuing plot on existing figure...\n\n');
            pause(.2);
        elseif ~yes
            figure('Name',[selectedstruct],'WindowStyle','docked');
        end
    else
        if isempty(temp0.Name)
            close(gcf);
        end
        figure('Name',[selectedstruct],'WindowStyle','docked');
    end
    
    hold on;
    grid on;
    %determines if the user selects the nanoseconds field. using
    %nanoseconds can be very useful for aligning data from embedded.
    if ~isempty(cell2mat(regexp(selectedfields,'nanoseconds')))
        timevar = eval([selectedstruct '.' 'nanoseconds']);
    elseif isfield(eval(selectedstruct),'recv_timestamp')
        timevar = eval([selectedstruct '.' 'recv_timestamp']);
    elseif ~isempty(regexp([selectedstruct],'score','ONCE'))
        timevar = [0:0.01:10];
    end
    
    for i = 1:temp(1)
            %If using the nanoseconds field to plot, this skips plotting it.
            if ~isempty(cell2mat(regexp(selectedfields(i,:),'nanoseconds')))
                fprintf('Using nanoseconds as timescale\n\n');
                continue
            else
                variable = eval([selectedstruct '.' cell2mat(selectedfields(i,:))]);
                fprintf('Plotting %s\n',[selectedstruct '.' cell2mat(selectedfields(i,:))]);
            end
            
        %Generates legend name removing _ and replacing with spaces
        displayname = regexprep(cell2mat([selectedstruct ' ' selectedfields(i,:)]),'_',' ');
        
        %Verifies the length of the time and data variables to plot.
        %If the length is not correct it generates a time variable based
        %on the frequency of the data.
        if length(timevar) == length(variable)
            plot(timevar,variable,'DisplayName',displayname);
        else
            Fs = length(variable)/(timevar(end)-timevar(1)); %sampling frequency
            if Fs < 75 
                timevector = [0:1/round(Fs):((length(variable)-1)/round(Fs))];
                plot(timevector, variable,'DisplayName',displayname);
          
            elseif Fs >= 75 && Fs <= 125
                timevector = [0:1/round(Fs):((length(variable)-1)/round(Fs))];
                plot(timevector, variable,'DisplayName',displayname);
                
            elseif Fs > 150
                timevector = [0:1/round(Fs):((length(variable)-1)/round(Fs))];
                plot(timevector, variable,'DisplayName',displayname);
                
            end
        end
        %enables the dynamic legend and makes sure the data is visible.
        legend('-DynamicLegend','Location','Best');  
    end %end of the for loop to plot multiple variables
    %clear timevar temp*;
else
    fprintf('User Selected Cancel\n');
    return
end

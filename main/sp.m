%% Struct Plot 

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

%% run this
%this lists the available structs in the workspace to plot, choose from the
%list and it will plot available variables in the structure.
[selection,ok] = listdlg('ListString',validvars,'SelectionMode','single','Name','Struct Plotter','PromptString','Select a struct');

if ok
    selectedvar = eval(cell2mat(validvars(selection)));
else
    fprintf('User Selected Cancel\n');
    return
end


names = fieldnames(selectedvar);
time = regexp(names,'time');

for i = 1:length(time)
    if ~isempty(time{i})
        j = i;
    end
end
        
for i = 2:length(fieldnames(selectedvar))
    if ~isnan(mean(diff(selectedvar.(cell2mat(names(i))))))
        if length(selectedvar.(cell2mat(names(j)))) == length(selectedvar.(cell2mat(names(i))))
            figure('WindowStyle','docked','Name',cell2mat(names(i)));
            plot(selectedvar.(cell2mat(names(j)))-(min(selectedvar.(cell2mat(names(j))))),selectedvar.(cell2mat(names(i))));
            grid on;
            xlabel('time');
            legend(names(i));
        elseif length(selectedvar.(cell2mat(names(j)))) ~= length(selectedvar.(cell2mat(names(i))))
            figure('WindowStyle','docked','Name',cell2mat(names(i)));
            plot(selectedvar.(cell2mat(names(i))));
            grid on;
            xlabel('samples');
            legend(names(i));
        end 
    end
end

clear selectedvar selection i j ok validvars time;

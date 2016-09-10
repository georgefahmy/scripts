%% gains define
%This selects the gain/cap values from the telemetry file and stores them
%seperately. only used in telemetry file import.

if exist('pos_con_config','var')
temp = fieldnames(pos_con_config);
    for i = 1:length(temp)
       if ~isempty(temp{i,1}(regexp(temp{i,1},'_k')))
           gains.(cell2mat(temp(i))) = pos_con_config.(cell2mat(temp(i)));
           if length(gains.(cell2mat(temp(i)))) ~= 1
               gains.(cell2mat(temp(i))) = gains.(cell2mat(temp(i)));
           end
       end 
       if ~isempty(temp{i,1}(regexp(temp{i,1},'cap')))
           caps.(cell2mat(temp(i))) = pos_con_config.(cell2mat(temp(i)));
       end
    end
else
    fprintf('\npos_con_config file not found\n');
end

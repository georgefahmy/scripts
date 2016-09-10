%% structextractor
for i = 1:length(fields)
    var = fieldnames(eval(fields{1}));
    for j = 1:length(var)
    struct = eval(fields{i});
        assignin('base',[fields{i} '_' var{j}],struct.(var{j}));
    end
end
clear i j var struct
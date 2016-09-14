function previd = getprevid(filename)


fid = fopen(filename);

raw = textscan(fid,'%s','Delimiter',' ');
raw = raw{1,1};

temp = regexp(raw,'ID:');
j = 1;

for i = 1:length(temp)
    if ~isempty(cell2mat(temp(i)))
        previd(j,:) = str2double(cell2mat(raw(i+1)));
        j = j+1;
    end
end

clear temp;
fclose(fid);

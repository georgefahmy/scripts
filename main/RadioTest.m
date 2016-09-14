%% hex2dec script for radio checking
ccc;
run = [];
%%
raw = input('put the raw values here: ','s');
allchan = [];
temp = regexp(raw,',');

for i = 1:length(temp)
    hex = raw(temp(i)-2:temp(i)-1);
    dec = -hex2dec(hex);
    allchan(end+1) = dec;
end
figure;
bar(allchan,1,'grouped');
grid on;

run(end+1,:) = allchan;
bar(run',1,'grouped');

%%
fid = fopen('~/Desktop/radio_test','at+');
fprintf(fid,'%.0f, ', allchan);
fprintf(fid,'\n');
fprintf(fid,'\n');
fclose(fid);
disp(allchan);


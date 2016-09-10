function unixtodate(unix)

if nargin ~= 1
    error('enter unix timestamp')
end

if isfloat(unix)
    unix = unix;
else
    unix = str2num(unix);
end
date =  datestr(unix/86400 + datenum(1970,1,1)-7/24);
disp(date);
assignin('base','flightdate',date)

end



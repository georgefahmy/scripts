function unix = datetounix(yyyy,mm,dd,hr,min,sec)

date = datetime(yyyy,mm,dd,hr,min,sec);

unix = int32(floor(posixtime(date)))+28800-3600;
%takes the date and adds the 7 hour offset (in seconds) to ZULU time
end
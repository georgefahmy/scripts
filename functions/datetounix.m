function unix = datetounix(mm,dd,yyyy)

date = datetime(yyyy,mm,dd);

unix = int32(floor(posixtime(date)))+28800;
%takes the date and adds the 8 hour offset (in seconds) to ZULU time
end
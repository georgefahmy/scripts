function [accelx, accely, accelz] = accel_analysis(accel_data)

temp1 = regexp(accel_data,'accel.x');
temp2 = regexp(accel_data,'accel.y');
temp3 = regexp(accel_data,'accel.z');
for i = 1:length(temp1)
    if temp1{i} == 1
       accelx(i) = 1;
    end
    if temp2{i} == 1
       accely(i) = 1;
    end
    if temp3{i} == 1
        accelz(i) = 1;
    end
end

clear temp1 temp2 temp3;

accelx = accel_data(accelx == 1);
accely = accel_data(accely == 1);
accelz = accel_data(accelz == 1);

for i =1:length(accelx)
    temp1 = cell2mat(accelx(i));
    temp2(i) = str2double(temp1(10:end-1));
end
temp2 = temp2';
accelx = temp2;
clear temp*;

for i =1:length(accely)
    temp1 = cell2mat(accely(i));
    temp2(i) = str2double(temp1(10:end-1));
end
temp2 = temp2';
accely = temp2;
clear temp*;

for i =1:length(accelz)
    temp1 = cell2mat(accelz(i));
    temp2(i) = str2double(temp1(10:end-1));
end
temp2 = temp2';
accelz = temp2;
clear temp* i;

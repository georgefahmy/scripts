function tc(temp,units)
%%
% tc function accepts celcius or fahrenheit and converts it to the other.
% If there is no units given, the dividing line for the temperature is 50.
% assuming 50C and 51F. if units are given the dividing line is ignored and
% the conversion will take place on the given value and units.
% acceptable units are 'f' and 'c' 

if nargin < 2
    if temp > 50
        units = 'f';
    elseif temp <= 50
        units = 'c';
    end
end

if units == 'c'
    temp = temp*(9/5)+32;
    disp(temp);
end
if units == 'f'
    temp = (temp-32)*(5/9);
    disp(temp);
end
   
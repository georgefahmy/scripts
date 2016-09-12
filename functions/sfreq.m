function sfreq(variable,timevar)


    fs = length(variable)/(timevar(end)-timevar(1));
    fs = round(fs);

    fprintf('Sampling frequency is: %.2f\n',fs);
end
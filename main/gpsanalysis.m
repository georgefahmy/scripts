%% pvt data storage
hampvt = '/Users/georgeKespry/Documents/Projects/Matlab/Data/hamilton_gps_pvt';
cd (hampvt);

filestruct = dir(hampvt);
files = {'Names'};
j = 1;
for i = 1:length(filestruct)
    files{j,1} = char(strcat((filestruct(i).name)));
    j = j+1;
end
test = [];
jj = 1;
for i = 4:length(files)
    temp = cell2mat(files(i));
    temp2 = regexp(cell2mat(files(i)),'[.]');
    temp3 = regexp(cell2mat(files(i)),'[-]');
       
    variable = temp(1:temp2-1);
    variable = regexprep(variable,'[-]','_');
    temp4 = regexp(variable,'_');
    variable = variable(temp4(2)+1:end);
    variable = ['flight_' variable];
    file = [hampvt '/' temp];
    temp = importdata(file);
    
    if length(fieldnames(temp)) ~= 1
        for k = 1:length(temp.recv_timestamp)
            
            if temp.pDOP(k) == 9999
                temp.pDOP(k) = 0;
            end
        end
        %assignin('base',variable,temp.pDOP);
        pvtdata.(variable).pDOP = temp.pDOP;
        pvtdata.(variable).numSV = temp.numSV;
    end
        
end
save([hampvt '_data'],'pvtdata');


%% ratio
ratio = [];
ii = 1;
jj = 1;
flights = fieldnames(pvtdata);
for i = 1:length(flights)
    flight = flights{i};
    if min(pvtdata.(flight).pDOP) == 0
            lossflights{ii,:} = flight; %lost gps signal flights
            ii = ii+1;
    end
    temp = diff(pvtdata.(flight).pDOP); %noisy pdop signals
    ratio(jj,:) = (length(temp(temp~=0))/length(temp))*100;
    jj = jj+1;
end
totalpdop = [];
for i = 1:length(flights)
    totalpdop = [totalpdop; pvtdata.(flights{i}).pDOP];
end
    

figure;
h1 = histogram(totalpdop,'BinWidth',1);
set(gca,'YScale','log');


figure;
h2 = histogram(ratio,'BinWidth',1);
set(gca,'YScale','log');

%% 
ratiothreshold = 25;
noisypdopflights = flights(find(ratio > ratiothreshold));


figure;
hold on;
grid on;
for i = 1:length(lossflights)
    time = [0:1/5:(length(pvtdata.(lossflights{i}).numSV)-1)/5]';
%     plot(time,pvtdata.(lossflight{i}).pDOP)
    plot(time,pvtdata.(lossflights{i}).numSV);
    
    
end

figure;
hold on;
grid on;

for i = 1:length(noisypdopflights)
    
    time = [0:1/5:(length(pvtdata.(noisypdopflights{i}).numSV)-1)/5]';
   
    plot(time,pvtdata.(noisypdopflights{i}).pDOP);
    plot(time,pvtdata.(noisypdopflights{i}).numSV);
    
end

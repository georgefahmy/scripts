function [meta_data] = meta_data_analysis(meta)
%% flight id
ind = ~cellfun(@isempty,regexp(meta,'flight_id :'));
temp = meta(ind);
if ~isempty(temp)
    temp2 = regexp(temp{1,1},': ');
    flightid = (temp{1,1}(temp2+2:end-1));
end

%% home location 
ind = ~cellfun(@isempty,regexp(meta,'lat :'));
temp = meta(ind);
if ~isempty(temp)
    temp2 = regexp(temp{1,1},': ');
    lat = str2double(temp{1,1}(temp2+1:end-1));
end

ind = ~cellfun(@isempty,regexp(meta,'lng :'));
temp = meta(ind);
if ~isempty(temp)
    temp2 = regexp(temp{1,1},': ');
    long = str2double(temp{1,1}(temp2+1:end-1));
end

if exist('lat','var') && exist('long','var')
    home = [long lat];
else 
    home = [0 0];
end

%% capture height and object height

ind = ~cellfun(@isempty,regexp(meta,'image_capture_height : '));
temp = meta(ind);
if ~isempty(temp)
    temp2 = regexp(temp{1,1},': ');
    capture_height = str2double(temp{1,1}(temp2+1:end-1));
end

ind = ~cellfun(@isempty,regexp(meta,'object_height : '));
temp = meta(ind);
if ~isempty(temp)
    temp2 = regexp(temp{1,1},': ');
    object_height = str2double(temp{1,1}(temp2+1:end-1));
end
if ~exist('object_height','var')
    object_height = 0;
end
if ~exist('capture_height','var')
    capture_height = 0;
end

%% z altitude

ind = ~cellfun(@isempty,regexp(meta,'z : '));
temp = meta(ind);
if ~isempty(temp)
    temp2 = regexp(temp{end,1},': ');
    z_alt = str2double(temp{end,1}(temp2+1:end-1));
end
if ~exist('z_alt','var')
    z_alt = 0;
end

%% software version

ind = ~cellfun(@isempty,regexp(meta,'drone_software_version : '));
temp = meta(ind);
if ~isempty(temp)
    temp2 = regexp(temp{1,1},': ');
    swversion = str2mat(temp{1,1}(temp2+1:end-1));
end
if ~exist('swversion','var')
    swversion = [''];
end

%% embedded version

ind = ~cellfun(@isempty,regexp(meta,'git_ver : '));
temp = meta(ind);
if ~isempty(temp)
    temp2 = regexp(temp{1,1},': ');
    embversion = str2mat(temp{1,1}(temp2+1:end-1));
end
if ~exist('embversion','var')
    embversion = [''];
end

%% mission polygon

ind = ~cellfun(@isempty,regexp(meta,'mission_polygon : '));
temp = meta(ind);
if ~isempty(temp)
    temp2 = regexp(temp{1,1},{'((','))'});
    poly = str2mat(temp{1,1}(temp2{1,1}+2:temp2{1,2}-1));
    poly = str2num(regexprep(poly,',','; '));
end
    
if ~exist('poly','var')
    poly = [0 0];
end

%% actual altitude
ind = ~cellfun(@isempty,regexp(meta,'alt : '));
temp = meta(ind);
temp = temp(2);
if ~isempty(temp)
    temp2 = regexp(temp{end,1},': ');
    act_alt = str2double(temp{end,1}(temp2+1:end-1));
end
if ~exist('z_alt','var')
    act_alt = 0;
end


%% final writing of variables

meta_data.flightid = flightid;
meta_data.home = home;
meta_data.poly = poly;
meta_data.capture = -capture_height;
meta_data.object = -object_height;
meta_data.file = meta;
meta_data.z_alt = z_alt;
meta_data.act_alt = act_alt;
meta_data.swversion = swversion;
meta_data.embversion = embversion;



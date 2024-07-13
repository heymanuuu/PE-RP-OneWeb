file_path = 'Pending Files';
fid = fopen(file_path, 'r');
data = textscan(fid, '%s', 'Delimiter', '\n');
fclose(fid);
groups = {};
for i = 1:length(data{1})
    line = data{1}{i};  
    if startsWith(line, 'orbit')
    [~, orbit_num] = strtok(line, 'orbit');
    orbit_num = 
      str2double(orbit_num(2:end));    
    groups{end+1, 1} = line;
    groups{end, 2} = {};
    groups{end, 3} = orbit_num;
    else
        groups{end, 2}(end+1) = {line};
    end
end

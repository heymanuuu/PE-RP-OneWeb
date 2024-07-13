file_path = 'Pending files';
fid = fopen(file_path, 'r');
unique_values = {};
value_counts = containers.Map;
while ~feof(fid)
    line = fgetl(fid);
    data = strsplit(line);
    if length(data) >= 3
     value = data{3};
     if ~any(strcmp(unique_values, 
     value))
     unique_values{end+1} = value;
     value_counts(value) = 1;
else
     value_counts(value) = value_counts(value) + 1;
        end
    end
end
keys = unique_values;
for i = 1:length(keys)
    key = keys{i};
    disp(num2str(
    value_counts(key)));
end
num_unique_values = length(unique_values);
disp( num2str(num_unique_values));
fclose(fid);

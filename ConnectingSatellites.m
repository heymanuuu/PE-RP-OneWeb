file_path = 'Pending files';
fid = fopen(file_path, 'r');
output_file_path = 'Processed files';
fid_out = fopen(output_file_path, 'w');
while ~feof(fid)
    line = fgetl(fid);
    if startsWith(line, 'orbit')
        fprintf(fid_out, '%s\n', line);
    else
        data = strsplit(line);
        if length(data) >= 3
            first_item = data{1};
            second_item = data{2};
            combined_data = [second_item '_' first_item];    
            fprintf(fid_out, '%s\n', combined_data);
        end
    end
end
fclose(fid);
fclose(fid_out);

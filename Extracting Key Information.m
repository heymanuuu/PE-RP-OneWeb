file_path = 'Pending files';
fid = fopen(file_path, 'r');
output_file_path = 'Processed files';
fid_out = fopen(output_file_path, 'w');
count = 0;
data_cell = cell(9, 1);
while ~feof(fid)
    data = fscanf(fid, '%s', 1);
    if ~isempty(data)
        count = count + 1;
        data_cell{count} = data;
        if count == 9
            fprintf(fid_out, '%s\t%s\t%s\n', data_cell{2}, data_cell{3}, data_cell{4});
            count = 0;
            data_cell = cell(9, 1);
        end
    end
end
fclose(fid);
fclose(fid_out);

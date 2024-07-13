file_path = 'Pending files';
fid = fopen(file_path, 'r');
file_content = fread(fid, '*char').';
fclose(fid);
file_content_processed = regexprep(file_content, '\s+', ' ');
output_file_path = 'Processed files';
fid = fopen(output_file_path, 'w');
fprintf(fid, '%s', file_content_processed);
fclose(fid);

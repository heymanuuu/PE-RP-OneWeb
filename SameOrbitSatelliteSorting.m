for i = 1:numel(lines)
    line = lines{i};
    if startsWith(line, 'ONEWEB-')
    is_processing_satellites = true;
        current_group{end+1} = line;
    else
    if is_processing_satellites
    sorted_satellites = 
    sort_satellites(
    current_group, root, scenario);
    for j = 1:numel(sorted_satellites)
         fprintf(fid_out, '%s\n', sorted_satellites{j});
        end
        current_group = {};
        is_processing_satellites 
        = false;
        end
        fprintf(fid_out, '%s\n', line);
    end
end
if is_processing_satellites && ~isempty(current_group)
    sorted_satellites = 
    sort_satellites(
    current_group, root, scenario);
    for j = 1:numel(sorted_satellites)
        fprintf(fid_out, '%s\n', sorted_satellites{j});
    end
end

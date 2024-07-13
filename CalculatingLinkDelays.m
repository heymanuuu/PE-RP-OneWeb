for i = 1:length(link_items)
fileDelay = fopen('Pending Files', 'a');
    item = link_items{i};  
    matches = regexp(item, oneweb_regex, 'match');
    num_matches = length(matches);
    if num_matches == 2
        satellite1 = matches{1};
        satellite2 = matches{2}; 
        newContent = [satellite1,' ',satellite2,' '];
        disp(newContent);
        fprintf(fileDelay, newContent);
        fprintf('ccalculateDelay of co-directional orbit: %s %s\n', satellite1, satellite2);
        calculateDistanceAndDelay(
        uiApplication, satellite1, satellite2, '23 May 2024 04:00:00.000');
    end
       fclose(fileDelay);
end

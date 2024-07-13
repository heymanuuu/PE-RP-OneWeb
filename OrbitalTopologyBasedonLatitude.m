fileID = fopen('Pending Files','r');
C = textscan(fileID,'%s');
fclose(fileID);
textData = C{1};
reverseTextData = flipud(textData);
fileID = fopen('Temporary Files', 'w');
for i = 1:length(reverseTextData)
    fprintf(fileID, '%s\n', reverseTextData{i});
end
fclose(fileID);

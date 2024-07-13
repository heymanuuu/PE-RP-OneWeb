for i = 1:length(data{1})
    line = data{1}{i};
    if contains(line, 'orbit')
        if ~isempty(currentOrbit)&&
        ~isempty(satelliteNames)
            orbits{end+1} = struct('name', currentOrbit, 'satellites', {satelliteNames});
        end     
        currentOrbit = line;
        satelliteNames = {};
    else
        satelliteNames{end+1} = line;
    end
end
if ~isempty(currentOrbit) && ~isempty(satelliteNames)
    orbits{end+1} = struct('name', currentOrbit, 'satellites', {satelliteNames});
end
for i = 1:length(orbits)-1
    createChainsBetweenOrbits(root,
    scenario, orbits{i}, orbits{i+1});
end

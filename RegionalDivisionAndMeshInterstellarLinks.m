function createChainForOrbit(root, scenario, orbitName, satelliteNames)
    for j = 1:length(satelliteNames)-1
        satellite1Path = 
        ['*/oneweb1/Satellite/', 
        satelliteNames{j}];
        satellite2Path = 
        ['*/oneweb1/Satellite/', 
        satelliteNames{j+1}];
        satellite1 = 
        root.GetObjectFromPath(
        satellite1Path);
        satellite2 = 
        root.GetObjectFromPath(
        satellite2Path);     
        disp(['Satellite 1 (' satelliteNames{j} '): ' satellite1.Path]);
        disp(['Satellite 2 (' satelliteNames{j+1} '): ' satellite2.Path]);
        chainName = [orbitName '_' satelliteNames{j} '_' satelliteNames{j+1}];     
        chain = 
        scenario.Children.New(
        'eChain',chainName);
        chain.Objects.Add(
        satellite1.Path);
        chain.Objects.Add(
        satellite2.Path);
    end
       satellite1Path = 
       ['*/oneweb1/Satellite/',
       satelliteNames{end}];
    satellite2Path = ['*/oneweb1/Satellite/', satelliteNames{1}];
    satellite1 = root.GetObjectFromPath(
    satellite1Path);
    satellite2 = root.GetObjectFromPath(
    satellite2Path);
    disp(['Satellite 1 (' satelliteNames{end} '): ' satellite1.Path]);
    disp(['Satellite 2 (' satelliteNames{1} '): ' satellite2.Path]);
    chainName = [orbitName '_' satelliteNames{end} '_' satelliteNames{1}];
    chain = scenario.Children.New(
    'eChain', chainName);
    chain.Objects.Add(
    satellite1.Path);
    chain.Objects.Add(
    satellite2.Path);
end

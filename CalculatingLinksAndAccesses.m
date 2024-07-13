uiApplication = actxGetRunningServer(
'STK11.Application');
root = uiApplication.Personality2;
scenario = root.CurrentScenario;
satpathcollection = root.ExecuteCommand(
'ShowNames * Class Chain');
filename = 'Pending Fles';
fileID = fopen(filename, 'w');
fprintf(fileID, '%s\n', char(
satpathcollection.Item(0)));
fclose(fileID);

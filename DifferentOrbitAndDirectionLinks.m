for i = 1:min(length(satellite_names1), 
length(satellite_names2))
    satellite1 = satellite_names1{i};
    satellite2 = satellite_names2{i};
    stk_command = ['Access */oneweb1/Satellite/', satellite1, ' */oneweb1/Satellite/', satellite2];
    root.ExecuteCommand(
    stk_command);
end

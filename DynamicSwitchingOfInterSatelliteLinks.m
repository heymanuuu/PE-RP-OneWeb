t1 = timer;
t1.StartDelay = 210;
t1.TimerFcn = @printMessage;
start(t1);
function printMessage(~, ~)
    t = timer('TimerFcn', @(~,~) asyncExecution(), 'Period', 300, 'ExecutionMode', 'fixedRate');
    start(t);
end
function asyncExecution()
    moveFirstFourLinesToEnd(
    'Pending Files');
    calculateDistanceAndDelay();
    computeAccess();
    clearAccess();    
end

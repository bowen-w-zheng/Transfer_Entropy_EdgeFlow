function TE = transfer_entropy_KSG(Dest, Source, n, m, tau)
%%%
% Calculate the transfer entropy from Y to X
% X: Expecting a k by p matrix, where k is the number of iterations and p
% is the number of channels for the destination
% Y: Expecting a k by q matrix, where k is the number of iterations and q 
% is the number of channels for the source
    
    [~,p] = size(Dest);  
    [~,q] = size(Source);
    % Create a TE calculator and run it:
    teCalc=javaObject('infodynamics.measures.continuous.kraskov.TransferEntropyCalculatorMultiVariateKraskov');
    % Initialize the calculator
    teCalc.initialise(q, p); 
    % Set calculator parameters:
    teCalc.setProperty('NORMALISE', 'true');
    teCalc.setProperty('k', '4'); % Use Kraskov parameter K=4 for 4 nearest points
    teCalc.setProperty('k_HISTORY', string(n)); % Use Dest history of 2 time steps
    teCalc.setProperty('k_TAU', string(tau)); % Use history time interval of tau
    teCalc.setProperty('l_HISTORY',  string(m));
    teCalc.setProperty('l_TAU', string(tau));
    % Add observations
    teCalc.setObservations(octaveToJavaDoubleMatrix(Source), octaveToJavaDoubleMatrix(Dest));
    % Perform calculation with correlated source:
    TE = teCalc.computeAverageLocalOfObservations();

end 
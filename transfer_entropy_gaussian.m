function TE = transfer_entropy_Gaussian(Dest, Source, n, m, tau)
%%%
% Calculate the transfer entropy from Y to X
% X: Expecting a k by p matrix, where k is the number of iterations and p
% is the number of channels for the destination
% Y: Expecting a k by q matrix, where k is the number of iterations and q 
% is the number of channels for the source
    [~,p] = size(Dest);  
    [~,q] = size(Source);
    % Create a TE calculator and run it:
    teCalc=javaObject('infodynamics.measures.continuous.gaussian.TransferEntropyCalculatorMultiVariateGaussian');
    % Set calculator parameters:
    teCalc.setProperty('NORMALISE', 'true');
    teCalc.setProperty('k_HISTORY', string(n)); % Use Dest history of 2 time steps
    teCalc.setProperty('k_TAU', string(tau)); % Use history time interval of tau
    teCalc.setProperty('l_HISTORY',  string(m));
    teCalc.setProperty('l_TAU', string(tau));
    % Initialize the calculator
    teCalc.initialise(q, p); 
    % Add observations
    teCalc.setObservations(octaveToJavaDoubleMatrix(Source), octaveToJavaDoubleMatrix(Dest));
    % Perform calculation with correlated source:
    TE = teCalc.computeAverageLocalOfObservations();

end 
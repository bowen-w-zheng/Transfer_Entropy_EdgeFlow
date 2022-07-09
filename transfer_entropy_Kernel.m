function TE = transfer_entropy_Kernel(Dest, Source, n, m, tau)
%%%
% Calculate the transfer entropy from Y to X
% X: Expecting a k by p matrix, where k is the number of iterations and p
% is the number of channels for the destination
% Y: Expecting a k by q matrix, where k is the number of iterations and q 
% is the number of channels for the source
 
    [~,p] = size(Dest);  
    [~,q] = size(Source);
    % Create a TE calculator and run it:
    teCalc=javaObject('infodynamics.measures.continuous.kernel.TransferEntropyCalculatorMultiVariateKernel');
    % Set calculator parameters:
    teCalc.setProperty('NORMALISE', 'true');
    teCalc.setProperty('KERNEL_WIDTH', '0.35');
    % Initialize the calculator
    teCalc.initialise(n, q, p); 
    % Add observations
    teCalc.setObservations(octaveToJavaDoubleMatrix(Source), octaveToJavaDoubleMatrix(Dest));
    % Perform calculation with correlated source:
    TE = teCalc.computeAverageLocalOfObservations();

end 
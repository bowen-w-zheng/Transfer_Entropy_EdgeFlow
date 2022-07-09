function TE = transfer_entropy_Binary(Dest, Source, n, m, tau)
%%%
% Calculate the transfer entropy from Y to X
% X: Expecting a k by p matrix, where k is the number of iterations and p
% is the number of channels for the destination
% Y: Expecting a k by q matrix, where k is the number of iterations and q 
% is the number of channels for the source
    
    [~,p] = size(Dest);  
    [~,q] = size(Source);
    % Create a TE calculator and run it:
    teCalc=javaObject('infodynamics.measures.discrete.TransferEntropyCalculatorDiscrete', 2^max(p,q), n, tau, m, tau, 1);
    teCalc.initialise();
    % We need to construct the joint values of the dest and source before we pass them in,
    %  and need to use the matrix conversion routine when calling from Matlab/Octave:
    mUtils= javaObject('infodynamics.utils.MatrixUtils');
    teCalc.addObservations(mUtils.computeCombinedValues(octaveToJavaIntMatrix(Source), 2),mUtils.computeCombinedValues(octaveToJavaIntMatrix(Dest), 2)); % 2 here is the base
    TE = teCalc.computeAverageLocalOfObservations();

end 
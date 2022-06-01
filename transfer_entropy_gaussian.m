function TE = transfer_entropy_gaussian(X,Y,Z)
%%%
% Calculate the transfer entropy at a specific time
% X: Expecting a vector, each entry is an outcome from each trial
% Y: Expecting a k by n matrix, where k is the number of runs and n is the
% number of time steps 
% Z: Expecting a k by m matrix, where k is the number of runs and m is the
% number of time steps 
%%%
    det_X = var(X);
    det_YZ = det(cov([Y,Z]));
    det_XYZ = det(cov([X,Y,Z])); 
    I_X_YZ = 1/2 * (log(det_X * det_YZ/det_XYZ));
    det_Z = det(cov(Z));
    det_XZ = det(cov([X,Z]));
    I_X_Z = 1/2 * (log(det_X * det_Z/det_XZ));
    TE = I_X_YZ - I_X_Z;
end 
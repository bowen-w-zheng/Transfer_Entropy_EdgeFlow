function TE = transfer_entropy_main(X,Y,n,m)
%%%
% Calculate the transfer entropy from Y to X for the whole time series
% X: expecting a k by t matrix for multiple runs of a random process,
%    where k is the number of runs and t is the total time steps; 
% Y: expecting a k by t matrix for multiple runs of a random process,
%    where k is the number of runs and t is the total time steps; 
% n: expecting an integer, how many time steps of past history for X
% m: expecting an integer, how many time steps of past history for Y
%%%

    [~,step] = size(X);
    TE = zeros(1, step-n);
    for i = 1:step-n
        X_t = X(:,i+n);
        Y_m = Y(:,i+n-m:i+n-1);
        X_n = X(:,i:i+n-1);
        TE(i) = transfer_entropy_gaussian(X_t,Y_m,X_n);
    end
end 
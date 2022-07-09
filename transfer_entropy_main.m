function TE = transfer_entropy_main(Dest,Source,n,m,tau, method)
%%%
% Calculate the transfer entropy from Y to X for the whole time series
% X: expecting a k by t matrix for multiple runs of a random process,
%    where k is the number of runs and t is the total time steps; 
% Y: expecting a k by t matrix for multiple runs of a random process,
%    where k is the number of runs and t is the total time steps; 
% n: expecting an integer, how many time steps of past history for X
% m: expecting an integer, how many time steps of past history for Y
%%%
    javaaddpath('D:\Transfer_Entropy\infodynamics-dist-1.5/infodynamics.jar')
    if method == "Gaussian"
        TE = transfer_entropy_Gaussian(Dest, Source, n, m, tau);
    end 
    if method == "KSG"
        TE = transfer_entropy_KSG(Dest, Source, n, m, tau);
    end 
    if method == "Kernel"
        TE = transfer_entropy_Kernel(Dest, Source, n, m, tau);
    end 
    if method == "Binary"
        TE = transfer_entropy_Binary(Dest, Source, n, m, tau);
    end 
end

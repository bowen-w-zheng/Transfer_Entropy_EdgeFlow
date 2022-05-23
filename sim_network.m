function [r,g,p,s] = sim_network(W, c, transfer_func, SampleTime, dt, sim_num)
%%%%%

% W: Expecting a square matrix. W_{j,i} represents the weights from neuron i to neuron j. This should be the connection weight matrix. 
% c: Expecting real number. This is the intensity of common inputs to all neurons (signal scaled by sqrt(c)). Note that private noise
% will be scaled by sqrt(1-c)
% transfer_func: Expecting a function. This is the choice of transfer_func, from R to R
% SampleTime
% dt

%%%%%

% Initialize neural net
time_step = 0:dt:SampleTime;
[n,~] = size(W); 
r = zeros(n, length(time_step), sim_num);

% Prepare the signal 
g = normrnd(0,1,1, length(time_step),sim_num); % common drive
p = normrnd(0,1,n, length(time_step),sim_num); % private drive
s = dt*(sqrt(c) * g + sqrt(1-c) *(p)); 

% Updating rule 
update_rule = @(r, s, W) r + transfer_func(W * r + s);

for n = 1:sim_num
    % n
% Run process forward
for i = 1:(length(time_step) - 1)
    r(:,i+1,n) = update_rule(r(:,i,n), s(:,i,n), W);
end 
end 

end 
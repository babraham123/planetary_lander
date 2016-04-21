% Kinematics, Dynamics and Control
% Planetary Lander, Rocket Descent

numIter = 10000;
T = 1;
dt = T/numIter;
tspan = linspace(0, T, numIter+1);

% follow trajectory
% load('trajectory.csv');
% interp

% reach destination
% calculate guidance

% hover
x_0 = [0, 0, 100]';
x_d = repmat(x_0, 2, numIter+1);

% differentiate
v_d = diff(x_d);
a_d = diff(v_d);

% desired state
x_d = [x_d(2:numIter+1); v_d]; 

attitudeFreq = 100;
positionFreq = attitudeFreq * 100;
% fixed interval ODE solver
X = ode5(@dynamicsAndControl, tspan, x_0, x_d, attitudeFreq, positionFreq);

% simulate
% figure;
% plot(tspan, X);

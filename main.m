% Kinematics, Dynamics, and Control (16-711)
% Bereket Abraham, Laura Fleury
% Final Project
% Rocket Powered Descent Simulation
close all
clear
clc

% load constant parameters
consts = get_consts();

% x    = x,y,z, vx,vy,vz, phi,theta,psi, dphi,dtheta,dpsi
x0 = [-20,20,10, 0,0,0, 0,0,0, 0,0,0]';
T = linspace(consts.trange(1), consts.trange(2), consts.nIter);

% generate trajectory of desired positions, xd = [x y z psi]
trajectory = guidance(x0, 'circl');

% interpolate and differentiate
xd = interp1(trajectory(1,:)', trajectory(2:end,:)', T', 'pchip');

td = repmat(T', [1, 4]);
vd = diff(xd) ./ diff(td);
ad = diff(vd) ./ diff(td(1:end-1,:));
vd = vd'; ad = ad';
vd(:,end+1) = [0 0 0 0]';
ad(:,end+1) = [0 0 0 0]'; ad(:,end+1) = [0 0 0 0]';
trajectory = [xd'; vd; ad]; %trajectory = time, x,y,z,psi, dx,dy,dz,dpsi, ddx,ddy,ddz,ddpsi 

% calculate gains for PD control, [Kp; Kd]
K = calculateGains(consts);

% Integrate system
[X, Xd, U] = simulate(T, x0, trajectory, consts, K);

% x    = x,y,z, phi,theta,psi
[ISE, MSE, IAE, ITAE] = calc_performance(T, X, Xd);
disp(['Score [ISE, MSE, IAE, ITAE]: \n' mat2str([ISE, MSE, IAE, ITAE])]);

% Plots
plotResults(T, X, Xd, U);

% Animation
animate3(T, X, Xd, U);


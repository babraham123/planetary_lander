% Kinematics, Dynamics, and Control (16-711)
% Bereket Abraham, Laura Fleury
% Final Project
% Rocket Powered Descent Simulation
close all
clear
clc

% load constant parameters
consts = get_consts();

% x = x,y,z, vx,vy,vz, theta,phi,psi, wx,wy,wz
x0 = [10,10,10, 0,0,0, 0,0,0, 0,0,0]';
T = linspace(consts.trange(1), consts.trange(2), consts.nIter);

% generate trajectory of desired positions, xd = [x y z psi]
trajectory = guidance(x0, 'xline');
%trajectory = trajectory(2:4,:);

% interpolate and differentiate
xd = interp1(trajectory(1,:)', trajectory(2:end,:)', T', 'pchip');

td = repmat(T', [1, 4]);
vd = diff(xd) ./ diff(td);
ad = diff(vd) ./ diff(td(1:end-1,:));
xd = xd'; vd = vd'; ad = ad';
vd(:,end+1) = [0 0 0 0]';
ad(:,end+1) = [0 0 0 0]'; ad(:,end+1) = [0 0 0 0]';

% trajectory = [xd; vd; ad];
trajectory = [xd'; vd; ad]; %trajectory = time, x,y,z,phi, dx,dy,dz,dphi, ddx,ddy,ddz,ddphi 

% calculate gains for PD control, [Kp; Kd]
K = calculateGains(consts);

% Integrate system
[X, Xd, U] = simulate(T, x0, trajectory, consts, K);

% J = compute_score(T, X, trajectory, consts);
% disp(['Score: ' num2str(J)]) ;

% Plots
plotResults(T, X, Xd, U);

% Animation
% animate3(T, X, Xd, U);


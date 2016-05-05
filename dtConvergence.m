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

% generate trajectory of desired positions, xd = [x y z psi]
trajectory = guidance(x0, 'circl', consts);

Hz = [500 1000 2500 5000];
state = {};
for k=1:length(Hz)
	consts.nIter = (consts.trange(2) - consts.trange(1)) * Hz(k);
	T = linspace(consts.trange(1), consts.trange(2), consts.nIter);
	% interpolate and differentiate
	xd = interp1(trajectory(1,:)', trajectory(2:end,:)', T', 'pchip');

	td = repmat(T', [1, 4]);
	vd = diff(xd) ./ diff(td);
	ad = diff(vd) ./ diff(td(1:end-1,:));
	vd = vd'; ad = ad';
	vd(:,end+1) = [0 0 0 0]';
	ad(:,end+1) = [0 0 0 0]'; ad(:,end+1) = [0 0 0 0]';
	trajectory = [xd'; vd; ad]; %trajectory = time, x,y,z,psi, dx,dy,dz,dpsi, ddx,ddy,ddz,ddpsi 

	[X, Xd, U, Ud, Ft] = simulate(T, x0, trajectory, consts, 1);
	%[~, mse, ~, ~] = calc_performance(T, X, Xd);
	state = [state {[T; X]}];
end

figure;
grid on;
hold on;
for k=1:length(Hz)
	TX = state{k};
    plot(TX(1,:), TX(2,:));
end
xlabel('time (s)');
ylabel('X (m)');
title('X Position over different dt');
legend({'Hz = 500', '     1000', '     2500', '     5000'});
hold off;

figure;
grid on;
hold on;
for k=1:length(Hz)
	TX = state{k};
    plot(TX(1,:), TX(4,:));
end
xlabel('time (s)');
ylabel('Z (m)');
title('Z Position over different dt');
legend({'Hz = 500', '     1000', '     2500', '     5000'});
hold off;


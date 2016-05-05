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
trajectory = guidance(x0, 'circl', consts);

% interpolate and differentiate
xd = interp1(trajectory(1,:)', trajectory(2:end,:)', T', 'pchip');

td = repmat(T', [1, 4]);
vd = diff(xd) ./ diff(td);
ad = diff(vd) ./ diff(td(1:end-1,:));
vd = vd'; ad = ad';
vd(:,end+1) = [0 0 0 0]';
ad(:,end+1) = [0 0 0 0]'; ad(:,end+1) = [0 0 0 0]';
trajectory = [xd'; vd; ad]; %trajectory = time, x,y,z,psi, dx,dy,dz,dpsi, ddx,ddy,ddz,ddpsi 

% range = 0.25:0.25:2;
% gains = range .* consts.K(1);
% MSE = []; ISE = []; posErr = []; Ft_tot = [];
% for k=1:length(gains)
%     consts.K(1) = gains(k);
%     consts.K(2) = gains(k);
%     [X, Xd, U, Ud, Ft] = simulate(T, x0, trajectory, consts);
%     [ise, mse, ~, ~] = calc_performance(T, X, Xd);
%     ISE = [ISE, ise];
%     MSE = [MSE, mse];
%     posErr(:,:,k) = Xd(1:3,:) - X(1:3,:);
%     Ft_tot(k,:) = sum(Ft, 1);
% end
% plotGains(ISE, MSE, T, posErr, Ft_tot, gains);

range = 0.25:0.25:2;
gains = range .* consts.K(4);
MSEkd = zeros(length(gains), 3);
for cc=1:3
    for k=1:length(gains)
        consts.K(4) = gains(k);
        consts.K(5) = gains(k);
        [X, Xd, U, Ud, Ft] = simulate(T, x0, trajectory, consts, cc);
        [~, mse, ~, ~] = calc_performance(T, X, Xd);
        MSEkd(k,cc) = norm(mse(1:3));
        disp(num2str(MSEkd(k,cc)))
    end
end

figure;
grid on;
hold on;
for cc=1:3
    plot(gains', MSEkd(:,cc));
end
xlabel('gain');
ylabel('MSE (m^2)');
title('L2 Norm of the Position MSE vs Kd,xy gain');
legend({'linear', 'geometric', 'weighted geometric'});
hold off;


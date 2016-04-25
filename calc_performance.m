function [ISE, MSE, IAE, ITAE] = calc_performance(T, X, Xd)
% x    = x,y,z, vx,vy,vz, phi,theta,psi, dphi,dtheta,dpsi

x_error = Xd(1:3,:) - X(1:3,:);
angle_error = Xd(7:9,:) - X(7:9,:);
err = [x_error; angle_error];

ISE = sum(err.^2, 2);
n = size(T,2);
MSE = ISE./n;

T = [T;T;T;T;T;T];
IAE = sum(abs(err), 2);
ITAE = sum(T .* abs(err), 2);

end

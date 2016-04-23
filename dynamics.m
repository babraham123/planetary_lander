function [xDot] = dynamics(X, U, consts) 
% x    = x,y,z, vx,vy,vz, theta,phi,psi, wx,wy,wz
% xDot = vx,vy,vz, ax,ay,az, wx,wy,wz, dwx,dwy,dwz
% u = f_b1, f_b2, f_b3, tx, ty, tz

% initialize variables
x = X(1:3);
v = X(4:6);
eulerAngles = X(7:9);
omega = X(10:12);
xDot = [];


end

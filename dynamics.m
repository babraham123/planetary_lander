function [xDot, omega] = dynamics(X, U, consts) 
% x    = x,y,z, vx,vy,vz, phi,theta,psi, dphi,dtheta,dpsi
% xDot = vx,vy,vz, ax,ay,az, dphi,dtheta,dpsi, dwx,dwy,dwz
% u = f_b1, f_b2, f_b3, tx, ty, tz,

% initialize variables
x = X(1:3);
v = X(4:6);
eulerAngles = X(7:9);
dEulerAngles = X(10:12);
force_body = U(1:3)
torque = U(4:6);

R = eulerToRot(eulerAngles);

%angular acceleration
omega = eulerToOmega(eulerAngles, dEulerAngles);
omegaDot = consts.I \ (torque - cross(omega, consts.I*omega));

%Spacial accelerations
force_spatial = (R'*force_body) - [0; 0; consts.mass*consts.g];
vDot = force_spatial./consts.mass;

xDot = [v; vDot; dEulerAngles; omegaDot];

end

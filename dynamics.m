function [xDot] = dynamics(X, U, consts) 
% x    = x,y,z, vx,vy,vz, theta,phi,psi, wx,wy,wz
% xDot = vx,vy,vz, ax,ay,az, wx,wy,wz, dwx,dwy,dwz
% u = f_b1, f_b2, f_b3, tx, ty, tz,

% initialize variables
x = X(1:3);
v = X(4:6);
eulerAngles = X(7:9);
omega = X(10:12);
force_body = U(1:3);
torque = U(4:6);


% State of rotation
c1 = cos(eulerAngles(1));
s1 = sin(eulerAngles(1));
c2 = cos(eulerAngles(2));
s2 = sin(eulerAngles(2));
c3 = cos(eulerAngles(3));
s3 = cos(eulerAngles(3));

R = [c3*c1-s2*s3*s1 -c2*c3 c3*s1+c1*s2*s3;
c1*s3+c3*s2*s1 c2*c3 s3*s1-c3*c1*s2;
-c2*s1 s2 c2*c2];
Adj = [R zeros(3);
zeros(3) R];

%angular acceleration
omegaDot = I\(torque - cross(omega,omega*I));

%Spacial accelerations
force_spatial = Adj*force_body;
vDot = force_spatial/mass;

xDot = [v; vDot; omega; omegaDot];


end
